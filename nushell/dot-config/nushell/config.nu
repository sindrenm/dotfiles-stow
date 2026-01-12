use std/util "path add"
use ~/.config/nushell/functions/from-interrupts.nu *

# Output `jj bookmark list` as a nu table
def "jj bms" [] {
  jj bookmark list | lines | parse "{name}: {change_id} {commit_id} {description}"
}

# Shell aliases
alias l = eza;
alias ll = eza --long --git --icons;
alias lt = eza --long --git --icons --tree;
alias lt2 = eza --long --git --icons --tree --level 2;

# Source shell hooks

mkdir ($nu.data-dir | path join "vendor/autoload")

carapace _carapace nushell | save -f ($nu.data-dir | path join "vendor/autoload/carapace.nu")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")
atuin init nu | save -f ($nu.data-dir | path join "vendor/autoload/atuin.nu")

path add "~/.cargo/bin"
