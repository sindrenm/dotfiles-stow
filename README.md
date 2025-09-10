# My GNU Stow Dotfiles

This repository contains my personal dotfiles, managed using [GNU Stow][1]. GNU
Stow is a symlink farm manager that makes it easy to organize configuration
files in a version-controlled directory and symlink them to their correct
locations in the home directory. This allows for a clean, modular, and portable
setup.

## Setup Instructions

These instructions assume you are on an Arch Linux-based system.

1. **Install GNU Stow:**

   ```
   sudo pacman -S stow
   ```

2. **Clone the Repository:**

   Clone this repository into a directory in your home folder. ~/.dotfiles is a common choice.

   ```
   git clone <repository_url> ~/.dotfiles
   ```

3. **Symlink a Package:**

   Navigate into your dotfiles directory and use stow to create the symlinks for
   a specific package. A package is a top-level directory in the dotfiles, e.g.,
   “neovim” or “btop”.

   ```
   cd ~/.dotfiles
   stow <package_name>
   ```

   For example, to install the Neovim dotfiles:

   ```
   stow neovim
   ```

   If there are existing files at the target location, Stow will warn you of a
   conflict. You can either manually move the files or use the --adopt flag to
   move them into the repository and then create the symlink.

   ```
   stow --adopt neovim
   ```

   Note that `--adopt` will overwrite the contents in ~/.dotfiles with whatever
   was adopted.

4. **Install All Packages:**

   To symlink all packages at once, use a wildcard:

   ```
   stow */
   ```

   Note that the trailing slash is important to ensure only directories are stowed.

## Links

- [GNU Stow Official Documentation][1]

[1]: https://www.gnu.org/software/stow/

<!-- vim: set textwidth=80 spell spelllang=en: -->
