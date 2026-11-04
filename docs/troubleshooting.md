# Troubleshooting

## Stow reports a conflict

```text
WARNING! stowing shell would cause conflicts:
  * existing target is not owned by stow: .zshrc
All operations aborted.
```

Stow will not replace a file it did not create.
Back up or move the existing file, then stow again:

```sh
mv ~/.zshrc ~/.zshrc.backup
cd ~/.dotfiles
stow shell
```

For a conflicting directory, move the whole directory aside.
Diff the backup against the repo version before deleting anything.

Avoid using `--adopt` as a first fix.
It moves the existing target into the package, overwriting the tracked copy; you then have to recover the original from the resulting Git diff.

## `setup.sh` stops partway through

`setup.sh` uses `set -e`, so the first conflict aborts the run.
Packages after the failing one were not stowed.
Fix the reported conflict and rerun:

```sh
cd ~/.dotfiles
./setup.sh
```

Packages that are already linked are skipped by Stow, so rerunning is safe.

## Links appear in the wrong place

Stow's target defaults to the parent of the repo.
Check where the repo lives:

```sh
cd ~/.dotfiles
pwd
```

If it is not a direct child of `$HOME`, either move it or stow explicitly:

```sh
stow --target="$HOME" shell
```

Remove misplaced links with `stow -D --target=<wrong-target> <package>` before relinking.

## `stow: command not found`

`setup.sh` should have installed it, but if you are stowing manually:

```sh
brew install stow              # macOS
sudo apt install stow          # Debian / Ubuntu
sudo dnf install stow          # Fedora
sudo pacman -S stow            # Arch Linux
```

## New files in a package are missing from `$HOME`

The package is probably partially folded.
Check:

```sh
ls -l ~/.config/nvim
```

If it is a real directory containing file links rather than one directory link, restow the package:

```sh
cd ~/.dotfiles
stow -R nvim
```

## Shell startup errors

### `command not found: starship` / `zoxide`

Install the missing tool.
The shell files initialise both unconditionally.

### zsh plugins do not load on Linux

`.zshrc` uses `plocate` to find `zsh-autosuggestions.zsh` and `zsh-syntax-highlighting.zsh`:

```sh
command -v plocate
plocate -r '/zsh-autosuggestions\.zsh$'
plocate -r '/zsh-syntax-highlighting\.zsh$'
```

If `plocate` is missing, install it (`sudo apt install plocate`, `sudo dnf install plocate`, `sudo pacman -S plocate`) or replace those lines with the plugin paths used by your distribution.

### zsh plugins do not load on macOS

The config hardcodes Homebrew's Apple Silicon location:

```text
/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

On an Intel Mac, change `/opt/homebrew` to `/usr/local`.
Confirm the files exist with `brew --prefix`.

### Aliases fail on Debian or Arch

`.shell.d/aliases` still defines some Fedora-oriented commands such as `dnfi`, `dnfrm`, and `upall`.
They only work on Fedora with `dnf`.
Remove or rewrite them for your distribution; the unrelated aliases (`eza`, `trash`, `zoxide`, Git) work anywhere the tools are installed.

### `eza` or `trash` not found

The aliases assume both are installed.
Install `eza` and `trash-cli`, or comment out the relevant aliases.

## Neovim

### Plugins did not install on first launch

The first start needs network access to clone `lazy.nvim` and the plugins.
Check the Lazy UI:

```vim
:Lazy
```

If the lockfile was committed but versions differ, restore the pins:

```vim
:Lazy restore
```

### LSP servers or formatters are missing

LazyVim uses Mason.
Install the missing tools from the Mason UI:

```vim
:Mason
```

The config requests `tailwindcss-language-server`, `lua-language-server`, `css-lsp`, `html-lsp`, `shfmt`, and `stylua`.

## tmux

### Plugins are missing

Start tmux, then press `prefix + I` (default prefix `Ctrl-b`) to let TPM install the declared plugins.
If TPM itself is missing, check that `~/.tmux/plugins/tpm` exists and reload:

```sh
tmux source-file ~/.tmux.conf
```

TPM is cloned automatically the first time the config loads, provided Git and network access are available.

## Zed

### Formatting does nothing or reports "formatter not found"

Zed includes Prettier support, so check that `"formatter": "prettier"` and `"format_on_save": "on"` are still set.
VS Code requires the Prettier extension.
No separate `prettier` CLI installation is needed.

### The Live Server task fails

The task runs `npx live-server`.
Install Node.js/npm and make sure `npx` is on `PATH`.
The first run downloads `live-server`.

### Theme or icons look wrong

Catppuccin themes ship with Zed.
`Warm Charmed Icons` must be installed as an extension, or change `icon_theme` in `settings.json`.

## Fonts render as boxes

Install JetBrainsMono Nerd Font (see [Installation](installation.md#fonts)).
Then make sure the terminal or editor is actually configured to use it:

- Alacritty: `JetBrainsMono Nerd Font`
- Zed: `JetBrainsMono Nerd Font Mono`

On Linux, refresh the font cache after installing:

```sh
fc-cache -fv
fc-list | grep -i "jetbrains.*nerd"
```

## Git signing fails

Check what Git is using:

```sh
git config --show-origin --get user.signingkey
git config --show-origin --get gpg.ssh.allowedSignersFile
ls -l ~/.ssh/id_ed25519*
```

Common causes:

- The key path in `.gitconfig` does not exist.
- `~/.ssh/allowed_signers` is missing.
- The key has restrictive permissions or is not loaded in `ssh-agent`.

Test the signature on the most recent commit:

```sh
git log --show-signature -1
```

If you do not use SSH signing, remove the signing sections from `.gitconfig`.

## Broken links after deleting files

Deleting a file from the repo leaves a dangling symlink in `$HOME`.
Find and remove them:

```sh
# List broken symlinks in your home directory and config dir.
find ~ -maxdepth 1 -type l ! -exec test -e {} \; -print
find ~/.config -type l ! -exec test -e {} \; -print
```

Then restow the affected package, or remove its links:

```sh
cd ~/.dotfiles
stow -D <package>
stow <package>
```

## `Skipping docs` and `Skipping scripts` messages

These are expected.
`setup.sh` excludes the documentation and the legacy scripts from Stow.
The message does not indicate a problem.

## Still stuck

Preview what Stow thinks it should do, without changing anything:

```sh
cd ~/.dotfiles
stow -nv <package>
```

The verbose dry run lists every link it would create, skip, or reject, which usually identifies the conflicting path immediately.
