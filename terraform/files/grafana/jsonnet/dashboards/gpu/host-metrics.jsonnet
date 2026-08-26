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
    description: 'Host Metrics Dashboard for a single cluster node.\n',
    editable: true,
    fiscalYearStartMonth: 0,
    graphTooltip: 1,
    id: 28,
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
    title: 'Host Metrics',
    uid: 'host-metrics-single',
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
            thresholds: thresholds.inverseRisk,
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
        title: 'CPU Avail',
        type: 'gauge',
      },
      layout.grid(4, 4, 0, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'ceil(100 * (avg by (hostname, oci_name) (irate(node_cpu_seconds_total{hostname=~"$hostname",oci_name=~"$oci_name",instance_shape=~"$instance_shape",mode="idle"}[5m]))))',
          legendFormat: '{{hostname}}',
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
            thresholds: thresholds.inverseRisk,
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
        title: 'Memory Avail',
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
          expr: 'ceil((node_memory_MemAvailable_bytes{hostname=~"$hostname",oci_name=~"$oci_name",instance_shape=~"$instance_shape"}/node_memory_MemTotal_bytes{hostname=~"$hostname",oci_name=~"$oci_name",instance_shape=~"$instance_shape"})*100)',
          legendFormat: '{{hostname}}',
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
            thresholds: thresholds.inverseRisk,
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
        title: 'Boot Vol Avail',
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
          expr: 'ceil((node_filesystem_avail_bytes{hostname=~"$hostname",oci_name=~"$oci_name",instance_shape=~"$instance_shape",mountpoint=~"/"} / node_filesystem_size_bytes{hostname=~"$hostname",oci_name=~"$oci_name",instance_shape=~"$instance_shape",mountpoint=~"/"})*100)',
          legendFormat: '{{hostname}}',
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
        title: 'CPU Pressure',
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
          expr: 'ceil(avg by (hostname, oci_name) (rate(node_pressure_cpu_waiting_seconds_total{hostname=~"$hostname",oci_name=~"$oci_name",instance_shape=~"$instance_shape"}[5m]) * 100))',
          legendFormat: '{{hostname}}',
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
        title: 'Memory Stalled',
        type: 'gauge',
      },
      layout.grid(4, 4, 16, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'ceil(avg by (hostname, oci_name) (rate(node_pressure_memory_stalled_seconds_total{hostname=~"$hostname",oci_name=~"$oci_name",instance_shape=~"$instance_shape"}[5m]) * 100))',
          legendFormat: '{{hostname}}',
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
        title: 'IO Stalled',
        type: 'gauge',
      },
      layout.grid(4, 4, 20, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'ceil(avg by (hostname, oci_name) (rate(node_pressure_io_stalled_seconds_total{hostname=~"$hostname",oci_name=~"$oci_name",instance_shape=~"$instance_shape"}[5m]) * 100))',
          legendFormat: '{{hostname}}',
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
        title: 'Memory Utilization',
        type: 'timeseries',
      },
      layout.grid(24, 8, 0, 4),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'ceil((1 - (node_memory_MemAvailable_bytes{hostname=~"$hostname",oci_name=~"$oci_name",instance_shape=~"$instance_shape"}/node_memory_MemTotal_bytes{hostname=~"$hostname",oci_name=~"$oci_name",instance_shape=~"$instance_shape"}))*100)',
          legendFormat: '{{ hostname }}',
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
        title: 'Disk reads',
        type: 'timeseries',
      },
      layout.grid(12, 8, 0, 12),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'irate(node_disk_read_bytes_total{hostname=~"$hostname",oci_name=~"$oci_name",instance_shape=~"$instance_shape"}[5m])',
          legendFormat: '{{ device }}',
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
        title: 'Disk writes',
        type: 'timeseries',
      },
      layout.grid(12, 8, 12, 12),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'irate(node_disk_written_bytes_total{hostname=~"$hostname",oci_name=~"$oci_name",instance_shape=~"$instance_shape"}[5m])',
          legendFormat: '{{ device }}',
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
            thresholds: thresholds.legacyNoValue,
            unit: 'Bps',
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
        pluginVersion: '12.0.2',
        title: 'Network Traffic Received',
        type: 'timeseries',
      },
      layout.grid(12, 8, 0, 20),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'rate(node_network_receive_bytes_total{hostname=~"$hostname",oci_name=~"$oci_name",instance_shape=~"$instance_shape",device=~"$device",device!~"lo|docker.*|rdma.*"}[5m])',
          legendFormat: '{{ device }}',
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
            thresholds: thresholds.legacyNoValue,
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
        pluginVersion: '12.0.2',
        title: 'Network Traffic Transmitted',
        type: 'timeseries',
      },
      layout.grid(12, 8, 12, 20),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'rate(node_network_transmit_bytes_total{hostname=~"$hostname",oci_name=~"$oci_name",instance_shape=~"$instance_shape",device=~"$device",device!~"lo|docker.*|rdma.*"}[5m])',
          legendFormat: '{{ device }}',
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
      label: 'Node',
      multi: true,
      name: 'hostname',
      options: [],
      query: 'label_values(up{instance_shape=~"$instance_shape"}, hostname)',
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
      label: 'File System Type',
      multi: true,
      name: 'fstype',
      options: [],
      query: 'label_values(node_filesystem_free_bytes, fstype)',
      refresh: 1,
      type: 'query',
    }),
    variables.fromObject({
      current: {
        text: 'All',
        value: '$__all',
      },
      datasource: {
        type: 'prometheus',
        uid: '${PROMETHEUS_DS}',
      },
      includeAll: true,
      label: 'Interface',
      multi: true,
      name: 'interface',
      options: [],
      query: 'label_values(rdma_np_ecn_marked_roce_packets, interface)',
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
      label: 'Device',
      multi: true,
      name: 'device',
      options: [],
      query: 'label_values(node_network_receive_bytes_total, device)',
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
      label: 'Mountpoint',
      multi: true,
      name: 'mountpoint',
      options: [],
      query: 'label_values(node_filesystem_free_bytes, mountpoint)',
      refresh: 1,
      type: 'query',
    }),
  ],
)
