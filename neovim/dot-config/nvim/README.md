# Neovim dotfiles

After installing all the plugins, here are some steps that currently must be
done manually:

## Configure kitty-scrollback.nvim

Generate Kitten and an alias for it

```bash
$ nvim --headless +'KittyScrollbackGenerateKittens'
```

Then, grab _only_ the `action_alias ...` line, and move it into a new file ./gen/kitty-scrollback-nvim.conf:

```bash
$ echo "action_alias ..." > ~/.config/kitty/kitty-scrollback-nvim.conf
```

## Configure smart-splits.nvim for Kitty

```bash
$ cd ~/.local/share/nvim/site/pack/core/opt/smart-splits.nvim
$ bash ./kitty/install-kittens.bash
```
