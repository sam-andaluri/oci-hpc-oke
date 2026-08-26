#!/usr/bin/env bash
set -euo pipefail

package_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
repository_output="$(cd "${package_dir}/../dashboards" && pwd)"
temporary_output="$(mktemp -d)"
trap 'rm -rf "${temporary_output}"' EXIT

JSONNET="${JSONNET:-jsonnet}" OUTPUT_DIR="${temporary_output}" bash "${package_dir}/tools/compile.sh"
node "${package_dir}/tools/audit-contracts.mjs" "${temporary_output}" "${package_dir}/testdata/contracts.json"

if "${JSONNET:-jsonnet}" -J "${package_dir}/vendor" \
  --ext-str gpu_vendor=none \
  "${package_dir}/dashboards/gpu/gpu-health-status.jsonnet" >/dev/null 2>&1; then
  echo "gpu-health-status.jsonnet accepted an unsupported gpu_vendor" >&2
  exit 1
fi

diff -ru "${repository_output}" "${temporary_output}"
