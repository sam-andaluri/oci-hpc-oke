local dashboard = import '../../lib/dashboard.libsonnet';
local layout = import '../../lib/layout.libsonnet';
local panels = import '../../lib/panels.libsonnet';
local queries = import '../../lib/queries.libsonnet';
local thresholds = import '../../lib/thresholds.libsonnet';
local variables = import '../../lib/variables.libsonnet';

dashboard.fromObjects(
  {
    annotations: {
      list: [
        {
          builtIn: 1,
          datasource: {
            type: 'grafana',
            uid: '-- Grafana --',
          },
          enable: true,
          hide: true,
          iconColor: 'rgba(0, 211, 255, 1)',
          name: 'Annotations & Alerts',
          type: 'dashboard',
        },
      ],
    },
    description: 'GPU Metrics Dashboard for a single cluster node.\n',
    editable: true,
    fiscalYearStartMonth: 0,
    graphTooltip: 1,
    id: 19,
    links: [],
    preload: false,
    schemaVersion: 41,
    tags: [],
    time: {
      from: 'now-5m',
      to: 'now',
    },
    timepicker: {},
    timezone: 'browser',
    title: 'GPU Metrics',
    uid: 'gpu-metrics-single',
    version: 1,
  },
  [
    panels.fromObject(
      {
        datasource: {
          type: 'datasource',
          uid: '-- Mixed --',
        },
        fieldConfig: {
          defaults: {
            mappings: [],
            thresholds: thresholds.greenOnly,
          },
          overrides: [],
        },
        id: 1,
        options: {
          colorMode: 'value',
          graphMode: 'none',
          justifyMode: 'auto',
          orientation: 'auto',
          percentChangeColorMode: 'standard',
          reduceOptions: {
            calcs: [
              'lastNotNull',
            ],
            fields: '',
            values: false,
          },
          showPercentChange: false,
          textMode: 'auto',
          wideLayout: true,
        },
        pluginVersion: '12.1.1',
        title: 'Avail GPU',
        type: 'stat',
      },
      layout.grid(4, 4, 0, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'count by (hostname) (sum by (hostname, gpu_id) (amd_gpu_health == 1)) or label_replace(count by (Hostname) (sum by (Hostname, gpu) (DCGM_EXP_GPU_HEALTH_STATUS == 0)), "hostname", "$1", "Hostname", "(.*)")',
          legendFormat: '__auto',
          range: true,
          refId: 'A',
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'datasource',
          uid: '-- Mixed --',
        },
        fieldConfig: {
          defaults: {
            mappings: [],
            thresholds: thresholds.utilization,
            unit: 'celsius',
          },
          overrides: [],
        },
        id: 2,
        options: {
          minVizHeight: 75,
          minVizWidth: 75,
          orientation: 'auto',
          reduceOptions: {
            calcs: [
              'lastNotNull',
            ],
            fields: '',
            values: false,
          },
          showThresholdLabels: false,
          showThresholdMarkers: true,
          sizing: 'auto',
        },
        pluginVersion: '12.1.1',
        title: 'Max GPU Temperature',
        type: 'gauge',
      },
      layout.grid(4, 4, 4, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'ceil(max by (hostname) (amd_gpu_junction_temperature{hostname=~"$hostname", instance_shape=~"$instance_shape"})) or label_replace(ceil(max by (Hostname) (DCGM_FI_DEV_GPU_TEMP{Hostname=~"$hostname", oci_name=~"$oci_name", instance_shape=~"$instance_shape"})), "hostname", "$1", "Hostname", "(.*)")',
          legendFormat: '__auto',
          range: true,
          refId: 'A',
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'datasource',
          uid: '-- Mixed --',
        },
        fieldConfig: {
          defaults: {
            mappings: [],
            thresholds: thresholds.utilization,
            unit: 'celsius',
          },
          overrides: [],
        },
        id: 3,
        options: {
          minVizHeight: 75,
          minVizWidth: 75,
          orientation: 'auto',
          reduceOptions: {
            calcs: [
              'lastNotNull',
            ],
            fields: '',
            values: false,
          },
          showThresholdLabels: false,
          showThresholdMarkers: true,
          sizing: 'auto',
        },
        pluginVersion: '12.1.1',
        title: 'Max Memory Temperature',
        type: 'gauge',
      },
      layout.grid(4, 4, 8, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'ceil(max by (hostname) (amd_gpu_memory_temperature{hostname=~"$hostname", instance_shape=~"$instance_shape"})) or label_replace(ceil(max by (Hostname) (DCGM_FI_DEV_MEMORY_TEMP{Hostname=~"$hostname", oci_name=~"$oci_name", instance_shape=~"$instance_shape"})), "hostname", "$1", "Hostname", "(.*)")',
          legendFormat: '__auto',
          range: true,
          refId: 'A',
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'datasource',
          uid: '-- Mixed --',
        },
        fieldConfig: {
          defaults: {
            mappings: [],
            thresholds: thresholds.standardZero,
            unit: 'percent',
          },
          overrides: [],
        },
        id: 4,
        options: {
          minVizHeight: 75,
          minVizWidth: 75,
          orientation: 'auto',
          reduceOptions: {
            calcs: [
              'lastNotNull',
            ],
            fields: '',
            values: false,
          },
          showThresholdLabels: false,
          showThresholdMarkers: true,
          sizing: 'auto',
        },
        pluginVersion: '12.1.1',
        title: 'Avg GPU Util by Node',
        type: 'gauge',
      },
      layout.grid(4, 4, 12, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'avg by (hostname) (amd_gpu_gfx_activity{hostname=~"$hostname", instance_shape=~"$instance_shape"}) or label_replace(avg by (Hostname) (DCGM_FI_DEV_GPU_UTIL{Hostname=~"$hostname", oci_name=~"$oci_name", instance_shape=~"$instance_shape"}), "hostname", "$1", "Hostname", "(.*)")',
          legendFormat: '__auto',
          range: true,
          refId: 'A',
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'datasource',
          uid: '-- Mixed --',
        },
        fieldConfig: {
          defaults: {
            displayName: '${__field.labels.gpu_id}',
            mappings: [
              {
                options: {
                  '0': {
                    color: 'red',
                    text: 'Unhealthy',
                  },
                  '1': {
                    color: 'green',
                    text: 'Healthy',
                  },
                },
                type: 'value',
              },
            ],
            thresholds: thresholds.standardZero,
            unit: 'none',
          },
          overrides: [],
        },
        id: 5,
        options: {
          colorMode: 'value',
          graphMode: 'area',
          justifyMode: 'auto',
          orientation: 'vertical',
          percentChangeColorMode: 'standard',
          reduceOptions: {
            calcs: [
              'lastNotNull',
            ],
            fields: '',
            values: false,
          },
          showPercentChange: false,
          text: {
            titleSize: 15,
            valueSize: 15,
          },
          textMode: 'auto',
          wideLayout: true,
        },
        pluginVersion: '12.1.1',
        title: 'GPU Health',
        type: 'stat',
      },
      layout.grid(8, 4, 16, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'amd_gpu_health{hostname=~"$hostname", instance_shape=~"$instance_shape"} or label_replace(label_replace(DCGM_EXP_GPU_HEALTH_STATUS{Hostname=~"$hostname", oci_name=~"$oci_name", instance_shape=~"$instance_shape"} == bool 0, "hostname", "$1", "Hostname", "(.*)"), "gpu_id", "$1", "gpu", "(.*)")',
          refId: 'A',
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'datasource',
          uid: '-- Mixed --',
        },
        fieldConfig: {
          defaults: {
            color: {
              mode: 'palette-classic',
            },
            custom: {
              axisBorderShow: false,
              axisCenteredZero: false,
              axisColorMode: 'text',
              axisLabel: '',
              axisPlacement: 'auto',
              barAlignment: 0,
              barWidthFactor: 0.6,
              drawStyle: 'line',
              fillOpacity: 0,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'linear',
              lineWidth: 1,
              pointSize: 5,
              scaleDistribution: {
                type: 'linear',
              },
              showPoints: 'auto',
              spanNulls: false,
              stacking: {
                group: 'A',
                mode: 'none',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            thresholds: thresholds.standardZero,
            unit: 'celsius',
          },
          overrides: [],
        },
        id: 6,
        options: {
          legend: {
            calcs: [
              'p99',
              'p95',
              'p90',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
          },
          tooltip: {
            hideZeros: false,
            mode: 'single',
            sort: 'none',
          },
        },
        pluginVersion: '12.1.1',
        title: 'GPU Temperature',
        type: 'timeseries',
      },
      layout.grid(8, 8, 0, 4),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'amd_gpu_junction_temperature{hostname=~"$hostname", instance_shape=~"$instance_shape"} or label_replace(label_replace(DCGM_FI_DEV_GPU_TEMP{Hostname=~"$hostname", oci_name=~"$oci_name", instance_shape=~"$instance_shape"}, "hostname", "$1", "Hostname", "(.*)"), "gpu_id", "$1", "gpu", "(.*)")',
          legendFormat: '{{ gpu_id }}',
          refId: 'A',
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'datasource',
          uid: '-- Mixed --',
        },
        fieldConfig: {
          defaults: {
            color: {
              mode: 'palette-classic',
            },
            custom: {
              axisBorderShow: false,
              axisCenteredZero: false,
              axisColorMode: 'text',
              axisLabel: '',
              axisPlacement: 'auto',
              barAlignment: 0,
              barWidthFactor: 0.6,
              drawStyle: 'line',
              fillOpacity: 0,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'linear',
              lineWidth: 1,
              pointSize: 5,
              scaleDistribution: {
                type: 'linear',
              },
              showPoints: 'auto',
              spanNulls: false,
              stacking: {
                group: 'A',
                mode: 'none',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            thresholds: thresholds.standardZero,
            unit: 'watts',
          },
          overrides: [],
        },
        id: 7,
        options: {
          legend: {
            calcs: [
              'p99',
              'p95',
              'p90',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
          },
          tooltip: {
            hideZeros: false,
            mode: 'single',
            sort: 'none',
          },
        },
        pluginVersion: '12.1.1',
        title: 'GPU Powerdraw',
        type: 'timeseries',
      },
      layout.grid(8, 8, 8, 4),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'amd_gpu_package_power{hostname=~"$hostname", instance_shape=~"$instance_shape"} or label_replace(label_replace(DCGM_FI_DEV_POWER_USAGE{Hostname=~"$hostname", oci_name=~"$oci_name", instance_shape=~"$instance_shape"}, "hostname", "$1", "Hostname", "(.*)"), "gpu_id", "$1", "gpu", "(.*)")',
          legendFormat: '{{ gpu_id }}',
          refId: 'A',
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'datasource',
          uid: '-- Mixed --',
        },
        fieldConfig: {
          defaults: {
            color: {
              mode: 'palette-classic',
            },
            custom: {
              axisBorderShow: false,
              axisCenteredZero: false,
              axisColorMode: 'text',
              axisLabel: '',
              axisPlacement: 'auto',
              barAlignment: 0,
              barWidthFactor: 0.6,
              drawStyle: 'line',
              fillOpacity: 0,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'linear',
              lineWidth: 1,
              pointSize: 5,
              scaleDistribution: {
                type: 'linear',
              },
              showPoints: 'auto',
              spanNulls: false,
              stacking: {
                group: 'A',
                mode: 'none',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            thresholds: thresholds.standardZero,
            unit: 'percent',
          },
          overrides: [],
        },
        id: 8,
        options: {
          legend: {
            calcs: [
              'p99',
              'p95',
              'p90',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
          },
          tooltip: {
            hideZeros: false,
            mode: 'single',
            sort: 'none',
          },
        },
        pluginVersion: '12.1.1',
        title: 'GPU Utilization',
        type: 'timeseries',
      },
      layout.grid(8, 8, 16, 4),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'amd_gpu_gfx_activity{hostname=~"$hostname", instance_shape=~"$instance_shape"} or label_replace(label_replace(DCGM_FI_DEV_GPU_UTIL{Hostname=~"$hostname", oci_name=~"$oci_name", instance_shape=~"$instance_shape"}, "hostname", "$1", "Hostname", "(.*)"), "gpu_id", "$1", "gpu", "(.*)")',
          legendFormat: '{{ gpu_id }}',
          refId: 'A',
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'datasource',
          uid: '-- Mixed --',
        },
        fieldConfig: {
          defaults: {
            color: {
              mode: 'palette-classic',
            },
            custom: {
              axisBorderShow: false,
              axisCenteredZero: false,
              axisColorMode: 'text',
              axisLabel: '',
              axisPlacement: 'auto',
              barAlignment: 0,
              barWidthFactor: 0.6,
              drawStyle: 'line',
              fillOpacity: 0,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'linear',
              lineWidth: 1,
              pointSize: 5,
              scaleDistribution: {
                type: 'linear',
              },
              showPoints: 'auto',
              spanNulls: false,
              stacking: {
                group: 'A',
                mode: 'none',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            thresholds: thresholds.standardZero,
            unit: 'celsius',
          },
          overrides: [],
        },
        id: 9,
        options: {
          legend: {
            calcs: [
              'p99',
              'p95',
              'p90',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
          },
          tooltip: {
            hideZeros: false,
            mode: 'single',
            sort: 'none',
          },
        },
        pluginVersion: '12.1.1',
        title: 'GPU Memory Temperature',
        type: 'timeseries',
      },
      layout.grid(8, 8, 0, 12),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'amd_gpu_memory_temperature{hostname=~"$hostname", instance_shape=~"$instance_shape"} or label_replace(label_replace(DCGM_FI_DEV_MEMORY_TEMP{Hostname=~"$hostname", oci_name=~"$oci_name", instance_shape=~"$instance_shape"}, "hostname", "$1", "Hostname", "(.*)"), "gpu_id", "$1", "gpu", "(.*)")',
          legendFormat: '{{ gpu_id }}',
          refId: 'A',
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'datasource',
          uid: '-- Mixed --',
        },
        fieldConfig: {
          defaults: {
            color: {
              mode: 'palette-classic',
            },
            custom: {
              axisBorderShow: false,
              axisCenteredZero: false,
              axisColorMode: 'text',
              axisLabel: '',
              axisPlacement: 'auto',
              barAlignment: 0,
              barWidthFactor: 0.6,
              drawStyle: 'line',
              fillOpacity: 0,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'linear',
              lineWidth: 1,
              pointSize: 5,
              scaleDistribution: {
                type: 'linear',
              },
              showPoints: 'auto',
              spanNulls: false,
              stacking: {
                group: 'A',
                mode: 'none',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            thresholds: thresholds.standardZero,
            unit: 'MHz',
          },
          overrides: [],
        },
        id: 10,
        options: {
          legend: {
            calcs: [
              'p99',
              'p95',
              'p90',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
          },
          tooltip: {
            hideZeros: false,
            mode: 'single',
            sort: 'none',
          },
        },
        pluginVersion: '12.1.1',
        title: 'GPU Clock (System)',
        type: 'timeseries',
      },
      layout.grid(8, 8, 8, 12),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'max by (hostname, gpu_id) (amd_gpu_clock{clock_type="system", hostname=~"$hostname", instance_shape=~"$instance_shape"}) or label_replace(label_replace(DCGM_FI_DEV_SM_CLOCK{Hostname=~"$hostname", oci_name=~"$oci_name", instance_shape=~"$instance_shape"}, "hostname", "$1", "Hostname", "(.*)"), "gpu_id", "$1", "gpu", "(.*)")',
          legendFormat: '{{ gpu_id }}',
          refId: 'A',
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'datasource',
          uid: '-- Mixed --',
        },
        fieldConfig: {
          defaults: {
            color: {
              mode: 'palette-classic',
            },
            custom: {
              axisBorderShow: false,
              axisCenteredZero: false,
              axisColorMode: 'text',
              axisLabel: '',
              axisPlacement: 'auto',
              barAlignment: 0,
              barWidthFactor: 0.6,
              drawStyle: 'line',
              fillOpacity: 0,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'linear',
              lineWidth: 1,
              pointSize: 5,
              scaleDistribution: {
                type: 'linear',
              },
              showPoints: 'auto',
              spanNulls: false,
              stacking: {
                group: 'A',
                mode: 'none',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            thresholds: thresholds.standardZero,
            unit: 'percent',
          },
          overrides: [],
        },
        id: 11,
        options: {
          legend: {
            calcs: [
              'p99',
              'p95',
              'p90',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
          },
          tooltip: {
            hideZeros: false,
            mode: 'single',
            sort: 'none',
          },
        },
        pluginVersion: '12.1.1',
        title: 'GPU Memory Controller Activity (UMC)',
        type: 'timeseries',
      },
      layout.grid(8, 8, 16, 12),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'amd_gpu_umc_activity{hostname=~"$hostname", instance_shape=~"$instance_shape"} or label_replace(label_replace(DCGM_FI_DEV_MEM_COPY_UTIL{Hostname=~"$hostname", oci_name=~"$oci_name", instance_shape=~"$instance_shape"}, "hostname", "$1", "Hostname", "(.*)"), "gpu_id", "$1", "gpu", "(.*)")',
          legendFormat: '{{ gpu_id }}',
          refId: 'A',
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'datasource',
          uid: '-- Mixed --',
        },
        fieldConfig: {
          defaults: {
            color: {
              mode: 'palette-classic',
            },
            custom: {
              axisBorderShow: false,
              axisCenteredZero: false,
              axisColorMode: 'text',
              axisLabel: '',
              axisPlacement: 'auto',
              barAlignment: 0,
              barWidthFactor: 0.6,
              drawStyle: 'line',
              fillOpacity: 0,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'linear',
              lineWidth: 1,
              pointSize: 5,
              scaleDistribution: {
                type: 'linear',
              },
              showPoints: 'auto',
              spanNulls: false,
              stacking: {
                group: 'A',
                mode: 'none',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            thresholds: thresholds.standardZero,
            unit: 'Bps',
          },
          overrides: [],
        },
        id: 12,
        options: {
          legend: {
            calcs: [
              'p99',
              'p95',
              'p90',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
          },
          tooltip: {
            hideZeros: false,
            mode: 'single',
            sort: 'none',
          },
        },
        pluginVersion: '12.1.1',
        title: 'GPU Fabric Rx + Tx Combined B/W',
        type: 'timeseries',
      },
      layout.grid(24, 8, 0, 20),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'sum by (hostname, gpu_id) ((rate(amd_gpu_xgmi_link_rx{hostname=~"$hostname", instance_shape=~"$instance_shape"}[5m]) + rate(amd_gpu_xgmi_link_tx{hostname=~"$hostname", instance_shape=~"$instance_shape"}[5m])) * 1024) or label_replace(sum by (hostname, gpu) (rate(DCGM_FI_DEV_NVLINK_BANDWIDTH_TOTAL{hostname=~"$hostname", oci_name=~"$oci_name", instance_shape=~"$instance_shape"}[5m])) * 1024, "gpu_id", "$1", "gpu", "(.*)")',
          legendFormat: '{{ gpu_id }}',
          range: true,
          refId: 'A',
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'datasource',
          uid: '-- Mixed --',
        },
        fieldConfig: {
          defaults: {
            color: {
              mode: 'palette-classic',
            },
            custom: {
              axisBorderShow: false,
              axisCenteredZero: false,
              axisColorMode: 'text',
              axisLabel: '',
              axisPlacement: 'auto',
              barAlignment: 0,
              barWidthFactor: 0.6,
              drawStyle: 'line',
              fillOpacity: 0,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'linear',
              lineWidth: 1,
              pointSize: 5,
              scaleDistribution: {
                type: 'linear',
              },
              showPoints: 'auto',
              spanNulls: false,
              stacking: {
                group: 'A',
                mode: 'none',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            thresholds: thresholds.standardZero,
            unit: 'Bps',
          },
          overrides: [],
        },
        id: 15,
        options: {
          legend: {
            calcs: [
              'delta',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
          },
          tooltip: {
            hideZeros: false,
            mode: 'single',
            sort: 'none',
          },
        },
        pluginVersion: '12.1.1',
        title: 'ROCEv2 Rx + Tx Combined B/W',
        type: 'timeseries',
      },
      layout.grid(8, 10, 0, 28),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: '(\nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.H100.8", device=~"mlx5_0|mlx5_1|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7|mlx5_8|mlx5_9|mlx5_10|mlx5_12|mlx5_13|mlx5_14|mlx5_15|mlx5_16|mlx5_17"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.H200.8", device=~"mlx5_0|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_9|mlx5_10|mlx5_11"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.RTXPRO.8", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_6|mlx5_7|mlx5_8|mlx5_9"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.B4.8", device=~"mlx5_1|mlx5_2|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7|mlx5_8|mlx5_9|mlx5_10|mlx5_11|mlx5_12|mlx5_14|mlx5_15|mlx5_16|mlx5_17"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.A100-v2.8", device=~"mlx5_1|mlx5_2|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7|mlx5_8|mlx5_9|mlx5_10|mlx5_11|mlx5_12|mlx5_14|mlx5_15|mlx5_16|mlx5_17"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU4.8", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_6|mlx5_7|mlx5_8|mlx5_9|mlx5_10|mlx5_11|mlx5_12|mlx5_13|mlx5_14|mlx5_15|mlx5_16|mlx5_17"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.MI300X.8", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7|mlx5_8|mlx5_9"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.B200.8", device=~"mlx5_0|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_9|mlx5_10|mlx5_11"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.GB200.4", device=~"mlx5_0|mlx5_1|mlx5_3|mlx5_4"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.GB200-v2.4", device=~"mlx5_0|mlx5_1|mlx5_3|mlx5_4"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.GB200-v3.4", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_5|mlx5_6|mlx5_7|mlx5_8"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.GB300.4", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_5|mlx5_6|mlx5_7|mlx5_8"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.MI355X-v1.8", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7"}[1m]))\nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.MI355X.8", device=~"mlx5_0|mlx5_1"}[1m]))\nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.B300.8", device=~"mlx5_0|mlx5_1|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7|mlx5_8|mlx5_9|mlx5_10|mlx5_12|mlx5_13|mlx5_14|mlx5_15|mlx5_16|mlx5_17"}[1m]))\n)\n+\n(\nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.H100.8", device=~"mlx5_0|mlx5_1|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7|mlx5_8|mlx5_9|mlx5_10|mlx5_12|mlx5_13|mlx5_14|mlx5_15|mlx5_16|mlx5_17"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.H200.8", device=~"mlx5_0|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_9|mlx5_10|mlx5_11"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.RTXPRO.8", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_6|mlx5_7|mlx5_8|mlx5_9"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.B4.8", device=~"mlx5_1|mlx5_2|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7|mlx5_8|mlx5_9|mlx5_10|mlx5_11|mlx5_12|mlx5_14|mlx5_15|mlx5_16|mlx5_17"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.A100-v2.8", device=~"mlx5_1|mlx5_2|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7|mlx5_8|mlx5_9|mlx5_10|mlx5_11|mlx5_12|mlx5_14|mlx5_15|mlx5_16|mlx5_17"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU4.8", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_6|mlx5_7|mlx5_8|mlx5_9|mlx5_10|mlx5_11|mlx5_12|mlx5_13|mlx5_14|mlx5_15|mlx5_16|mlx5_17"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.MI300X.8", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7|mlx5_8|mlx5_9"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.B200.8", device=~"mlx5_0|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_9|mlx5_10|mlx5_11"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.GB200.4", device=~"mlx5_0|mlx5_1|mlx5_3|mlx5_4"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.GB200-v2.4", device=~"mlx5_0|mlx5_1|mlx5_3|mlx5_4"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.GB200-v3.4", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_5|mlx5_6|mlx5_7|mlx5_8"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.GB300.4", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_5|mlx5_6|mlx5_7|mlx5_8"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.MI355X-v1.8", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7"}[1m]))\n\nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.MI355X.8", device=~"mlx5_0|mlx5_1"}[1m]))\nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.B300.8", device=~"mlx5_0|mlx5_1|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7|mlx5_8|mlx5_9|mlx5_10|mlx5_12|mlx5_13|mlx5_14|mlx5_15|mlx5_16|mlx5_17"}[1m]))\n)\n',
          legendFormat: '{{ device }}',
          range: true,
          refId: 'A',
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'datasource',
          uid: '-- Mixed --',
        },
        fieldConfig: {
          defaults: {
            color: {
              mode: 'palette-classic',
            },
            custom: {
              axisBorderShow: false,
              axisCenteredZero: false,
              axisColorMode: 'text',
              axisLabel: '',
              axisPlacement: 'auto',
              barAlignment: 0,
              barWidthFactor: 0.6,
              drawStyle: 'line',
              fillOpacity: 0,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'linear',
              lineWidth: 1,
              pointSize: 5,
              scaleDistribution: {
                type: 'linear',
              },
              showPoints: 'auto',
              spanNulls: false,
              stacking: {
                group: 'A',
                mode: 'none',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            thresholds: thresholds.standardZero,
            unit: 'Bps',
          },
          overrides: [],
        },
        id: 16,
        options: {
          legend: {
            calcs: [
              'delta',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
          },
          tooltip: {
            hideZeros: false,
            mode: 'single',
            sort: 'none',
          },
        },
        pluginVersion: '12.1.1',
        title: 'ROCEv2 Tx B/W',
        type: 'timeseries',
      },
      layout.grid(8, 10, 8, 28),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'sum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.H100.8", device=~"mlx5_0|mlx5_1|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7|mlx5_8|mlx5_9|mlx5_10|mlx5_12|mlx5_13|mlx5_14|mlx5_15|mlx5_16|mlx5_17"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.H200.8", device=~"mlx5_0|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_9|mlx5_10|mlx5_11"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.RTXPRO.8", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_6|mlx5_7|mlx5_8|mlx5_9"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.B4.8", device=~"mlx5_1|mlx5_2|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7|mlx5_8|mlx5_9|mlx5_10|mlx5_11|mlx5_12|mlx5_14|mlx5_15|mlx5_16|mlx5_17"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.A100-v2.8", device=~"mlx5_1|mlx5_2|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7|mlx5_8|mlx5_9|mlx5_10|mlx5_11|mlx5_12|mlx5_14|mlx5_15|mlx5_16|mlx5_17"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU4.8", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_6|mlx5_7|mlx5_8|mlx5_9|mlx5_10|mlx5_11|mlx5_12|mlx5_13|mlx5_14|mlx5_15|mlx5_16|mlx5_17"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.MI300X.8", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7|mlx5_8|mlx5_9"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.B200.8", device=~"mlx5_0|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_9|mlx5_10|mlx5_11"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.GB200.4", device=~"mlx5_0|mlx5_1|mlx5_3|mlx5_4"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.GB200-v2.4", device=~"mlx5_0|mlx5_1|mlx5_3|mlx5_4"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.GB200-v3.4", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_5|mlx5_6|mlx5_7|mlx5_8"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.GB300.4", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_5|mlx5_6|mlx5_7|mlx5_8"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.MI355X-v1.8", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.MI355X.8", device=~"mlx5_0|mlx5_1"}[1m]))\nor \nsum by (device) (irate(node_infiniband_port_data_transmitted_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.B300.8", device=~"mlx5_0|mlx5_1|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7|mlx5_8|mlx5_9|mlx5_10|mlx5_12|mlx5_13|mlx5_14|mlx5_15|mlx5_16|mlx5_17"}[1m]))',
          legendFormat: '{{ device }}',
          range: true,
          refId: 'A',
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'datasource',
          uid: '-- Mixed --',
        },
        fieldConfig: {
          defaults: {
            color: {
              mode: 'palette-classic',
            },
            custom: {
              axisBorderShow: false,
              axisCenteredZero: false,
              axisColorMode: 'text',
              axisLabel: '',
              axisPlacement: 'auto',
              barAlignment: 0,
              barWidthFactor: 0.6,
              drawStyle: 'line',
              fillOpacity: 0,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'linear',
              lineWidth: 1,
              pointSize: 5,
              scaleDistribution: {
                type: 'linear',
              },
              showPoints: 'auto',
              spanNulls: false,
              stacking: {
                group: 'A',
                mode: 'none',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            thresholds: thresholds.standardZero,
            unit: 'Bps',
          },
          overrides: [],
        },
        id: 17,
        options: {
          legend: {
            calcs: [
              'delta',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
          },
          tooltip: {
            hideZeros: false,
            mode: 'single',
            sort: 'none',
          },
        },
        pluginVersion: '12.1.1',
        title: 'ROCEv2 Rx B/W',
        type: 'timeseries',
      },
      layout.grid(8, 10, 16, 28),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'sum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.H100.8", device=~"mlx5_0|mlx5_1|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7|mlx5_8|mlx5_9|mlx5_10|mlx5_12|mlx5_13|mlx5_14|mlx5_15|mlx5_16|mlx5_17"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.H200.8", device=~"mlx5_0|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_9|mlx5_10|mlx5_11"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.RTXPRO.8", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_6|mlx5_7|mlx5_8|mlx5_9"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.B4.8", device=~"mlx5_1|mlx5_2|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7|mlx5_8|mlx5_9|mlx5_10|mlx5_11|mlx5_12|mlx5_14|mlx5_15|mlx5_16|mlx5_17"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.A100-v2.8", device=~"mlx5_1|mlx5_2|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7|mlx5_8|mlx5_9|mlx5_10|mlx5_11|mlx5_12|mlx5_14|mlx5_15|mlx5_16|mlx5_17"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU4.8", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_6|mlx5_7|mlx5_8|mlx5_9|mlx5_10|mlx5_11|mlx5_12|mlx5_13|mlx5_14|mlx5_15|mlx5_16|mlx5_17"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.MI300X.8", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7|mlx5_8|mlx5_9"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.B200.8", device=~"mlx5_0|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_9|mlx5_10|mlx5_11"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.GB200.4", device=~"mlx5_0|mlx5_1|mlx5_3|mlx5_4"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.GB200-v2.4", device=~"mlx5_0|mlx5_1|mlx5_3|mlx5_4"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.GB200-v3.4", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_5|mlx5_6|mlx5_7|mlx5_8"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.GB300.4", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_5|mlx5_6|mlx5_7|mlx5_8"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.MI355X-v1.8", device=~"mlx5_0|mlx5_1|mlx5_2|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7"}[1m])) \nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.MI355X.8", device=~"mlx5_0|mlx5_1"}[1m]))\nor \nsum by (device) (irate(node_infiniband_port_data_received_bytes_total{hostname=~"$hostname", instance_shape="BM.GPU.B300.8", device=~"mlx5_0|mlx5_1|mlx5_3|mlx5_4|mlx5_5|mlx5_6|mlx5_7|mlx5_8|mlx5_9|mlx5_10|mlx5_12|mlx5_13|mlx5_14|mlx5_15|mlx5_16|mlx5_17"}[1m]))',
          legendFormat: '{{ device }}',
          range: true,
          refId: 'A',
        }),
      ],
    ),
  ],
  {},
  [
    variables.fromObject({
      current: {
        text: 'Prometheus',
        value: 'prometheus',
      },
      hide: 1,
      name: 'PROMETHEUS_DS',
      options: [],
      query: 'prometheus',
      refresh: 1,
      type: 'datasource',
    }),
    variables.fromObject({
      current: {
        text: 'All',
        value: [
          '$__all',
        ],
      },
      datasource: {
        type: 'prometheus',
        uid: '${PROMETHEUS_DS}',
      },
      definition: 'label_values(node_uname_info,instance_shape)',
      includeAll: true,
      label: 'Instance Shape',
      multi: true,
      name: 'instance_shape',
      options: [],
      query: {
        qryType: 1,
        query: 'label_values(node_uname_info,instance_shape)',
        refId: 'PrometheusVariableQueryEditor-VariableQuery',
      },
      refresh: 1,
      type: 'query',
    }),
    variables.fromObject({
      current: {
        text: [
          'All',
        ],
        value: [
          '$__all',
        ],
      },
      datasource: {
        type: 'prometheus',
        uid: '${PROMETHEUS_DS}',
      },
      definition: 'label_values(up{instance_shape=~"$instance_shape"},hostname)',
      includeAll: true,
      label: 'Node',
      multi: true,
      name: 'hostname',
      options: [],
      query: {
        qryType: 1,
        query: 'label_values(up{instance_shape=~"$instance_shape"},hostname)',
        refId: 'PrometheusVariableQueryEditor-VariableQuery',
      },
      refresh: 1,
      type: 'query',
    }),
    variables.fromObject({
      current: {
        text: 'All',
        value: [
          '$__all',
        ],
      },
      datasource: {
        type: 'prometheus',
        uid: '${PROMETHEUS_DS}',
      },
      includeAll: true,
      label: 'Display Name',
      multi: true,
      name: 'oci_name',
      options: [],
      query: 'label_values(up{instance_shape=~"$instance_shape"}, oci_name)',
      refresh: 1,
      type: 'query',
    }),
  ],
)
