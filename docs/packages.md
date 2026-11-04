# Packages

Every top-level directory is a Stow package.
The table lists where each one lands and what it is for.

| Package | Target in `$HOME` | Purpose |
| --- | --- | --- |
| `alacritty` | `~/.config/alacritty/` | Terminal configuration and Catppuccin themes. |
| `ghostty` | `~/.config/ghostty/` | Terminal configuration. |
| `git` | `~/.gitconfig` | Git identity, SSH signing, and GitHub CLI integration. |
| `nvim` | `~/.config/nvim/` | LazyVim configuration. |
| `prettier` | `~/.prettierrc` | Formatting rules for editor integrations. |
| `shell` | `~/.zshrc`, `~/.bashrc`, `~/.shell.d/` | Shell startup files and a drop-in directory. |
| `starship` | `~/.config/starship.toml` | Prompt configuration. |
| `tmux` | `~/.tmux.conf` | Keybindings, Catppuccin, and TPM plugins. |
| `vim` | `~/.vimrc` | Basic Vim settings. |
| `zed` | `~/.config/zed/settings.json`, `tasks.json` | Editor settings and a live-server task. |

Run from the repo root to link one package:

```sh
cd ~/.dotfiles
stow <package>
```

## Notes

- `shell`: `.zshrc` and `.bashrc` load every file in `~/.shell.d/`.
  Some aliases in `~/.shell.d/aliases` are Fedora-specific and need adjustment on Debian or Arch.
- `nvim`: this is a stock LazyVim setup; see the [LazyVim documentation](https://www.lazyvim.org/) for the layout and commands.
  `lazy-lock.json` pins plugin versions, and Mason installs the configured LSP servers.
- `git`: the config signs commits and tags with an SSH key and uses the GitHub CLI for GitHub credentials.
  The GitHub CLI is also available for general GitHub workflows.
  See [Installation](installation.md#git-commit-signing) for the setup requirements.
- `zed`: the settings include a personal `ssh_connections` entry and an `opencode` agent server.
  The live-server task needs Node.js because it runs through `npx`.
- `ghostty`: the config includes macOS-specific options that should be reviewed on Linux.
- `alacritty`: `Super` maps to `Cmd` on macOS, so `Super+Shift+Return` becomes `Cmd+Shift+Return`.

## Personalization checklist

When forking this repo, review these before running `setup.sh`:

- **Git:** `user.name`, `user.email`, `user.signingkey`, and `~/.ssh/allowed_signers`.
  Remove signing if you do not use it.
- **Zed:** `ssh_connections` host, username, and project paths, plus the agent server command if you do not use `opencode`.
- **Shell:** Flutter path, `~/.pub-cache` path, Linux Homebrew path, and the Fedora-specific aliases.
- **Fonts:** Nerd Font family names must match what is installed.
- **Themes:** Catppuccin is used throughout; keep the bundled themes or change every reference consistently.
