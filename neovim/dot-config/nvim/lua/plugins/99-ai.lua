require("codecompanion").setup({
  interactions = {
    chat = {
      adapter = "anthropic",
    },

    inline = {
      adapter = "anthropic",
      diff = {
        enabled = true,
      },
      keymaps = {
        accept_change = {
          modes = { n = "ga" },
          description = "Accept the suggested change",
        },
        reject_change = {
          modes = { n = "gr" },
          opts = { nowait = true },
          description = "Reject the suggested change",
        },
      },
    },

    cmd = {
      adapter = "anthropic",
    },

    background = {
      adapter = "anthropic",
    },
  },

  display = {
    render_diff = true,
    show_diff = true,

    action_palette = {
      opts = {
        show_preset_actions = true,
        show_preset_prompts = true,
        title = "CodeCompanion actions",
      },
    },
  },

  opts = {
    log_level = "DEBUG",
    show_spinner = true,
    virtual_text = " AI Generating...",
  },

  extensions = {
    history = {
      enabled = true,
    },
    spinner = {
      opts = {
        style = "fidget",
      },
    },
  },
})

require("plugins.ai.inline-markers")
