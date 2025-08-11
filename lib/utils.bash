#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/daytonaio/daytona"
TOOL_NAME="daytona"
TOOL_TEST="daytona version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//'
}

list_all_versions() {
  # CLI releases do not correspond with daytona releases on Github
  # Hardcoding this for now
  echo "0.16.11"
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"

  arch=$(uname -m | tr "[:upper:]" "[:lower:]")
  os=$(uname -s | tr "[:upper:]" "[:lower:]")

  case $arch in
  "aarch64")
    arch="arm64"
    ;;
  "x86_64")
    arch="amd64"
    ;;
  esac

  url="https://download.daytona.io/cli/${version}/daytona-$os-$arch"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path/bin"
    local download_file="$ASDF_DOWNLOAD_PATH/$TOOL_NAME-${version}"
    chmod +x "$download_file"
    mv "$download_file" "$install_path/bin/$TOOL_NAME" || fail "Could not copy $download_file to $install_path"
    local tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    #rm -rf "$install_path"
    fail "An error occurred while installing $TOOL_NAME $version."
  )
}
