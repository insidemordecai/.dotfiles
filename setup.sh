#!/usr/bin/env bash
set -euo pipefail

install_stow() {
  if command -v stow >/dev/null 2>&1; then
    return 0
  fi

  case "$(uname -s)" in
    Linux)
      if command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update
        sudo apt-get install -y stow
      elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y stow
      elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -S --noconfirm stow
      else
        echo "Unsupported Linux package manager." >&2
        exit 1
      fi
      ;;
    Darwin)
      if command -v brew >/dev/null 2>&1; then
        brew install stow
      else
        echo "Homebrew is required on macOS." >&2
        exit 1
      fi
      ;;
    *)
      echo "Unsupported OS: $(uname -s)" >&2
      exit 1
      ;;
  esac
}

install_stow

EXCLUDED_FOLDERS=(
  scripts
  docs
  .git
)

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
    echo "Skipping $pkg"
    continue
  fi

  echo "Stowing $pkg"
  stow "$pkg"
done
