#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"

echo "Uninstalling Kopi Language Support extension..."
code --uninstall-extension PandaBefriender.kopi-language-support || true

echo "Packaging Kopi extension..."
"$script_dir/package-extension.sh"

echo "Installing Kopi Language Support extension..."
code --install-extension "$repo_root/kopi-language-support-1.4.1.vsix" --force

echo "✓ Kopi extension updated successfully!"
code --list-extensions | grep -i kopi
