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
    id: 44,
    links: [],
    liveNow: false,
    refresh: '',
    schemaVersion: 38,
    tags: [],
    time: {
      from: 'now-12h',
      to: 'now',
    },
    timepicker: {},
    timezone: '',
    title: 'Scheduling',
    uid: 'abc4098b-10fd-4fc6-8eaa-e302a5a1b573',
    version: 12,
    weekStart: '',
  },
  [
    panels.fromObject(
      {
        datasource: {
          type: 'prometheus',
          uid: 'prometheus',
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
              drawStyle: 'bars',
              fillOpacity: 100,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'stepBefore',
              lineWidth: 1,
              pointSize: 5,
              scaleDistribution: {
                type: 'linear',
              },
              showPoints: 'auto',
              spanNulls: false,
              stacking: {
                group: 'A',
                mode: 'normal',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            thresholds: thresholds.standardNull,
          },
          overrides: [],
        },
        id: 6,
        maxDataPoints: 100,
        options: {
          legend: {
            calcs: [
              'last',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
            sortBy: 'Last',
            sortDesc: true,
          },
          tooltip: {
            mode: 'multi',
            sort: 'desc',
          },
        },
        title: 'Waiting Pods by Reason',
        type: 'timeseries',
      },
      layout.grid(24, 7, 0, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'sum by(name, reason, namespace) (topk(5, label_replace(sum by(namespace, reason, pod) (max_over_time(kube_pod_container_status_waiting_reason[$__interval])) > 0, "name", "$1", "pod", "(.*)-[a-z0-9]*$")))',
          fullMetaSearch: false,
          hide: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '{{namespace}}/{{name}} {{reason}}',
          range: true,
          refId: 'B',
          useBackend: false,
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'prometheus',
          uid: 'prometheus',
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
              drawStyle: 'bars',
              fillOpacity: 100,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'stepBefore',
              lineWidth: 1,
              pointSize: 5,
              scaleDistribution: {
                type: 'linear',
              },
              showPoints: 'auto',
              spanNulls: false,
              stacking: {
                group: 'A',
                mode: 'normal',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            thresholds: thresholds.standardNull,
          },
          overrides: [],
        },
        id: 5,
        maxDataPoints: 100,
        options: {
          legend: {
            calcs: [
              'sum',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
            sortBy: 'Total',
            sortDesc: true,
          },
          tooltip: {
            mode: 'single',
            sort: 'none',
          },
        },
        title: 'Terminated Pods',
        type: 'timeseries',
      },
      layout.grid(12, 6, 0, 7),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'sum by(namespace, reason) (max_over_time(kube_pod_container_status_terminated_reason[$__interval])) > 0',
          fullMetaSearch: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '{{reason}}: {{namespace}}',
          range: true,
          refId: 'A',
          useBackend: false,
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'prometheus',
          uid: 'prometheus',
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
              drawStyle: 'bars',
              fillOpacity: 100,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'stepBefore',
              lineWidth: 1,
              pointSize: 5,
              scaleDistribution: {
                type: 'linear',
              },
              showPoints: 'auto',
              spanNulls: false,
              stacking: {
                group: 'A',
                mode: 'normal',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            thresholds: thresholds.standardNull,
          },
          overrides: [],
        },
        id: 16,
        maxDataPoints: 100,
        options: {
          legend: {
            calcs: [
              'last',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
            sortBy: 'Last',
            sortDesc: true,
          },
          tooltip: {
            mode: 'single',
            sort: 'none',
          },
        },
        title: 'Terminated Pods',
        type: 'timeseries',
      },
      layout.grid(12, 6, 12, 7),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'sum by(namespace, reason, pod) (max_over_time(kube_pod_container_status_terminated_reason[$__interval])) > 0',
          fullMetaSearch: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '{{reason}}: {{namespace}} {{pod}}',
          range: true,
          refId: 'A',
          useBackend: false,
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'prometheus',
          uid: 'prometheus',
        },
        description: '',
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
              drawStyle: 'bars',
              fillOpacity: 84,
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
            min: 0,
            thresholds: thresholds.standardNull,
          },
          overrides: [
            {
              matcher: {
                id: 'byName',
                options: 'Allocatable',
              },
              properties: [
                {
                  id: 'custom.drawStyle',
                  value: 'line',
                },
                {
                  id: 'custom.fillOpacity',
                  value: 0,
                },
                {
                  id: 'custom.insertNulls',
                  value: 3600000,
                },
              ],
            },
            {
              matcher: {
                id: 'byName',
                options: 'Util',
              },
              properties: [
                {
                  id: 'custom.drawStyle',
                  value: 'line',
                },
                {
                  id: 'custom.axisPlacement',
                  value: 'right',
                },
                {
                  id: 'custom.fillOpacity',
                  value: 5,
                },
                {
                  id: 'unit',
                  value: 'percentunit',
                },
                {
                  id: 'noValue',
                  value: '0',
                },
              ],
            },
            {
              matcher: {
                id: 'byName',
                options: 'Remaining',
              },
              properties: [
                {
                  id: 'custom.drawStyle',
                  value: 'line',
                },
                {
                  id: 'custom.fillOpacity',
                  value: 0,
                },
              ],
            },
          ],
        },
        id: 4,
        maxDataPoints: 100,
        options: {
          legend: {
            calcs: [
              'lastNotNull',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
            sortBy: 'Last *',
            sortDesc: true,
          },
          tooltip: {
            mode: 'multi',
            sort: 'desc',
          },
        },
        title: 'GPUs',
        type: 'timeseries',
      },
      layout.grid(12, 6, 0, 13),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'max(sum by(instance) (kube_node_status_allocatable{resource="nvidia_com_gpu"}))',
          fullMetaSearch: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: 'Allocatable',
          range: true,
          refId: 'Allocatable',
          useBackend: false,
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'sum by(namespace) (kube_pod_container_resource_requests{resource="nvidia_com_gpu"})',
          fullMetaSearch: false,
          hide: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: 'Request {{namespace}}',
          range: true,
          refId: 'Requests',
          useBackend: false,
        }),
        queries.fromObject({
          datasource: {
            name: 'Expression',
            type: '__expr__',
            uid: '__expr__',
          },
          expression: '$Allocatable - $Requests',
          hide: false,
          refId: 'Remaining',
          type: 'math',
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'prometheus',
          uid: 'prometheus',
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
              drawStyle: 'bars',
              fillOpacity: 100,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'stepBefore',
              lineWidth: 1,
              pointSize: 5,
              scaleDistribution: {
                type: 'linear',
              },
              showPoints: 'auto',
              spanNulls: false,
              stacking: {
                group: 'A',
                mode: 'normal',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            thresholds: thresholds.standardNull,
          },
          overrides: [],
        },
        id: 1,
        maxDataPoints: 100,
        options: {
          legend: {
            calcs: [
              'last',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
            sortBy: 'Last',
            sortDesc: true,
          },
          tooltip: {
            mode: 'single',
            sort: 'none',
          },
        },
        title: 'Pod Status Reasons by Namespace',
        type: 'timeseries',
      },
      layout.grid(12, 6, 12, 13),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'sum by(namespace, reason) (max_over_time(kube_pod_status_reason[$__interval])) > 0',
          fullMetaSearch: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '{{reason}}: {{namespace}}',
          range: true,
          refId: 'A',
          useBackend: false,
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'prometheus',
          uid: 'prometheus',
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
              axisLabel: 'Available GPUs',
              axisPlacement: 'auto',
              barAlignment: 0,
              drawStyle: 'line',
              fillOpacity: 0,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'stepBefore',
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
            min: 0,
            thresholds: thresholds.standardNull,
            unit: 'none',
          },
          overrides: [],
        },
        id: 10,
        maxDataPoints: 100,
        options: {
          legend: {
            calcs: [
              'last',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
            sortBy: 'Last',
            sortDesc: false,
          },
          tooltip: {
            mode: 'multi',
            sort: 'desc',
          },
        },
        title: 'Nodes with GPU Scheduling Impact',
        type: 'timeseries',
      },
      layout.grid(12, 6, 0, 19),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'code',
          expr: 'bottomk(10,(max by(node) (max_over_time(kube_node_status_allocatable{resource="nvidia_com_gpu"}[$__interval])) - sum by(node) (max_over_time(kube_pod_container_resource_requests{resource="nvidia_com_gpu"}[$__interval]))) != 8) >= -10000',
          fullMetaSearch: false,
          hide: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '{{node}} {{node_prefix}}',
          range: true,
          refId: 'Remaining',
          useBackend: false,
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'prometheus',
          uid: 'prometheus',
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
              drawStyle: 'bars',
              fillOpacity: 100,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'stepBefore',
              lineWidth: 1,
              pointSize: 5,
              scaleDistribution: {
                type: 'linear',
              },
              showPoints: 'auto',
              spanNulls: false,
              stacking: {
                group: 'A',
                mode: 'normal',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            thresholds: thresholds.standardNull,
          },
          overrides: [],
        },
        id: 14,
        maxDataPoints: 100,
        options: {
          legend: {
            calcs: [
              'last',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
            sortBy: 'Last',
            sortDesc: true,
          },
          tooltip: {
            mode: 'multi',
            sort: 'desc',
          },
        },
        title: 'Extra Taints',
        type: 'timeseries',
      },
      layout.grid(12, 6, 12, 19),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'sum by(key) (max_over_time(kube_node_spec_taint{effect=~"NoSchedule|NoExecute", key!="nvidia.com/gpu"}[$__interval]))',
          fullMetaSearch: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '{{key}}',
          range: true,
          refId: 'A',
          useBackend: false,
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'prometheus',
          uid: 'prometheus',
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
              drawStyle: 'line',
              fillOpacity: 0,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'stepBefore',
              lineWidth: 1,
              pointSize: 5,
              scaleDistribution: {
                log: 2,
                type: 'log',
              },
              showPoints: 'auto',
              spanNulls: false,
              stacking: {
                group: 'A',
                mode: 'normal',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            min: 0,
            thresholds: thresholds.standardNull,
            unit: 'bytes',
          },
          overrides: [],
        },
        id: 9,
        maxDataPoints: 100,
        options: {
          legend: {
            calcs: [
              'last',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
            sortBy: 'Last',
            sortDesc: true,
          },
          tooltip: {
            mode: 'single',
            sort: 'none',
          },
        },
        title: 'Node Allocatable Memory by Pool',
        type: 'timeseries',
      },
      layout.grid(8, 6, 0, 25),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: '(sum by(node_prefix) (label_replace(max by(node) (max_over_time(kube_node_status_allocatable{resource="memory"}[$__interval])), "node_prefix", "$2", "node", "(.*)-(gpu|cpu)-.*")) > 0) - (sum by(node_prefix) (label_replace(sum by(node) (max_over_time(kube_pod_container_resource_requests{resource="memory"}[$__interval])), "node_prefix", "$2", "node", "(.*)-(gpu|cpu)-.*")) > 0)',
          fullMetaSearch: false,
          hide: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '{{node}} {{node_prefix}}',
          range: true,
          refId: 'Remaining',
          useBackend: false,
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'prometheus',
          uid: 'prometheus',
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
            thresholds: thresholds.standardNull,
          },
          overrides: [],
        },
        id: 2,
        maxDataPoints: 100,
        options: {
          legend: {
            calcs: [
              'lastNotNull',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
            sortBy: 'Last *',
            sortDesc: true,
          },
          tooltip: {
            mode: 'single',
            sort: 'none',
          },
        },
        title: 'Unavailable DaemonSet Pods',
        type: 'timeseries',
      },
      layout.grid(16, 7, 8, 25),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'max by(daemonset) (max_over_time(kube_daemonset_status_number_unavailable[$__interval])) > 0',
          fullMetaSearch: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '__auto',
          range: true,
          refId: 'A',
          useBackend: false,
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'prometheus',
          uid: 'prometheus',
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
              drawStyle: 'line',
              fillOpacity: 0,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'stepBefore',
              lineWidth: 1,
              pointSize: 5,
              scaleDistribution: {
                log: 2,
                type: 'log',
              },
              showPoints: 'auto',
              spanNulls: false,
              stacking: {
                group: 'A',
                mode: 'normal',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            min: 0,
            thresholds: thresholds.standardNull,
            unit: 'none',
          },
          overrides: [],
        },
        id: 12,
        maxDataPoints: 100,
        options: {
          legend: {
            calcs: [
              'last',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
            sortBy: 'Last',
            sortDesc: true,
          },
          tooltip: {
            mode: 'single',
            sort: 'none',
          },
        },
        title: 'Node Allocatable CPU Cores by Pool',
        type: 'timeseries',
      },
      layout.grid(8, 6, 0, 31),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: '(sum by(node_prefix) (label_replace(max by(node) (max_over_time(kube_node_status_allocatable{resource="cpu"}[$__interval])), "node_prefix", "$2", "node", "(.*)-(gpu|cpu)-.*")) > 0) - (sum by(node_prefix) (label_replace(sum by(node) (max_over_time(kube_pod_container_resource_requests{resource="cpu"}[$__interval])), "node_prefix", "$2", "node", "(.*)-(gpu|cpu)-.*")) > 0)',
          fullMetaSearch: false,
          hide: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '{{node_prefix}}',
          range: true,
          refId: 'Remaining',
          useBackend: false,
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'prometheus',
          uid: 'prometheus',
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
              drawStyle: 'line',
              fillOpacity: 0,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'stepBefore',
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
            thresholds: thresholds.standardNull,
          },
          overrides: [],
        },
        id: 15,
        maxDataPoints: 100,
        options: {
          legend: {
            calcs: [
              'last',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
            sortBy: 'Last',
            sortDesc: true,
          },
          tooltip: {
            mode: 'multi',
            sort: 'desc',
          },
        },
        title: 'Node Software Versions',
        type: 'timeseries',
      },
      layout.grid(16, 6, 8, 32),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'sum by(kubeproxy_version) (max by(node, kubeproxy_version) (max_over_time(kube_node_info[$__interval])))',
          fullMetaSearch: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: 'kube-proxy {{kubeproxy_version}}',
          range: true,
          refId: 'A',
          useBackend: false,
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'sum by(kubelet_version) (max by(node, kubelet_version) (max_over_time(kube_node_info[$__interval])))',
          fullMetaSearch: false,
          hide: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: 'kubelet {{kubelet_version}}',
          range: true,
          refId: 'B',
          useBackend: false,
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'sum by(container_runtime_version) (max by(node, container_runtime_version) (max_over_time(kube_node_info[$__interval])))',
          fullMetaSearch: false,
          hide: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '{{container_runtime_version}}',
          range: true,
          refId: 'C',
          useBackend: false,
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'sum by(kernel_version) (max by(node, kernel_version) (max_over_time(kube_node_info[$__interval])))',
          fullMetaSearch: false,
          hide: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: 'linux {{kernel_version}}',
          range: true,
          refId: 'D',
          useBackend: false,
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'prometheus',
          uid: 'prometheus',
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
              drawStyle: 'line',
              fillOpacity: 0,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'stepBefore',
              lineWidth: 1,
              pointSize: 5,
              scaleDistribution: {
                type: 'linear',
              },
              showPoints: 'auto',
              spanNulls: false,
              stacking: {
                group: 'A',
                mode: 'normal',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            min: 0,
            thresholds: thresholds.standardNull,
            unit: 'bytes',
          },
          overrides: [],
        },
        id: 13,
        maxDataPoints: 100,
        options: {
          legend: {
            calcs: [
              'last',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
            sortBy: 'Last',
            sortDesc: true,
          },
          tooltip: {
            mode: 'single',
            sort: 'none',
          },
        },
        title: 'Node Lowest Allocatable Ephemeral Storage by Pool',
        type: 'timeseries',
      },
      layout.grid(8, 6, 0, 37),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: '(min by(node_prefix) (label_replace(min by(node) (max_over_time(kube_node_status_allocatable{resource="ephemeral_storage"}[$__interval])), "node_prefix", "$2", "node", "(.*)-(gpu|cpu)-.*")) > 0) - (min by(node_prefix) (label_replace(min by(node) (max_over_time(kube_pod_container_resource_requests{resource="ephemeral_storage"}[$__interval])), "node_prefix", "$2", "node", "(.*)-(gpu|cpu)-.*")) > 0)',
          fullMetaSearch: false,
          hide: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '{{node_prefix}}',
          range: true,
          refId: 'Remaining',
          useBackend: false,
        }),
      ],
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'prometheus',
          uid: 'prometheus',
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
              drawStyle: 'bars',
              fillOpacity: 100,
              gradientMode: 'none',
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineInterpolation: 'stepBefore',
              lineWidth: 1,
              pointSize: 5,
              scaleDistribution: {
                type: 'linear',
              },
              showPoints: 'auto',
              spanNulls: false,
              stacking: {
                group: 'A',
                mode: 'normal',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            thresholds: thresholds.standardNull,
          },
          overrides: [],
        },
        id: 7,
        maxDataPoints: 100,
        options: {
          legend: {
            calcs: [
              'last',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
            sortBy: 'Last *',
            sortDesc: true,
          },
          tooltip: {
            mode: 'single',
            sort: 'none',
          },
        },
        title: 'Node Error Conditions',
        type: 'timeseries',
      },
      layout.grid(12, 6, 8, 38),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'sum(max by(node) (max_over_time(kube_node_status_condition{condition="Ready", status="false"}[$__interval])) > 0)',
          fullMetaSearch: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: 'NotReady',
          range: true,
          refId: 'A',
          useBackend: false,
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'sum(max by(node) (max_over_time(kube_node_status_condition{condition="MemoryPressure", status="true"}[$__interval]))) > 0',
          fullMetaSearch: false,
          hide: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: 'MemoryPressure',
          range: true,
          refId: 'B',
          useBackend: false,
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'sum(max by(node) (max_over_time(kube_node_status_condition{condition="DiskPressure", status="true"}[$__interval]))) > 0',
          fullMetaSearch: false,
          hide: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: 'DiskPressure',
          range: true,
          refId: 'C',
          useBackend: false,
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'sum(max by(node) (max_over_time(kube_node_status_condition{condition="PIDPressure", status="true"}[$__interval]))) > 0',
          fullMetaSearch: false,
          hide: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: 'PIDPressure',
          range: true,
          refId: 'D',
          useBackend: false,
        }),
      ],
    ),
  ],
  {},
  [

  ],
)
