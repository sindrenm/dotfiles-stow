# Creates a GitHub Pull Request from the current Jujutsu repository.
#
# This command requires at least two bookmarks. It prompts the user to input a
# Jira ticket number, a target branch, and a base branch. It also prompts for a
# PR title and body, which default to the current commit message. The file
# editor defaults to `nvim` if no environment editor is set. Finally, it
# prompts for labels and executes the GitHub CLI to create the PR.
export def 'jj gh pr create' [] : nothing -> nothing {
  let bookmarks = (
    jj log
      --revisions 'bookmarks()'
      --no-graph
      --template 'bookmarks.map(|b| b.name()).join("\n") ++ "\n"'
    | lines
    | where $it != ''
  )

  if ($bookmarks | length) < 2 {
    print 'Cannot create a PR with less than two bookmarks.'
    return
  }

  let jira_ticket = input 'Enter Jira ticket number: '

  let head_branch = $bookmarks | input list 'Select target branch'

  let available_base_branches = $bookmarks | where $it != $head_branch
  let base_branch = $available_base_branches | input list 'Select base branch'

  let commit_msg = jj log --revisions $head_branch --no-graph --template 'description'
  let title = prompt-title --jira-ticket $jira_ticket $commit_msg 
  let body = prompt-body $commit_msg

  let labels = prompt-labels
  let assignee = '@me'

  (
    run-gh-cli 
      --head-branch $head_branch
      --base-branch $base_branch
      --title $title
      --body $body
      --assignee $assignee
      --labels $labels
  )
}

# Prompts for the title of the PR, defaulting to the commit message summary.
def prompt-title [
  --jira-ticket: string
  commit_msg: string,
] : nothing -> string {
  let default_title = $commit_msg | lines | first
  let title = input --default $default_title $'Enter title: ($jira_ticket): '

  $'($jira_ticket): ($title)'
}

# Prompts the user to enter a PR description, defaulting to the description in
# the provided commit message.
def prompt-body [commit_msg: string] : nothing -> string {
  input 'Click [Enter] to open your editor for the PR description ...' | ignore

  let default_body = $commit_msg | lines | skip 2 | str join "\n"
  let tmp_file = mktemp --tmpdir --suffix .md
  $default_body | save --force $tmp_file

  edit-file $tmp_file

  open $tmp_file
}

# Opens the file on the provided path in the user's default editor, or falls
# back to `nvim` if none is set.
def edit-file [path: string]: nothing -> nothing {
  let editor = $env.EDITOR? | default 'nvim' | split row ' '
  let editor_cmd = $editor | first
  let editor_args = $editor | skip 1

  ^$editor_cmd ...$editor_args $path
}

# Prompt for zero or more labels for the pull request, from a pre-defined list
# of available labels.
def prompt-labels [] : nothing -> list<string>  {
  let available = [
    'bugfix',
    'enhancement',
    'refactor', 
  ]

  $available | input list --multi 'Select labels'
}

# Build and run the `gh` command from the provided arguments.
def run-gh-cli [
  --head-branch: string,
  --base-branch: string,
  --title: string,
  --body: string,
  --assignee: string,
  --labels: list<string>,
] : nothing -> nothing {
  let label_flags = $labels | each { ['--label', $in] } | flatten

  let args = [
    'pr', 'create',
    '--head',     $head_branch,
    '--base',     $base_branch,
    '--title',    $title,
    '--body',     $body,
    '--assignee', $assignee,
    '--web'
  ] ++ $label_flags

  ^gh ...$args
}
