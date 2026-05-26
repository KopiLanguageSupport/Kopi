#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <version> [<version> ...]"
  echo "Example: $0 1.4.2 1.5.0"
  exit 1
fi

for ver in "$@"; do
  echo "Releasing version $ver"
  # Build vsix with requested version
  "$script_dir/package-extension.sh" "$ver"
done

echo "Finished releasing: $*"
