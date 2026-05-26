#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
ext_dir="$repo_root/.vscode-ext/kopi-language-support"

# Optional first argument or VERSION env var overrides package version/filename
VERSION_ARG="${1:-${VERSION:-}}"

# Determine version from extension package.json if not provided
if [ -n "$VERSION_ARG" ]; then
	version="$VERSION_ARG"
else
	if [ -f "$ext_dir/package.json" ]; then
		version=$(python3 -c "import json,sys;print(json.load(open(sys.argv[1]))['version'])" "$ext_dir/package.json")
	else
		version="1.0.0"
	fi
fi

out_file="$repo_root/kopi-language-support-$version.vsix"

# If the existing vsix is newer than all extension files, reuse cached file
if [ -f "$out_file" ]; then
	newest_file_ts=$(find "$ext_dir" -type f -printf "%T@\n" | sort -n | tail -1 || echo 0)
	out_mtime=$(stat -c %Y "$out_file" || echo 0)
	# compare as integers
	newest_sec=${newest_file_ts%%.*}
	if [ "$out_mtime" -ge "$newest_sec" ]; then
		echo "Using cached $out_file"
		exit 0
	fi
fi

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

mkdir -p "$tmp_dir/extension"
cp -r "$ext_dir"/* "$tmp_dir/extension/"

# If a VERSION was supplied, update package.json inside the tmp copy
if [ -n "$VERSION_ARG" ]; then
	pkg_path="$tmp_dir/extension/package.json"
	if [ -f "$pkg_path" ]; then
		python3 - "$pkg_path" "$version" <<'PY'
import json,sys
path=sys.argv[1]
v=sys.argv[2]
with open(path) as f:
		data=json.load(f)
data['version']=v
with open(path,'w') as f:
		json.dump(data,f,indent=2)
PY
	fi
fi

rm -f "$out_file"
cd "$tmp_dir"
zip -r "$out_file" extension >/dev/null

echo "Packaged extension to $out_file"
