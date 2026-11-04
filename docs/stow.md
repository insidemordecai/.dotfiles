# GNU Stow

This repo uses [GNU Stow](https://www.gnu.org/software/stow/) to put configuration files where applications expect them without copying anything around.
Stow creates symlinks, so editing a file through `~/.zshrc` or `~/.config/nvim` edits the file in this repo.

`setup.sh` installs Stow if it is missing.
To install it yourself:

```sh
# macOS
brew install stow

# Debian / Ubuntu
sudo apt install stow

# Fedora
sudo dnf install stow

# Arch Linux
sudo pacman -S stow
```

## Vocabulary

Stow works with three things:

- **Stow directory** — the directory containing the packages.
  Here it is the repo root, `~/.dotfiles`.
- **Package** — a top-level directory in the stow directory.
  Each package mirrors the layout of the target directory.
  `shell/`, `nvim/`, `git/`, and the rest are packages.
- **Target directory** — where the symlinks are created.
  When you run `stow` from inside the stow directory, the target defaults to the *parent* of the stow directory.
  With the repo at `~/.dotfiles`, the target is `$HOME`.

A package only contains the path below `$HOME`:

```text
~/.dotfiles/shell/.zshrc              ->  ~/.zshrc
~/.dotfiles/nvim/.config/nvim/        ->  ~/.config/nvim/
~/.dotfiles/git/.gitconfig            ->  ~/.gitconfig
```

Stow walks each package and creates the corresponding links in the target.
It never writes into `$HOME` itself except to create those links.

## Why the clone location matters

Because the target defaults to the parent of the stow directory, the repo must sit directly in your home directory:

```text
~/.dotfiles   target = ~        correct
~/dotfiles    target = ~        correct
~/src/dotfiles  target = ~/src  wrong
```

If the repo lives somewhere else, pass the target explicitly:

```sh
stow --target="$HOME" shell
```

`setup.sh` does not pass `--target`, so it relies on the repo being cloned directly under `$HOME`.

## Folding

Stow tries to create the fewest symlinks possible, a behavior called *folding*.
When the whole directory can be linked, it links the directory.
When the target already contains a real directory or a conflicting entry, it descends and links individual files instead.

The result depends on what already exists in `$HOME`.
If `~/.config/nvim` does not exist, `stow nvim` can create one directory symlink.
If `~/.config/zed/` already exists, Stow links `settings.json` and `tasks.json` inside it individually:

```text
~/.config/nvim -> ../.dotfiles/nvim/.config/nvim          # folded directory
~/.config/zed/                                            # existing real directory
~/.config/zed/settings.json -> ../../.dotfiles/...        # per-file link
~/.config/zed/tasks.json    -> ../../.dotfiles/...
```

On a fresh machine, most packages fold into single directory links.
A package can end up partially linked when its target directory already exists.

This has one practical consequence: if a directory is folded, new files added to that package appear in `$HOME` automatically.
If a directory is only partially linked, new files do not appear until you restow the package:

```sh
stow -R nvim
```

Use `--no-folding` if you want per-file links everywhere and no surprise behavior when adding files:

```sh
stow --no-folding --target="$HOME" shell
```

## Common commands

Run these from the repo root, `~/.dotfiles`.

| Command | What it does |
| --- | --- |
| `stow shell` | Link the `shell` package into `$HOME`. |
| `stow -D shell` | Remove the links created for `shell`. |
| `stow -R shell` | Restow by removing and linking again; useful after adding files. |
| `stow -n shell` | Simulate; show what would happen without changing anything. |
| `stow -v shell` | Verbose output, including each link. |
| `stow -nv shell` | Dry run with details — the safest way to preview. |
| `stow --adopt shell` | Move conflicting target files into the package, then link; use with care. |
| `stow --no-folding shell` | Create per-file links instead of folding directories. |
| `stow -t "$HOME" shell` | Use an explicit target directory. |

`setup.sh` runs the equivalent of `stow <package>` for each package.

## Adding a package

1. Create a directory at the repo root named after the application, for example `bat/`.
2. Recreate the path the application expects below `$HOME`:

   ```text
   bat/.config/bat/config
   ```

3. From the repo root, link it:

   ```sh
   stow bat
   ```

4. Commit the files.
   `setup.sh` picks up new top-level directories automatically; there is nothing to register.

If the package directory is empty, Stow has nothing to link and will either do nothing or report an error.

## Adding files to an existing package

- If the package is folded (a directory symlink), new files are visible immediately.
- If the package is partially linked, run `stow -R <package>` from the repo root.

Check which case applies with `ls -l` on the target path.

## Conflicts

Stow refuses to overwrite an existing file or directory that it does not own.
Typical output:

```text
WARNING! stowing shell would cause conflicts:
  * existing target is not owned by stow: .zshrc
All operations aborted.
```

Resolution:

```sh
# Back up the existing file first.
mv ~/.zshrc ~/.zshrc.backup

# Then link the package.
cd ~/.dotfiles
stow shell
```

Compare the backup with the repo version before deleting it.
Do **not** reach for `--adopt` first: it moves the target file into the package, overwriting the tracked version, and leaves you reviewing a diff to recover the original.

If the conflict is a directory, move the whole directory aside.
Stow can then fold the package cleanly.

## Dangling symlinks

Deleting a file from a package leaves a broken symlink in `$HOME`.
Remove the links for that package and stow it again:

```sh
cd ~/.dotfiles
stow -D shell
stow shell
```

`stow -D` only removes links that point back into the package, so it is safer than deleting files under `$HOME` by hand.

## Verifying

```sh
# Show the links in your home directory.
ls -la ~ | grep '\->'
ls -la ~/.config | grep '\->'

# Confirm a specific link.
readlink ~/.zshrc
readlink ~/.config/nvim

# Preview what a package would do without touching anything.
cd ~/.dotfiles
stow -nv shell
```

If the links point back into `~/.dotfiles`, Stow is working as intended.

## What is not stowed

`scripts/` contains legacy provisioning scripts and is not a package.
`docs/` contains this documentation.
`setup.sh` explicitly skips both.
It also lists `.git`, although the `*/` glob never matches dot-directories, so that entry is harmless rather than necessary.
