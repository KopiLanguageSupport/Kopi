#!/usr/bin/env bash
set -euo pipefail

echo "Uninstalling Kopi Language Support extension..."
code --uninstall-extension kopi-org.kopi-language-support || true

echo "Packaging Kopi extension..."
./scripts/package-extension.sh

echo "Installing Kopi Language Support extension..."
code --install-extension kopi-language-support-1.0.0.vsix --force

echo "✓ Kopi extension updated successfully!"
code --list-extensions | grep -i kopi
