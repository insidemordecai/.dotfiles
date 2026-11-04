# Installation

## Requirements

### Required to run `setup.sh`

- `git` to clone the repo.
- `bash` to run the script.
- On macOS: [Homebrew](https://brew.sh/), used to install Stow.

`setup.sh` installs GNU Stow automatically.
`sudo` and the distribution's package manager (`apt-get`, `dnf`, or `pacman`) are part of a normal Linux install and are assumed to be present rather than listed as prerequisites.

### Required by the configuration files

`setup.sh` installs **only Stow**.
Everything below is used by the shell, editor, terminal, or Git configuration and must be installed separately.

| Tool                      | Used for                                                             |
| ------------------------- | -------------------------------------------------------------------- |
| `zsh`                     | `.zshrc`, aliases, prompt, completion.                               |
| `zsh-autosuggestions`     | Inline history suggestions in zsh.                                   |
| `zsh-syntax-highlighting` | Command syntax highlighting in zsh.                                  |
| `starship`                | Cross-shell prompt (`starship init`).                                |
| `zoxide`                  | Smarter `cd`, aliased to `z` in `.shell.d/aliases`.                  |
| `eza`                     | `ls`, `la`, `lt`, `lta` aliases.                                     |
| `trash-cli`               | Provides `trash`, which replaces `rm`.                               |
| `nvim`                    | `$EDITOR` / `$VISUAL` and Git's editor.                              |
| `tmux`                    | Terminal multiplexer configuration.                                  |
| `gh`                      | GitHub CLI for GitHub workflows and Git credentials.                 |
| `node` / `npx`            | The Zed "Live Server" task uses `npx live-server`.                   |
| `plocate`                 | Linux only, optional. `.zshrc` uses it to find the zsh plugin files. |
| `flutter`                 | Optional; `.zshrc` adds `~/development/flutter/bin` to `PATH`.       |
| `vim`                     | Optional; `.vimrc` is provided but Neovim is the default editor.     |

Install hints:

```sh
# macOS
brew install starship zoxide eza trash neovim tmux gh node \
  zsh-autosuggestions zsh-syntax-highlighting

# Debian / Ubuntu (package names vary by release)
sudo apt install zsh zsh-autosuggestions zsh-syntax-highlighting \
  starship zoxide eza trash-cli neovim tmux gh nodejs npm plocate

# Fedora
sudo dnf install zsh zsh-autosuggestions zsh-syntax-highlighting \
  starship zoxide eza trash-cli neovim tmux gh nodejs npm plocate

# Arch Linux
sudo pacman -S zsh zsh-autosuggestions zsh-syntax-highlighting \
  starship zoxide eza trash-cli neovim tmux github-cli nodejs npm plocate
```

If a package is unavailable in your distribution's repositories, use the upstream installer or your AUR/COPR/PPA equivalent.

### Fonts

Alacritty is configured for **JetBrainsMono Nerd Font** and Zed for **JetBrainsMono Nerd Font Mono**.
Without a Nerd Font, icons and prompt glyphs render as boxes.

- Downloads: <https://www.nerdfonts.com/font-downloads>
- Direct JetBrainsMono zip: <https://github.com/ryanoasis/nerd-fonts/releases/download/v3.5.1/JetBrainsMono.zip>

```sh
# macOS
brew install --cask font-jetbrains-mono-nerd-font

# Arch Linux
sudo pacman -S ttf-jetbrains-mono-nerd

# Debian / Fedora: download the zip, then
mkdir -p ~/.local/share/fonts/JetBrainsMono
unzip JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMono
fc-cache -fv
```

### Prettier

`~/.prettierrc` is picked up by editor integrations.
Zed supports Prettier out of the box.
VS Code requires the Prettier extension.
No separate `prettier` CLI installation is needed.

### Git commit signing

The tracked `.gitconfig` enables SSH signing for commits and tags.
You need an SSH key, for example `~/.ssh/id_ed25519` with `~/.ssh/id_ed25519.pub`, and an `~/.ssh/allowed_signers` file containing the public keys allowed to sign.
See GitHub's documentation on [telling Git about your signing key](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key) and [generating a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).
If you do not use SSH signing, remove or adjust the `[gpg]`, `[gpg "ssh"]`, `[commit]`, and `[tag]` sections before relying on the config.

## Clone

Clone the repo directly into your home directory:

```sh
git clone git@github.com:insidemordecai/.dotfiles.git ~/.dotfiles
```

HTTPS works too:

```sh
git clone https://github.com/insidemordecai/.dotfiles.git ~/.dotfiles
```

The location matters.
Stow's default target is the parent of the repo, so it must be a direct child of `$HOME`.
See [GNU Stow](stow.md#why-the-clone-location-matters).

## Run `setup.sh`

```sh
cd ~/.dotfiles
./setup.sh
```

What it does, in order:

1. Enables strict shell behavior with `set -euo pipefail`.
2. Checks whether `stow` is already installed.
   - Linux: installs with `apt-get`, `dnf`, or `pacman`, whichever exists.
   - macOS: installs with `brew`.
   - Anything else: exits with an error.
3. Defines an exclusion list: `scripts`, `docs`, and `.git`.
4. Loops over every top-level directory.
5. Skips excluded names and prints `Skipping <name>`.
6. Runs `stow <name>` for every remaining directory and prints `Stowing <name>`.

Packages are processed in the alphabetical order produced by the `*/` glob.
Because `set -e` is active, the first Stow conflict stops the whole run and later packages are not stowed.

## After running `setup.sh`

1. **Install the missing tools and font** from the sections above.
2. **Switch your login shell to zsh** if it is not already.
3. **Restart your terminal** so the new shell and prompt load.
4. **Run `gh auth login`** so the GitHub CLI and Git's credential helper are authenticated.
5. **Start Neovim once** to let it clone LazyVim and install plugins.
6. **Start tmux once** so TPM bootstraps, then press `prefix + I` (default prefix `Ctrl-b`) to install the plugins.

### Switching from bash to zsh

```sh
# Check what you are using now.
echo "$SHELL"

# Make sure zsh is installed and find its path.
command -v zsh

# macOS: zsh is the default since Catalina.
chsh -s /bin/zsh

# Linux: use the path reported by `command -v zsh`.
chsh -s "$(command -v zsh)"

# If chsh says the shell is not listed, add it first.
command -v zsh | sudo tee -a /etc/shells
chsh -s "$(command -v zsh)"
```

Log out and back in, then confirm with `echo "$SHELL"`.
`setup.sh` does not change your shell; `.zshrc` is only read once zsh is the login shell.
Until then, bash reads `.bashrc`, which provides a smaller shared baseline.

## Uninstall

Remove the links for every package, then delete the clone:

```sh
cd ~/.dotfiles

EXCLUDED_FOLDERS=(scripts docs)
for pkg in */; do
  pkg="${pkg%/}"

  skip=false
  for excluded in "${EXCLUDED_FOLDERS[@]}"; do
    if [[ "$pkg" == "$excluded" ]]; then
      skip=true
      break
    fi
  done

  if [[ "$skip" == true ]]; then
    continue
  fi

  stow -D "$pkg"
done

cd ~
rm -rf ~/.dotfiles
```

This mirrors `setup.sh`, so new packages do not need to be added to the uninstall command.
Review `ls -la ~` and `ls -la ~/.config` before deleting the repo.
If you created local files through a symlink, they live in the repo and will be removed with it.

## Known limitations

1. `setup.sh` must be run from the repo root.
   It does not `cd` to its own directory first.
2. The repo must be cloned directly under `$HOME`, because no explicit `--target` is passed to Stow.
3. A single Stow conflict aborts the run; packages after the failure are not stowed.
   Fix the conflict and rerun.
4. Only Stow is installed.
   Tools, fonts, and shell plugins are manual steps.
5. Existing files are never overwritten and no backups are made.
   A conflict can leave the machine in a partially stowed state.
6. The script does not restow (`stow -R`).
   If a package is partially folded, files added later need a manual restow.
7. `.zshrc` hardcodes the Apple Silicon Homebrew path `/opt/homebrew/share/...`.
   On Intel Macs, change it to `/usr/local/share/...`.
8. On Linux, zsh plugin discovery depends on `plocate`.
   If it is missing, the plugins are skipped silently.
   Install `plocate` or hardcode the plugin paths.
9. `scripts/` is legacy.
   See the note in the [README](../README.md#legacy-scripts).

## A note on distribution coverage

The configuration has moved between distributions over time: Fedora first, then Arch Linux with additions, then Debian.
The Linux files aim for compatibility, but the current state is primarily verified on macOS (daily laptop) and Debian (homelab).
Fedora and Arch paths have not been re-tested since the switch, so treat those as expected-to-work rather than guaranteed.
