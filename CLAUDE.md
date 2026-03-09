# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

GNU Stow-based dotfiles repository. Each top-level directory is a **stow package** that can be independently symlinked to `$HOME`.

## Stow Commands

```sh
stow --dotfiles <package>      # Symlink a single package
stow --dotfiles */             # Symlink all packages
stow --dotfiles --adopt <pkg>  # Adopt existing files into repo (overwrites repo content)
```

The `--dotfiles` flag causes `dot-` prefixed files/dirs to be symlinked as hidden files (e.g., `dot-config` → `.config`).

## Commit Message Convention

```
<Tool/Category>: <Action description>
```

Examples: `Neovim: Add keymap for X`, `Kitty: Update theme`, `Git: Add alias for Y`

## Architecture

### Package Structure

Each package mirrors the home directory hierarchy. For example:
- `neovim/dot-config/nvim/` → `~/.config/nvim/`
- `git/dot-config/git/` → `~/.config/git/`
- `kitty/dot-config/kitty/` → `~/.config/kitty/`

### Neovim Config

Entry point: `neovim/dot-config/nvim/init.lua`

- `lua/config/` — Core options and keymaps
- `lua/plugins/` — Plugin specs, numbered for load order (e.g., `00-specs.lua`, `99-ai.lua`)
- `lua/plugins/ai/` — AI plugin sub-configs (codecompanion, etc.)

### Private/Secret Pattern

Several packages support local overrides not tracked in git:
- Git: `~/.config/git/private` (template at `git/dot-config/git/private.tmpl`)
- Nushell: `~/.config/nushell/env.private.nu` (loaded if it exists)

### Git Config

Split into modular includes: `aliases`, `colors`, `github`, `private`. GPG signing enabled using SSH format.
