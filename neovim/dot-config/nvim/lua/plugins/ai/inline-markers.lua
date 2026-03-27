---@class CodeCompanion.InlineRequestEvent
---@field id number The ID of the request
---@field adapter { name: string, formatted_name: string, model: string } Adapter info for the request
---@field bufnr number The buffer number to apply the inline edits to
---@field buffer_context CodeCompanion.BufferContext
---@field interaction "inline" The type of interaction that triggered the request

--- @class CodeCompanion.InlineMarkerRequest
--- @field timer uv.uv_timer_t The libuv timer driving the spinner animation
--- @field bufnr number The buffer the extmarks are placed in
--- @field start_line number 0-based line index for the top extmark
--- @field end_line number 0-based line index for the bottom extmark
--- @field frame_idx number Current index into the spinner_frames table
--- @field ext1 number? Extmark ID for the virtual line above the selection
--- @field ext2 number? Extmark ID for the virtual line below the selection

--- Namespace used for all extmarks created by this module
local namespace_id = vim.api.nvim_create_namespace("CodeCompanionInlineProcessing")

--- Braille spinner animation frames, cycled through on each timer tick
local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

--- Tracks all in-flight inline requests, keyed by request ID
--- @type table<number, CodeCompanion.InlineMarkerRequest>
local active_requests = {}

--- Redraws the spinner extmarks for the given request, and advances the frame index.
--- @param request_id number
--- @return nil
local function update_extmarks(request_id)
  local request = active_requests[request_id]
  if not request then return end
  if not vim.api.nvim_buf_is_valid(request.bufnr) then return end

  local text = "Working " .. spinner_frames[request.frame_idx]
  local virt_lines = { { { text, "DiagnosticInfo" } } }

  request.ext1 = vim.api.nvim_buf_set_extmark(request.bufnr, namespace_id, request.start_line, 0, {
    virt_lines = virt_lines,
    virt_lines_above = true,
    id = request.ext1,
  })

  request.ext2 = vim.api.nvim_buf_set_extmark(request.bufnr, namespace_id, request.end_line, 0, {
    virt_lines = virt_lines,
    virt_lines_above = false,
    id = request.ext2,
  })

  request.frame_idx = (request.frame_idx % #spinner_frames) + 1
end

--- Registers a new active request and starts the spinner timer for it.
--- @param data CodeCompanion.InlineRequestEvent
--- @return nil
local function start_spinner(data)
  local timer = vim.uv.new_timer()
  if not timer then return end

  active_requests[data.id] = {
    timer = timer,
    bufnr = data.bufnr,
    start_line = data.buffer_context.start_line - 1,
    end_line = data.buffer_context.end_line - 1,
    frame_idx = 1,
  }

  -- Initial update before the timer fires
  update_extmarks(data.id)

  timer:start(100, 100, vim.schedule_wrap(function()
    if active_requests[data.id] then
      update_extmarks(data.id)
    end
  end))
end

local group = vim.api.nvim_create_augroup("CodeCompanionInlineMarkers", { clear = true })

--- Start a spinner when an inline request begins
vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "CodeCompanionRequestStarted",
  callback = function(args)
    --- @type CodeCompanion.InlineRequestEvent
    local data = args.data
    if data.interaction ~= "inline" then return end
    if not vim.api.nvim_buf_is_valid(data.bufnr) then return end

    start_spinner(data)
  end,
})

--- Stop the spinner and clean up extmarks when an inline request finishes
vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "CodeCompanionRequestFinished",
  callback = function(args)
    --- @type CodeCompanion.InlineRequestEvent
    local data = args.data
    if not active_requests[data.id] then return end

    local request = active_requests[data.id]
    if not request.timer:is_closing() then
      request.timer:stop()
      request.timer:close()
    end

    if vim.api.nvim_buf_is_valid(data.bufnr) then
      if request.ext1 then vim.api.nvim_buf_del_extmark(data.bufnr, namespace_id, request.ext1) end
      if request.ext2 then vim.api.nvim_buf_del_extmark(data.bufnr, namespace_id, request.ext2) end
    end

    active_requests[data.id] = nil
  end,
})
