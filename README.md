# .dotfiles

Personal configuration for macOS and Linux, managed with [GNU Stow](https://www.gnu.org/software/stow/).
The repo lives directly in `$HOME`; `setup.sh` symlinks each package into place, so the files in this repository are the live files used by the shell, editors, terminals, tmux, and Git.

## Platform support

The setup has moved between distributions:

- **macOS** — daily laptop.
- **Debian** — current homelab server.
- **Fedora and Arch Linux** — used previously.

The shared Linux files aim for cross-distro compatibility, but the current tree is primarily verified on macOS and Debian.
Fedora and Arch paths have not been re-tested since the switch; see the distribution note in [Installation](docs/installation.md#a-note-on-distribution-coverage).

`setup.sh` can install Stow with `apt-get`, `dnf`, `pacman`, or Homebrew, so other distributions using one of those package managers will likely work too.

## Quick start

```sh
git clone git@github.com:insidemordecai/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup.sh
```

HTTPS alternative:

```sh
git clone https://github.com/insidemordecai/.dotfiles.git ~/.dotfiles
```

The repo must sit directly under your home directory (`~/.dotfiles` or `~/dotfiles`).
Stow's default target is the parent of the repo, so cloning somewhere like `~/src/dotfiles` would link files into `~/src` instead of `$HOME`.

## Packages

| Package | Links into |
| --- | --- |
| `alacritty` | `~/.config/alacritty/` |
| `ghostty` | `~/.config/ghostty/` |
| `git` | `~/.gitconfig` |
| `nvim` | `~/.config/nvim/` |
| `prettier` | `~/.prettierrc` |
| `shell` | `~/.zshrc`, `~/.bashrc`, `~/.shell.d/` |
| `starship` | `~/.config/starship.toml` |
| `tmux` | `~/.tmux.conf` |
| `vim` | `~/.vimrc` |
| `zed` | `~/.config/zed/settings.json`, `~/.config/zed/tasks.json` |

## What `setup.sh` does

1. Installs GNU Stow if it is missing, using the platform's package manager.
2. Skips `scripts/`, `docs/`, and `.git`.
3. Runs `stow <package>` for every other top-level directory.

It installs only Stow — the tools and fonts referenced by the configs are separate steps.
Because it uses `set -e`, the first existing-file conflict stops the run; fix the conflict and rerun.
See [Installation](docs/installation.md#run-setupsh) for the full walkthrough.

## Prerequisites

To run `setup.sh`: `git`, `bash`, and Homebrew on macOS.
GNU Stow is installed automatically.

The configuration also expects `zsh` (with `zsh-autosuggestions` and `zsh-syntax-highlighting`), `starship`, `zoxide`, `eza`, `trash-cli`, `nvim`, `tmux`, `gh`, and Node.js for the Zed live-server task.
`gh` is the GitHub CLI, used for GitHub workflows and Git credentials.
A JetBrainsMono Nerd Font is needed for icons and prompt glyphs.
The full list, install commands, font links, and shell-switch instructions are in [Installation](docs/installation.md#requirements).

## Documentation

- [Installation](docs/installation.md) — prerequisites, `setup.sh` walkthrough, switching from bash to zsh, uninstall, known limitations.
- [GNU Stow](docs/stow.md) — how packages, targets, folding, and symlinks work.
- [Packages](docs/packages.md) — what each package configures and what must be personalised.
- [Troubleshooting](docs/troubleshooting.md) — conflicts, missing tools, plugin bootstrap, fonts, and signing errors.

## Legacy scripts

`scripts/` contains provisioning scripts written for an older Fedora setup.
They are not stowed, not run by `setup.sh`, and are unsupported: they make system-wide changes with `sudo`, pin old versions, and do not reflect the current macOS/Debian/Arch setup.
Review or rewrite them before using anything there.
