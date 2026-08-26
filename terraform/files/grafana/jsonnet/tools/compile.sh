#!/usr/bin/env bash
set -euo pipefail

package_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_dir="${package_dir}/dashboards"
output_dir="${OUTPUT_DIR:-${package_dir}/build}"
jsonnet_bin="${JSONNET:-jsonnet}"

mkdir -p "${output_dir}/common" "${output_dir}/gpu/variants" "${output_dir}/oci"

find "${source_dir}" -type f -name '*.jsonnet' ! -name 'gpu-health-status.jsonnet' -print0 |
  while IFS= read -r -d '' source_file; do
    relative_path="${source_file#${source_dir}/}"
    output_file="${output_dir}/${relative_path%.jsonnet}.json"
    mkdir -p "$(dirname "${output_file}")"
    "${jsonnet_bin}" -J "${package_dir}/vendor" --output-file "${output_file}" "${source_file}"
  done

health_source="${source_dir}/gpu/gpu-health-status.jsonnet"
for vendor in nvidia amd mixed; do
  "${jsonnet_bin}" -J "${package_dir}/vendor" \
    --ext-str "gpu_vendor=${vendor}" \
    --output-file "${output_dir}/gpu/variants/gpu-health-status-${vendor}.json" \
    "${health_source}"
done

cp "${output_dir}/gpu/variants/gpu-health-status-mixed.json" \
  "${output_dir}/gpu/gpu-health-status.json"
