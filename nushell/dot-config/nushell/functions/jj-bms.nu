# jj bms - Output `jj bookmark list` as a Nushell table
#
# This function runs `jj bookmark list` and parses its output into a structured
# table. It attaches status and remote lines (such as “  @origin ...”) as a
# `metadata` field to the previous bookmark entry.
#
# ### Output Columns
#
#   - name:        The bookmark name
#   - change_id:   The symbolic change or branch ID
#   - commit_id:   The commit hash
#   - description: A short commit description
#   - metadata:    List of status/remote lines for this bookmark (can be empty)
#
# ### Usage
#
# ```nu
# jj bms
# ```
#
# ### Example:
#
# Given this `jj bookmark list` output:
#
# ```
# main: bbccddee cafebabe feat: create new stuff
#   @origin (behind by 3 commits): aabbccdd deadbeef fix: get rid of bug
# ```
#
# Then `jj bms` would create a table like this:
#
# ```
# ╭───┬──────┬───────────┬───────────┬────────────────────────┬────────────────╮
# │ # │ name │ change_id │ commit_id │      description       │    metadata    │
# ├───┼──────┼───────────┼───────────┼────────────────────────┼────────────────┤
# │ 0 │ main │ bbccddee  │ cafebabe  │ feat: create new stuff │ [list 1 item]  │
# ╰───┴──────┴───────────┴───────────┴────────────────────────┴────────────────╯
# ```
#
# where the `metadata` column will look like this:
#
# ```
# ╭───┬────────────────────────────────────────────────────────────────────────────────────╮
# │ 0 │ @origin (behind by 3 commits): aabb 3402f804 Neovim: Fix tree-sitter configuration │
# ╰───┴────────────────────────────────────────────────────────────────────────────────────╯
# ```
export def "jj bms" [] {
  let bookmark_lines = jj bookmark list | lines

  $bookmark_lines | reduce --fold [] { | line, acc |
    # Metadata lines are indented, e.g., “  @origin”.
    let line_is_meta = ($line | str starts-with "  ")

    if $line_is_meta {
      let trimmed = ($line | str trim)
      let len = ($acc | length)

      if $len == 0 { return $acc }

      let idx = ($len - 1)
      let last = ($acc | get $idx)
      let oldmeta = (try { $last | get metadata } catch { [] })
      let updated = ($last | update metadata ($oldmeta | append $trimmed))

      ($acc | update $idx $updated)
    } else {
      let parsed = ($line | parse "{name}: {change_id} {commit_id} {description}")
      if ($parsed | is-empty) {
        $acc
      } else {
        ($acc | append ($parsed | get 0 | insert metadata []))
      }
    }
  }
}
