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
    editable: true,
    fiscalYearStartMonth: 0,
    graphTooltip: 0,
    id: 60,
    links: [
      {
        asDropdown: true,
        includeVars: true,
        keepTime: true,
        tags: [
          'kubernetes-mixin',
        ],
        targetBlank: false,
        title: 'Kubernetes',
        type: 'dashboards',
      },
    ],
    preload: false,
    refresh: '10s',
    schemaVersion: 40,
    tags: [
      'kubernetes-mixin',
    ],
    time: {
      from: 'now-1h',
      to: 'now',
    },
    timepicker: {},
    timezone: 'utc',
    title: 'Kubernetes / Persistent Volumes',
    uid: '919b92a8e8041bd567af9edab12c840c',
    version: 1,
    weekStart: '',
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
              fillOpacity: 10,
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
              showPoints: 'never',
              spanNulls: true,
              stacking: {
                group: 'A',
                mode: 'none',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            thresholds: thresholds.standardNull,
            unit: 'bytes',
          },
          overrides: [],
        },
        id: 1,
        interval: '1m',
        options: {
          legend: {
            asTable: true,
            calcs: [
              'lastNotNull',
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
        pluginVersion: '11.5.2',
        title: 'Volume Space Usage',
        type: 'timeseries',
      },
      layout.grid(18, 7, 0, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: '(\n  sum without(instance, node) (topk(1, (kubelet_volume_stats_capacity_bytes{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})))\n  -\n  sum without(instance, node) (topk(1, (kubelet_volume_stats_available_bytes{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})))\n)\n',
          legendFormat: 'Used Space',
          refId: 'A',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum without(instance, node) (topk(1, (kubelet_volume_stats_available_bytes{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})))\n',
          legendFormat: 'Free Space',
          refId: 'B',
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
              mode: 'thresholds',
            },
            mappings: [],
            max: 100,
            min: 0,
            thresholds: thresholds.warning80Critical90,
            unit: 'percent',
          },
          overrides: [],
        },
        id: 2,
        interval: '1m',
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
        pluginVersion: '11.5.2',
        title: 'Volume Space Usage',
        type: 'gauge',
      },
      layout.grid(6, 7, 18, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'max without(instance,node) (\n(\n  topk(1, kubelet_volume_stats_capacity_bytes{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})\n  -\n  topk(1, kubelet_volume_stats_available_bytes{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})\n)\n/\ntopk(1, kubelet_volume_stats_capacity_bytes{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})\n* 100)\n',
          instant: true,
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
              fillOpacity: 10,
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
              showPoints: 'never',
              spanNulls: true,
              stacking: {
                group: 'A',
                mode: 'none',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            thresholds: thresholds.standardNull,
            unit: 'none',
          },
          overrides: [],
        },
        id: 3,
        interval: '1m',
        options: {
          legend: {
            asTable: true,
            calcs: [
              'lastNotNull',
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
        pluginVersion: '11.5.2',
        title: 'Volume inodes Usage',
        type: 'timeseries',
      },
      layout.grid(18, 7, 0, 7),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum without(instance, node) (topk(1, (kubelet_volume_stats_inodes_used{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})))',
          legendFormat: 'Used inodes',
          refId: 'A',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: '(\n  sum without(instance, node) (topk(1, (kubelet_volume_stats_inodes{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})))\n  -\n  sum without(instance, node) (topk(1, (kubelet_volume_stats_inodes_used{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})))\n)\n',
          legendFormat: 'Free inodes',
          refId: 'B',
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
              mode: 'thresholds',
            },
            mappings: [],
            max: 100,
            min: 0,
            thresholds: thresholds.warning80Critical90,
            unit: 'percent',
          },
          overrides: [],
        },
        id: 4,
        interval: '1m',
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
        pluginVersion: '11.5.2',
        title: 'Volume inodes Usage',
        type: 'gauge',
      },
      layout.grid(6, 7, 18, 7),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'max without(instance,node) (\ntopk(1, kubelet_volume_stats_inodes_used{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})\n/\ntopk(1, kubelet_volume_stats_inodes{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})\n* 100)\n',
          instant: true,
          refId: 'A',
        }),
      ],
    ),
  ],
  {},
  [
    variables.fromObject({
      current: {
        text: 'default',
        value: 'default',
      },
      label: 'Data source',
      name: 'datasource',
      options: [],
      query: 'prometheus',
      refresh: 1,
      regex: '',
      type: 'datasource',
    }),
    variables.fromObject({
      allValue: '.*',
      current: {
        text: '',
        value: '',
      },
      datasource: {
        type: 'prometheus',
        uid: '${datasource}',
      },
      hide: 2,
      label: 'cluster',
      name: 'cluster',
      options: [],
      query: 'label_values(kubelet_volume_stats_capacity_bytes{job="kubelet", metrics_path="/metrics"}, cluster)',
      refresh: 2,
      sort: 1,
      type: 'query',
    }),
    variables.fromObject({
      current: {
        text: 'monitoring',
        value: 'monitoring',
      },
      datasource: {
        type: 'prometheus',
        uid: '${datasource}',
      },
      label: 'Namespace',
      name: 'namespace',
      options: [],
      query: 'label_values(kubelet_volume_stats_capacity_bytes{cluster="$cluster", job="kubelet", metrics_path="/metrics"}, namespace)',
      refresh: 2,
      sort: 1,
      type: 'query',
    }),
    variables.fromObject({
      current: {
        text: 'storage-kube-prometheus-stack-grafana-0',
        value: 'storage-kube-prometheus-stack-grafana-0',
      },
      datasource: {
        type: 'prometheus',
        uid: '${datasource}',
      },
      label: 'PersistentVolumeClaim',
      name: 'volume',
      options: [],
      query: 'label_values(kubelet_volume_stats_capacity_bytes{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace"}, persistentvolumeclaim)',
      refresh: 2,
      sort: 1,
      type: 'query',
    }),
  ],
)
