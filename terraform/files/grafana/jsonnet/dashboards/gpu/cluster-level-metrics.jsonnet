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
    description: 'Cluster Level Aggregated Metrics Dashboard\n',
    editable: true,
    fiscalYearStartMonth: 0,
    graphTooltip: 1,
    id: 29,
    links: [],
    preload: false,
    refresh: '',
    schemaVersion: 41,
    tags: [],
    time: {
      from: 'now-5m',
      to: 'now',
    },
    timepicker: {},
    timezone: 'browser',
    title: 'Cluster Level Metrics',
    uid: 'cluster-level-metrics',
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
            thresholds: thresholds.utilization,
            unit: 'percent',
          },
          overrides: [],
        },
        id: 1,
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
        title: 'Avg CPU Util %',
        type: 'gauge',
      },
      layout.grid(4, 4, 0, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: '100 * (1 - avg(irate(node_cpu_seconds_total{mode="idle"}[5m])))',
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
            unit: 'percent',
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
        title: 'Avg GPU Util %',
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
          expr: 'avg(amd_gpu_gfx_activity or DCGM_FI_DEV_GPU_UTIL)',
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
            unit: 'percent',
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
        title: 'Avg Memory Usage %',
        type: 'gauge',
      },
      layout.grid(4, 4, 8, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'avg((1 - (node_memory_MemAvailable_bytes/node_memory_MemTotal_bytes)) * 100)',
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
        title: 'Avg CPU Pressure %',
        type: 'gauge',
      },
      layout.grid(4, 4, 12, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'avg(rate(node_pressure_cpu_waiting_seconds_total[5m]) * 100)',
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
            unit: 'percent',
          },
          overrides: [],
        },
        id: 5,
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
        title: 'Avg Memory Pressure %',
        type: 'gauge',
      },
      layout.grid(4, 4, 16, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'avg(rate(node_pressure_memory_stalled_seconds_total[5m]) * 100)',
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
            unit: 'percent',
          },
          overrides: [],
        },
        id: 6,
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
        title: 'Avg IO Pressure %',
        type: 'gauge',
      },
      layout.grid(4, 4, 20, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'avg(rate(node_pressure_io_stalled_seconds_total[5m]) * 100)',
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
        title: 'Cluster Memory Usage',
        type: 'timeseries',
      },
      layout.grid(12, 8, 0, 4),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'avg by (instance_shape) ((1 - (node_memory_MemAvailable_bytes/node_memory_MemTotal_bytes)) * 100)',
          legendFormat: '{{ instance_shape }}',
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
            unit: 'percent',
          },
          overrides: [],
        },
        id: 9,
        options: {
          legend: {
            calcs: [
              'p99',
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
        title: 'Cluster GPU Utilization',
        type: 'timeseries',
      },
      layout.grid(12, 8, 12, 4),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'avg by (instance_shape) (amd_gpu_gfx_activity or DCGM_FI_DEV_GPU_UTIL)',
          legendFormat: '{{ instance_shape }}',
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
            unit: 'celsius',
          },
          overrides: [],
        },
        id: 10,
        options: {
          legend: {
            calcs: [
              'p99',
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
        title: 'Cluster GPU Temperature',
        type: 'timeseries',
      },
      layout.grid(8, 8, 0, 12),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'max by (instance_shape) (amd_gpu_junction_temperature or DCGM_FI_DEV_GPU_TEMP)',
          legendFormat: '{{ instance_shape }}',
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
            unit: 'watts',
          },
          overrides: [],
        },
        id: 11,
        options: {
          legend: {
            calcs: [
              'p99',
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
        title: 'Cluster GPU Power Usage',
        type: 'timeseries',
      },
      layout.grid(8, 8, 8, 12),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'sum by (instance_shape) (amd_gpu_package_power or DCGM_FI_DEV_POWER_USAGE)',
          legendFormat: '{{ instance_shape }}',
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
        id: 12,
        options: {
          legend: {
            calcs: [
              'p99',
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
        title: 'Network Traffic Total RX',
        type: 'timeseries',
      },
      layout.grid(8, 8, 16, 12),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'sum by (instance_shape) (rate(node_network_receive_bytes_total{device!~"lo|docker.*|rdma.*"}[5m]))',
          legendFormat: '{{ instance_shape }}',
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
        id: 13,
        options: {
          legend: {
            calcs: [
              'p99',
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
        title: 'Network Traffic Total TX',
        type: 'timeseries',
      },
      layout.grid(8, 8, 0, 20),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'sum by (instance_shape) (rate(node_network_transmit_bytes_total{device!~"lo|docker.*|rdma.*"}[5m]))',
          legendFormat: '{{ instance_shape }}',
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
        id: 14,
        options: {
          legend: {
            calcs: [
              'p99',
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
        title: 'Disk Read Total',
        type: 'timeseries',
      },
      layout.grid(8, 8, 8, 20),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'sum by (instance_shape) (irate(node_disk_read_bytes_total[5m]))',
          legendFormat: '{{ instance_shape }}',
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
              'p99',
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
        title: 'Disk Write Total',
        type: 'timeseries',
      },
      layout.grid(8, 8, 16, 20),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'sum by (instance_shape) (irate(node_disk_written_bytes_total[5m]))',
          legendFormat: '{{ instance_shape }}',
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
      regex: '',
      type: 'query',
    }),
  ],
)
