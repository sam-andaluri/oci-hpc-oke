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
    description: 'Command Center\n',
    editable: true,
    fiscalYearStartMonth: 0,
    graphTooltip: 1,
    id: 20,
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
    title: 'Command Center',
    uid: 'command-center',
    version: 9,
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
        title: 'Total Nodes',
        type: 'stat',
      },
      layout.grid(8, 4, 0, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'count(count by(node) (kube_node_info))',
          refId: 'A',
          instant: true,
          range: false,
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
            thresholds: thresholds.greenOnly,
          },
          overrides: [],
        },
        id: 2,
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
        title: 'CPU Nodes',
        type: 'stat',
      },
      layout.grid(8, 4, 8, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'count(count by(node) (kube_node_info))\n-\ncount(count by(node) (kube_node_status_capacity{resource=~"(amd|nvidia)_com_gpu"} > 0))',
          range: false,
          refId: 'A',
          instant: true,
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
            thresholds: thresholds.greenOnly,
          },
          overrides: [],
        },
        id: 3,
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
        title: 'GPU Nodes',
        type: 'stat',
      },
      layout.grid(8, 4, 16, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'count(count by(node) (kube_node_status_capacity{resource=~"(amd|nvidia)_com_gpu"} > 0))',
          range: false,
          refId: 'A',
          instant: true,
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
            thresholds: thresholds.greenOnly,
          },
          overrides: [],
        },
        id: 4,
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
        title: 'Healthy GPU Nodes',
        type: 'stat',
      },
      layout.grid(8, 4, 0, 4),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'count(\n  node_health_status == 1\n  and on(hostname)\n  label_replace(\n    max by(node) (\n      kube_node_status_capacity{resource=~"(amd|nvidia)_com_gpu"} > 0\n    ),\n    "hostname", "$1", "node", "(.*)"\n  )\n)\nor vector(0)',
          range: false,
          refId: 'A',
          instant: true,
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
            thresholds: thresholds.greenOnly,
          },
          overrides: [],
        },
        id: 5,
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
        title: 'Total GPUs',
        type: 'stat',
      },
      layout.grid(8, 4, 8, 4),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'sum(kube_node_status_capacity{resource=~"(amd|nvidia)_com_gpu"})',
          refId: 'A',
          instant: true,
          range: false,
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
            thresholds: thresholds.greenOnly,
          },
          overrides: [],
        },
        id: 6,
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
        title: 'Healthy GPUs',
        type: 'stat',
      },
      layout.grid(8, 4, 16, 4),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'sum(\n  label_replace(\n    kube_node_status_capacity{resource=~"(amd|nvidia)_com_gpu"},\n    "hostname", "$1", "node", "(.*)"\n  )\n  * on(hostname) group_left()\n  (node_health_status == 1)\n)\nor vector(0)',
          range: false,
          refId: 'A',
          instant: true,
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
            links: [
              {
                targetBlank: true,
                title: 'Host Metrics',
                url: '/d/host-metrics-single/host-metrics?var-hostname=${__field.labels.hostname}',
              },
              {
                targetBlank: true,
                title: 'GPU Metrics',
                url: '/d/gpu-metrics-single/gpu-metrics?var-hostname=${__field.labels.hostname}',
              },
              {
                targetBlank: true,
                title: 'GPU Health',
                url: '/d/gpu-health/gpu-health-status?var-hostname=${__field.labels.hostname}',
              },
            ],
            mappings: [
              {
                options: {
                  '0': {
                    color: 'red',
                    text: 'Failed',
                  },
                  '1': {
                    color: 'green',
                    text: 'Healthy',
                  },
                  '2': {
                    color: 'yellow',
                    text: 'Unknown',
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
        id: 7,
        links: [
          {
            targetBlank: true,
            title: 'Cluster Metrics',
            url: '/d/cluster-level-metrics/cluster-level-metrics',
          },
          {
            targetBlank: true,
            title: 'Multi Node Metrics',
            url: '/d/multi-node-metrics/multi-node-metrics?var-hostname=$__all',
          },
        ],
        options: {
          colorMode: 'background',
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
          textMode: 'name',
          wideLayout: true,
        },
        pluginVersion: '12.1.1',
        title: 'Compute Node Health',
        type: 'stat',
      },
      layout.grid(24, 5, 0, 8),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'node_health_status\nand on(hostname)\nlabel_replace(\n  max by(node) (\n    kube_node_status_capacity{resource=~"(amd|nvidia)_com_gpu"} > 0\n  ),\n  "hostname", "$1", "node", "(.*)"\n)',
          legendFormat: '{{ hostname }}',
          range: false,
          refId: 'A',
          instant: true,
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
              mode: 'continuous-GrYlRd',
            },
            custom: {
              axisPlacement: 'auto',
              fillOpacity: 70,
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineWidth: 0,
              spanNulls: false,
            },
            mappings: [
              {
                options: {
                  '0': {
                    color: 'red',
                    text: 'Failed',
                  },
                  '1': {
                    color: 'green',
                    text: 'Healthy',
                  },
                  '2': {
                    color: 'yellow',
                    text: 'Unknown',
                  },
                },
                type: 'value',
              },
            ],
            thresholds: thresholds.standardZero,
          },
          overrides: [],
        },
        id: 8,
        options: {
          alignValue: 'left',
          legend: {
            displayMode: 'list',
            placement: 'bottom',
            showLegend: true,
          },
          mergeValues: true,
          perPage: 20,
          rowHeight: 0.9,
          showValue: 'never',
          tooltip: {
            hideZeros: false,
            mode: 'single',
            sort: 'none',
          },
        },
        pluginVersion: '12.1.1',
        title: 'Historical Cluster Node Health',
        type: 'state-timeline',
      },
      layout.grid(24, 10, 0, 13),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: 'node_health_status\nand on(hostname)\nlabel_replace(\n  max by(node) (\n    kube_node_status_capacity{resource=~"(amd|nvidia)_com_gpu"} > 0\n  ),\n  "hostname", "$1", "node", "(.*)"\n)',
          legendFormat: '{{hostname}}',
          range: true,
          refId: 'A',
        }),
      ],
    ),
    panels.fromObject(
      {
        fieldConfig: {
          defaults: {},
          overrides: [],
        },
        id: 9,
        options: {
          alertInstanceLabelFilter: '',
          alertName: '',
          dashboardAlerts: false,
          groupBy: [],
          groupMode: 'default',
          maxItems: 20,
          showInactiveAlerts: false,
          sortOrder: 1,
          stateFilter: {
            'error': true,
            firing: true,
            noData: false,
            normal: false,
            pending: true,
            recovering: true,
          },
          viewMode: 'list',
        },
        pluginVersion: '12.1.1',
        title: 'Cluster Alerts',
        type: 'alertlist',
      },
      layout.grid(24, 5, 0, 23),
      null,
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
              mode: 'continuous-GrYlRd',
            },
            custom: {
              axisPlacement: 'auto',
              fillOpacity: 70,
              hideFrom: {
                legend: false,
                tooltip: false,
                viz: false,
              },
              insertNulls: false,
              lineWidth: 0,
              spanNulls: false,
            },
            mappings: [
              {
                options: {
                  '0': {
                    color: 'red',
                    text: 'Failed',
                  },
                  '2': {
                    color: 'yellow',
                    text: 'Unknown',
                  },
                },
                type: 'value',
              },
            ],
            thresholds: thresholds.standardZero,
          },
          overrides: [],
        },
        id: 10,
        options: {
          alignValue: 'left',
          legend: {
            displayMode: 'list',
            placement: 'bottom',
            showLegend: true,
          },
          mergeValues: true,
          perPage: 20,
          rowHeight: 0.9,
          showValue: 'never',
          tooltip: {
            hideZeros: false,
            mode: 'single',
            sort: 'none',
          },
        },
        pluginVersion: '12.1.1',
        title: 'Historical Cluster Node Issues',
        type: 'state-timeline',
      },
      layout.grid(24, 10, 0, 28),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          editorMode: 'code',
          expr: '0 * label_replace(\n  max by(node, condition) (\n    kube_node_status_condition{condition=~"CpuProfile|DcgmiHealth|GpuBadPages|GpuBus|GpuCount|GpuEcc|GpuFabricMgr|GpuImex|GpuPcie|GpuRowRemap|GpuXid|IpAddress|NodeHasPcieErrors|NvlinkSpeed|OcaVersion|RdmaLink|RdmaLinkFlapping|RdmaRttcc|RdmaVfCounters|RdmaVfRoutes|RdmaWpaAuth|Rocminfo", status="true"} == 1\n  ),\n  "hostname", "$1", "node", "(.*)"\n)\nor\n2 * label_replace(\n  max by(node, condition) (\n    kube_node_status_condition{condition=~"CpuProfile|DcgmiHealth|GpuBadPages|GpuBus|GpuCount|GpuEcc|GpuFabricMgr|GpuImex|GpuPcie|GpuRowRemap|GpuXid|IpAddress|NodeHasPcieErrors|NvlinkSpeed|OcaVersion|RdmaLink|RdmaLinkFlapping|RdmaRttcc|RdmaVfCounters|RdmaVfRoutes|RdmaWpaAuth|Rocminfo", status="unknown"} == 1\n  ),\n  "hostname", "$1", "node", "(.*)"\n)',
          legendFormat: '{{hostname}} / {{condition}}',
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
