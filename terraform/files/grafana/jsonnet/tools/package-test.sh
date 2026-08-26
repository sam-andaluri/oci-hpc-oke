#!/usr/bin/env bash
set -euo pipefail

package_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
temporary_root="$(mktemp -d)"
trap 'rm -rf "${temporary_root}"' EXIT

cp -R "${package_dir}" "${temporary_root}/grafana-jsonnet"
rm -rf "${temporary_root}/grafana-jsonnet/build"

first_output="${temporary_root}/first"
second_output="${temporary_root}/second"
JSONNET="${JSONNET:-jsonnet}" OUTPUT_DIR="${first_output}" bash "${temporary_root}/grafana-jsonnet/tools/compile.sh"
JSONNET="${JSONNET:-jsonnet}" OUTPUT_DIR="${second_output}" bash "${temporary_root}/grafana-jsonnet/tools/compile.sh"
diff -ru "${first_output}" "${second_output}"
node "${temporary_root}/grafana-jsonnet/tools/audit-contracts.mjs" \
  "${first_output}" "${temporary_root}/grafana-jsonnet/testdata/contracts.json"
