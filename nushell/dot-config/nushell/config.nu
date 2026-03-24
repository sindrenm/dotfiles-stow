source ./themes/catppuccin/latte.nu

use std/util "path add"

use ~/.config/nushell/functions/from-interrupts.nu *
use ~/.config/nushell/functions/jj-bms.nu *
use ~/.config/nushell/functions/jj-gh-pr-create.nu *

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
path add "~/.local/bin"
