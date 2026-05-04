#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
ext_dir="$repo_root/.vscode-ext/kopi-language-support"
out_file="$repo_root/kopi-language-support-1.0.0.vsix"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

mkdir -p "$tmp_dir/extension"
cp -r "$ext_dir"/* "$tmp_dir/extension/"

rm -f "$out_file"
cd "$tmp_dir"
zip -r "$out_file" extension >/dev/null

echo "Packaged extension to $out_file"
