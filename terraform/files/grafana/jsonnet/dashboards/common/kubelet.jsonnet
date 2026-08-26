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
    id: 48,
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
    title: 'Kubernetes / Kubelet',
    uid: '3138fa155d5915769fbded898ac09fd9',
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
            mappings: [],
            thresholds: thresholds.standardNull,
            unit: 'none',
          },
          overrides: [],
        },
        id: 1,
        interval: '1m',
        options: {
          colorMode: 'none',
          graphMode: 'area',
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
        pluginVersion: '11.5.2',
        title: 'Running Kubelets',
        type: 'stat',
      },
      layout.grid(4, 7, 0, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(kubelet_node_name{cluster="$cluster", job="kubelet", metrics_path="/metrics"})',
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
            mappings: [],
            thresholds: thresholds.standardNull,
            unit: 'none',
          },
          overrides: [],
        },
        id: 2,
        interval: '1m',
        options: {
          colorMode: 'none',
          graphMode: 'area',
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
        pluginVersion: '11.5.2',
        title: 'Running Pods',
        type: 'stat',
      },
      layout.grid(4, 7, 4, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(kubelet_running_pods{cluster="$cluster", job="kubelet", metrics_path="/metrics", instance=~"$instance"})',
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
            mappings: [],
            thresholds: thresholds.standardNull,
            unit: 'none',
          },
          overrides: [],
        },
        id: 3,
        interval: '1m',
        options: {
          colorMode: 'none',
          graphMode: 'area',
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
        pluginVersion: '11.5.2',
        title: 'Running Containers',
        type: 'stat',
      },
      layout.grid(4, 7, 8, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(kubelet_running_containers{cluster="$cluster", job="kubelet", metrics_path="/metrics", instance=~"$instance"})',
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
            mappings: [],
            thresholds: thresholds.standardNull,
            unit: 'none',
          },
          overrides: [],
        },
        id: 4,
        interval: '1m',
        options: {
          colorMode: 'none',
          graphMode: 'area',
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
        pluginVersion: '11.5.2',
        title: 'Actual Volume Count',
        type: 'stat',
      },
      layout.grid(4, 7, 12, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(volume_manager_total_volumes{cluster="$cluster", job="kubelet", metrics_path="/metrics", instance=~"$instance", state="actual_state_of_world"})',
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
            mappings: [],
            thresholds: thresholds.standardNull,
            unit: 'none',
          },
          overrides: [],
        },
        id: 5,
        interval: '1m',
        options: {
          colorMode: 'none',
          graphMode: 'area',
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
        pluginVersion: '11.5.2',
        title: 'Desired Volume Count',
        type: 'stat',
      },
      layout.grid(8, 7, 16, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(volume_manager_total_volumes{cluster="$cluster", job="kubelet", metrics_path="/metrics", instance=~"$instance",state="desired_state_of_world"})',
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
            unit: 'ops',
          },
          overrides: [],
        },
        id: 7,
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
        title: 'Operation Rate',
        type: 'timeseries',
      },
      layout.grid(12, 7, 0, 7),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(kubelet_runtime_operations_total{cluster="$cluster",job="kubelet", metrics_path="/metrics",instance=~"$instance"}[$__rate_interval])) by (operation_type, instance)',
          legendFormat: '{{instance}} {{operation_type}}',
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
            unit: 'ops',
          },
          overrides: [],
        },
        id: 8,
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
        title: 'Operation Error Rate',
        type: 'timeseries',
      },
      layout.grid(12, 7, 12, 7),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(kubelet_runtime_operations_errors_total{cluster="$cluster",job="kubelet", metrics_path="/metrics",instance=~"$instance"}[$__rate_interval])) by (instance, operation_type)',
          legendFormat: '{{instance}} {{operation_type}}',
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
            unit: 's',
          },
          overrides: [],
        },
        id: 9,
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
        title: 'Operation Duration 99th quantile',
        type: 'timeseries',
      },
      layout.grid(24, 7, 0, 14),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'histogram_quantile(0.99, sum(rate(kubelet_runtime_operations_duration_seconds_bucket{cluster="$cluster",job="kubelet", metrics_path="/metrics",instance=~"$instance"}[$__rate_interval])) by (instance, operation_type, le))',
          legendFormat: '{{instance}} {{operation_type}}',
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
            unit: 'ops',
          },
          overrides: [],
        },
        id: 10,
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
        title: 'Pod Start Rate',
        type: 'timeseries',
      },
      layout.grid(12, 7, 0, 21),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(kubelet_pod_start_duration_seconds_count{cluster="$cluster",job="kubelet", metrics_path="/metrics",instance=~"$instance"}[$__rate_interval])) by (instance)',
          legendFormat: '{{instance}} pod',
          refId: 'A',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(kubelet_pod_worker_duration_seconds_count{cluster="$cluster",job="kubelet", metrics_path="/metrics",instance=~"$instance"}[$__rate_interval])) by (instance)',
          legendFormat: '{{instance}} worker',
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
            unit: 's',
          },
          overrides: [],
        },
        id: 11,
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
        title: 'Pod Start Duration',
        type: 'timeseries',
      },
      layout.grid(12, 7, 12, 21),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'histogram_quantile(0.99, sum(rate(kubelet_pod_start_duration_seconds_bucket{cluster="$cluster",job="kubelet", metrics_path="/metrics",instance=~"$instance"}[$__rate_interval])) by (instance, le))',
          legendFormat: '{{instance}} pod',
          refId: 'A',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'histogram_quantile(0.99, sum(rate(kubelet_pod_worker_duration_seconds_bucket{cluster="$cluster",job="kubelet", metrics_path="/metrics",instance=~"$instance"}[$__rate_interval])) by (instance, le))',
          legendFormat: '{{instance}} worker',
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
            unit: 'ops',
          },
          overrides: [],
        },
        id: 12,
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
        title: 'Storage Operation Rate',
        type: 'timeseries',
      },
      layout.grid(24, 7, 0, 28),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(storage_operation_duration_seconds_count{cluster="$cluster",job="kubelet", metrics_path="/metrics",instance=~"$instance"}[$__rate_interval])) by (instance, operation_name, volume_plugin)',
          legendFormat: '{{instance}} {{operation_name}} {{volume_plugin}}',
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
            unit: 's',
          },
          overrides: [],
        },
        id: 14,
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
        title: 'Storage Operation Duration 99th quantile',
        type: 'timeseries',
      },
      layout.grid(24, 7, 0, 35),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'histogram_quantile(0.99, sum(rate(storage_operation_duration_seconds_bucket{cluster="$cluster", job="kubelet", metrics_path="/metrics", instance=~"$instance"}[$__rate_interval])) by (instance, operation_name, volume_plugin, le))',
          legendFormat: '{{instance}} {{operation_name}} {{volume_plugin}}',
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
            unit: 'ops',
          },
          overrides: [],
        },
        id: 15,
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
        title: 'Cgroup manager operation rate',
        type: 'timeseries',
      },
      layout.grid(12, 7, 0, 42),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(kubelet_cgroup_manager_duration_seconds_count{cluster="$cluster", job="kubelet", metrics_path="/metrics", instance=~"$instance"}[$__rate_interval])) by (instance, operation_type)',
          legendFormat: '{{operation_type}}',
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
            unit: 's',
          },
          overrides: [],
        },
        id: 16,
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
        title: 'Cgroup manager 99th quantile',
        type: 'timeseries',
      },
      layout.grid(12, 7, 12, 42),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'histogram_quantile(0.99, sum(rate(kubelet_cgroup_manager_duration_seconds_bucket{cluster="$cluster", job="kubelet", metrics_path="/metrics", instance=~"$instance"}[$__rate_interval])) by (instance, operation_type, le))',
          legendFormat: '{{instance}} {{operation_type}}',
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
            unit: 'ops',
          },
          overrides: [],
        },
        id: 17,
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
        title: 'PLEG relist rate',
        type: 'timeseries',
      },
      layout.grid(12, 7, 0, 49),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(kubelet_pleg_relist_duration_seconds_count{cluster="$cluster", job="kubelet", metrics_path="/metrics", instance=~"$instance"}[$__rate_interval])) by (instance)',
          legendFormat: '{{instance}}',
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
            unit: 's',
          },
          overrides: [],
        },
        id: 18,
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
        title: 'PLEG relist interval',
        type: 'timeseries',
      },
      layout.grid(12, 7, 12, 49),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'histogram_quantile(0.99, sum(rate(kubelet_pleg_relist_interval_seconds_bucket{cluster="$cluster",job="kubelet", metrics_path="/metrics",instance=~"$instance"}[$__rate_interval])) by (instance, le))',
          legendFormat: '{{instance}}',
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
            unit: 's',
          },
          overrides: [],
        },
        id: 19,
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
        title: 'PLEG relist duration',
        type: 'timeseries',
      },
      layout.grid(24, 7, 0, 56),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'histogram_quantile(0.99, sum(rate(kubelet_pleg_relist_duration_seconds_bucket{cluster="$cluster",job="kubelet", metrics_path="/metrics",instance=~"$instance"}[$__rate_interval])) by (instance, le))',
          legendFormat: '{{instance}}',
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
            unit: 'ops',
          },
          overrides: [],
        },
        id: 20,
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
        title: 'RPC rate',
        type: 'timeseries',
      },
      layout.grid(24, 7, 0, 63),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(rest_client_requests_total{cluster="$cluster",job="kubelet", metrics_path="/metrics", instance=~"$instance",code=~"2.."}[$__rate_interval]))',
          legendFormat: '2xx',
          refId: 'A',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(rest_client_requests_total{cluster="$cluster",job="kubelet", metrics_path="/metrics", instance=~"$instance",code=~"3.."}[$__rate_interval]))',
          legendFormat: '3xx',
          refId: 'B',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(rest_client_requests_total{cluster="$cluster",job="kubelet", metrics_path="/metrics", instance=~"$instance",code=~"4.."}[$__rate_interval]))',
          legendFormat: '4xx',
          refId: 'C',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(rest_client_requests_total{cluster="$cluster",job="kubelet", metrics_path="/metrics", instance=~"$instance",code=~"5.."}[$__rate_interval]))',
          legendFormat: '5xx',
          refId: 'D',
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
            unit: 's',
          },
          overrides: [],
        },
        id: 21,
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
        title: 'Request duration 99th quantile',
        type: 'timeseries',
      },
      layout.grid(24, 7, 0, 70),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'histogram_quantile(0.99, sum(rate(rest_client_request_duration_seconds_bucket{cluster="$cluster",job="kubelet", metrics_path="/metrics", instance=~"$instance"}[$__rate_interval])) by (instance, verb, le))',
          legendFormat: '{{instance}} {{verb}}',
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
            unit: 'bytes',
          },
          overrides: [],
        },
        id: 22,
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
        title: 'Memory',
        type: 'timeseries',
      },
      layout.grid(8, 7, 0, 77),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'process_resident_memory_bytes{cluster="$cluster",job="kubelet", metrics_path="/metrics",instance=~"$instance"}',
          legendFormat: '{{instance}}',
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
            unit: 'short',
          },
          overrides: [],
        },
        id: 23,
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
        title: 'CPU usage',
        type: 'timeseries',
      },
      layout.grid(8, 7, 8, 77),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'rate(process_cpu_seconds_total{cluster="$cluster",job="kubelet", metrics_path="/metrics",instance=~"$instance"}[$__rate_interval])',
          legendFormat: '{{instance}}',
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
            unit: 'short',
          },
          overrides: [],
        },
        id: 24,
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
        title: 'Goroutines',
        type: 'timeseries',
      },
      layout.grid(8, 7, 16, 77),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'go_goroutines{cluster="$cluster",job="kubelet", metrics_path="/metrics",instance=~"$instance"}',
          legendFormat: '{{instance}}',
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
      query: 'label_values(up{job="kubelet", metrics_path="/metrics"}, cluster)',
      refresh: 2,
      sort: 1,
      type: 'query',
    }),
    variables.fromObject({
      current: {
        text: 'All',
        value: '$__all',
      },
      datasource: {
        type: 'prometheus',
        uid: '${datasource}',
      },
      includeAll: true,
      label: 'instance',
      name: 'instance',
      options: [],
      query: 'label_values(up{job="kubelet", metrics_path="/metrics",cluster="$cluster"}, instance)',
      refresh: 2,
      type: 'query',
    }),
  ],
)
