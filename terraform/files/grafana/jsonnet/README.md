# OKE Grafana dashboards as code

This package is self-contained and does not require Terraform, Kubernetes,
Grafana, or OCI credentials to compile and validate the dashboards. Jsonnet and
Grafonnet are the source of truth; generated JSON under `../dashboards` remains
the deployment artifact consumed by Terraform and OCI Resource Manager.

## Tool versions

- go-jsonnet `v0.21.0`
- jsonnet-bundler `v0.6.0`
- Grafonnet pinned by `jsonnetfile.lock.json`

The Makefile, `jb`, and go-jsonnet workflow follows the established Slurm
dashboard build at source commit `c43b755b9ce22628c0532335e40c8fc5ec44af6c`.
OKE dashboard queries, variables, labels, folders, and deployment behavior stay
OKE-specific and are guarded by the contract audit.

Install the two command-line tools, then run:

```bash
make bootstrap
make verify
make package-test
```

`make compile` updates `../dashboards` by default. To compile without touching
repository artifacts, set a separate output directory:

```bash
make compile OUTPUT_DIR=/tmp/oke-grafana-dashboards
```

The GPU health source produces NVIDIA-only, AMD-only, and mixed variants. The
mixed output is also written to the logical `gpu-health-status.json` path; OKE
Terraform selects the appropriate variant without changing the deployed
ConfigMap name, key, folder, or dashboard UID.

The shared builders start dashboards, panel types, Prometheus queries, and
variables with Grafonnet constructors, then retain only fields present in the
existing dashboard contract. This exact overlay is intentional: the checked-in
dashboards contain Grafana-version-specific and datasource-specific fields that
Grafonnet otherwise adds, removes, or defaults differently. Shared threshold,
layout, query, variable, and panel helpers remove the repeated behavior while
`testdata/contracts.json` prevents a source and generated artifact from drifting
together unnoticed.

The `Containerfile` provides an optional isolated compiler environment:

```bash
docker build -t oke-grafonnet-compiler -f Containerfile .
docker run --rm -v "$PWD:/workspace" oke-grafonnet-compiler verify
```
