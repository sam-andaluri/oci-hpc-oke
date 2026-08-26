local dashboard = import '../../lib/dashboard.libsonnet';
local layout = import '../../lib/layout.libsonnet';
local panels = import '../../lib/panels.libsonnet';
local queries = import '../../lib/queries.libsonnet';
local thresholds = import '../../lib/thresholds.libsonnet';
local variables = import '../../lib/variables.libsonnet';

local gpuVendor = std.extVar('gpu_vendor');
local includeNvidia = gpuVendor == 'nvidia' || gpuVendor == 'mixed';
local includeAmd = gpuVendor == 'amd' || gpuVendor == 'mixed';
local beforeVendorPanels = [
  panels.fromObject(
    {
      datasource: {
        type: 'datasource',
        uid: '-- Mixed --',
      },
      fieldConfig: {
        defaults: {
          mappings: [
            {
              options: {
                '0': {
                  color: 'red',
                  text: 'Failed',
                },
                '1': {
                  color: 'green',
                  text: 'OK',
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
      title: 'RTTCC',
      type: 'stat',
      description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
    },
    layout.grid(3, 3, 0, 0),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * (\n  label_replace(\n        max by(node) (\n          max_over_time(\n            kube_node_status_condition{\n              condition="RdmaRttcc",\n              status="true",\n              node=~"$hostname"\n            }[$__range]\n          )\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )\n    or\n    2 * (\n  label_replace(\n        max by(node) (\n          kube_node_status_condition{\n            condition="RdmaRttcc",\n            status="unknown",\n            node=~"$hostname"\n          }\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )\n    or\n    1 * (\n  label_replace(\n        max by(node) (\n          kube_node_status_condition{\n            condition="RdmaRttcc",\n            status="false",\n            node=~"$hostname"\n          }\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )',
        legendFormat: '{{hostname}}',
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
          mappings: [
            {
              options: {
                '0': {
                  color: 'red',
                  text: 'Failed',
                },
                '1': {
                  color: 'green',
                  text: 'OK',
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
      title: 'OCA Ver',
      type: 'stat',
      description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
    },
    layout.grid(3, 3, 3, 0),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * (\n  label_replace(\n        max by(node) (\n          max_over_time(\n            kube_node_status_condition{\n              condition="OcaVersion",\n              status="true",\n              node=~"$hostname"\n            }[$__range]\n          )\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )\n    or\n    2 * (\n  label_replace(\n        max by(node) (\n          kube_node_status_condition{\n            condition="OcaVersion",\n            status="unknown",\n            node=~"$hostname"\n          }\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )\n    or\n    1 * (\n  label_replace(\n        max by(node) (\n          kube_node_status_condition{\n            condition="OcaVersion",\n            status="false",\n            node=~"$hostname"\n          }\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )',
        legendFormat: '{{hostname}}',
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
          mappings: [
            {
              options: {
                '0': {
                  color: 'red',
                  text: 'Failed',
                },
                '1': {
                  color: 'green',
                  text: 'OK',
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
      title: 'RDMA Dev',
      type: 'stat',
      description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
    },
    layout.grid(3, 3, 6, 0),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * (\n  label_replace(\n        max by(node) (\n          max_over_time(\n            kube_node_status_condition{\n              condition="RdmaLink",\n              status="true",\n              node=~"$hostname"\n            }[$__range]\n          )\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )\n    or\n    2 * (\n  label_replace(\n        max by(node) (\n          kube_node_status_condition{\n            condition="RdmaLink",\n            status="unknown",\n            node=~"$hostname"\n          }\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )\n    or\n    1 * (\n  label_replace(\n        max by(node) (\n          kube_node_status_condition{\n            condition="RdmaLink",\n            status="false",\n            node=~"$hostname"\n          }\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )',
        legendFormat: '{{hostname}}',
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
          mappings: [
            {
              options: {
                '0': {
                  color: 'red',
                  text: 'Failed',
                },
                '1': {
                  color: 'green',
                  text: 'OK',
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
      title: 'Bus Issue',
      type: 'stat',
      description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
    },
    layout.grid(3, 3, 9, 0),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * (\n  label_replace(\n        max by(node) (\n          max_over_time(\n            kube_node_status_condition{\n              condition="GpuBus",\n              status="true",\n              node=~"$hostname"\n            }[$__range]\n          )\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )\n    or\n    2 * (\n  label_replace(\n        max by(node) (\n          kube_node_status_condition{\n            condition="GpuBus",\n            status="unknown",\n            node=~"$hostname"\n          }\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )\n    or\n    1 * (\n  label_replace(\n        max by(node) (\n          kube_node_status_condition{\n            condition="GpuBus",\n            status="false",\n            node=~"$hostname"\n          }\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )',
        legendFormat: '{{hostname}}',
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
          mappings: [
            {
              options: {
                '0': {
                  color: 'red',
                  text: 'Failed',
                },
                '1': {
                  color: 'green',
                  text: 'OK',
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
      title: 'Link Flap',
      type: 'stat',
      description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
    },
    layout.grid(3, 3, 12, 0),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * (\n  label_replace(\n        max by(node) (\n          max_over_time(\n            kube_node_status_condition{\n              condition="RdmaLinkFlapping",\n              status="true",\n              node=~"$hostname"\n            }[$__range]\n          )\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )\n    or\n    2 * (\n  label_replace(\n        max by(node) (\n          kube_node_status_condition{\n            condition="RdmaLinkFlapping",\n            status="unknown",\n            node=~"$hostname"\n          }\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )\n    or\n    1 * (\n  label_replace(\n        max by(node) (\n          kube_node_status_condition{\n            condition="RdmaLinkFlapping",\n            status="false",\n            node=~"$hostname"\n          }\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )',
        legendFormat: '{{hostname}}',
        range: false,
        refId: 'A',
        instant: true,
      }),
    ],
  ),
];
local nvidiaRowRemap = panels.fromObject(
  {
    datasource: {
      type: 'datasource',
      uid: '-- Mixed --',
    },
    fieldConfig: {
      defaults: {
        mappings: [
          {
            options: {
              '0': {
                color: 'red',
                text: 'Failed',
              },
              '1': {
                color: 'green',
                text: 'OK',
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
    id: 7,
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
    title: 'Row Remap',
    type: 'stat',
    description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
  },
  layout.grid(3, 3, 18, 0),
  [
    queries.fromObject({
      datasource: {
        type: 'prometheus',
        uid: '$PROMETHEUS_DS',
      },
      editorMode: 'code',
      expr: '0 * (\n  label_replace(\n        max by(node) (\n          max_over_time(\n            kube_node_status_condition{\n              condition="GpuRowRemap",\n              status="true",\n              node=~"$hostname"\n            }[$__range]\n          )\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )\n    or\n    2 * (\n  label_replace(\n        max by(node) (\n          kube_node_status_condition{\n            condition="GpuRowRemap",\n            status="unknown",\n            node=~"$hostname"\n          }\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )\n    or\n    1 * (\n  label_replace(\n        max by(node) (\n          kube_node_status_condition{\n            condition="GpuRowRemap",\n            status="false",\n            node=~"$hostname"\n          }\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )',
      legendFormat: '{{hostname}}',
      range: false,
      refId: 'A',
      instant: true,
    }),
  ],
);
local amdGpuBadPages = panels.fromObject(
  {
    datasource: {
      type: 'datasource',
      uid: '-- Mixed --',
    },
    fieldConfig: {
      defaults: {
        mappings: [
          {
            options: {
              '0': {
                color: 'red',
                text: 'Failed',
              },
              '1': {
                color: 'green',
                text: 'OK',
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
    id: 23,
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
    title: 'GPU Bad Pages',
    type: 'stat',
    description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
  },
  layout.grid(3, 3, 15, 0),
  [
    queries.fromObject({
      datasource: {
        type: 'prometheus',
        uid: '$PROMETHEUS_DS',
      },
      editorMode: 'code',
      expr: '0 * (\n  label_replace(\n        max by(node) (\n          max_over_time(\n            kube_node_status_condition{\n              condition="GpuBadPages",\n              status="true",\n              node=~"$hostname"\n            }[$__range]\n          )\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )\n    or\n    2 * (\n  label_replace(\n        max by(node) (\n          kube_node_status_condition{\n            condition="GpuBadPages",\n            status="unknown",\n            node=~"$hostname"\n          }\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )\n    or\n    1 * (\n  label_replace(\n        max by(node) (\n          kube_node_status_condition{\n            condition="GpuBadPages",\n            status="false",\n            node=~"$hostname"\n          }\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )',
      legendFormat: '{{hostname}}',
      range: false,
      refId: 'A',
      instant: true,
    }),
  ],
);
local betweenVendorPanels = [

];
local afterVendorPanels = [
  panels.fromObject(
    {
      datasource: {
        type: 'datasource',
        uid: '-- Mixed --',
      },
      fieldConfig: {
        defaults: {
          mappings: [
            {
              options: {
                '0': {
                  color: 'red',
                  text: 'Failed',
                },
                '1': {
                  color: 'green',
                  text: 'OK',
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
      id: 24,
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
      title: 'GPU Count',
      type: 'stat',
      description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
    },
    layout.grid(3, 3, 21, 0),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * (\n  label_replace(\n        max by(node) (\n          max_over_time(\n            kube_node_status_condition{\n              condition="GpuCount",\n              status="true",\n              node=~"$hostname"\n            }[$__range]\n          )\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )\n    or\n    2 * (\n  label_replace(\n        max by(node) (\n          kube_node_status_condition{\n            condition="GpuCount",\n            status="unknown",\n            node=~"$hostname"\n          }\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )\n    or\n    1 * (\n  label_replace(\n        max by(node) (\n          kube_node_status_condition{\n            condition="GpuCount",\n            status="false",\n            node=~"$hostname"\n          }\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )',
        legendFormat: '{{hostname}}',
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
          mappings: [
            {
              options: {
                '0': {
                  color: 'red',
                  text: 'Failed',
                },
                '1': {
                  color: 'green',
                  text: 'OK',
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
      title: 'ECC',
      type: 'stat',
      description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
    },
    layout.grid(3, 3, 0, 3),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * (\n  label_replace(\n        max by(node) (\n          max_over_time(\n            kube_node_status_condition{\n              condition="GpuEcc",\n              status="true",\n              node=~"$hostname"\n            }[$__range]\n          )\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )\n    or\n    2 * (\n  label_replace(\n        max by(node) (\n          kube_node_status_condition{\n            condition="GpuEcc",\n            status="unknown",\n            node=~"$hostname"\n          }\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )\n    or\n    1 * (\n  label_replace(\n        max by(node) (\n          kube_node_status_condition{\n            condition="GpuEcc",\n            status="false",\n            node=~"$hostname"\n          }\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )',
        legendFormat: '{{hostname}}',
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
          mappings: [
            {
              options: {
                '0': {
                  color: 'red',
                  text: 'Failed',
                },
                '1': {
                  color: 'green',
                  text: 'OK',
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
      title: 'GPU Health',
      type: 'stat',
      description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
    },
    layout.grid(3, 3, 3, 3),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * (\n  (\n    (min by(hostname) (min_over_time(amd_gpu_health{hostname=~"$hostname"}[$__range]))) < bool 1\n  ) == 1\n  or\n  (\n    (max by(hostname) (max_over_time(DCGM_EXP_GPU_HEALTH_STATUS{hostname=~"$hostname"}[$__range]))) > bool 0\n  ) == 1\n)\nor\n(\n  (\n  0 * (\n    label_replace(\n      max by(node) (\n        kube_node_status_capacity{resource=~"(amd|nvidia)_com_gpu", node=~"$hostname"} > 0\n      ),\n      "hostname", "$1", "node", "(.*)"\n    )\n  )\n  + 2\n)\n  unless on(hostname)\n  (\n    max by(hostname) (\n  present_over_time(amd_gpu_health{hostname=~"$hostname"}[10m])\n)\n    or\n    max by(hostname) (\n  present_over_time(DCGM_EXP_GPU_HEALTH_STATUS{hostname=~"$hostname"}[10m])\n)\n  )\n)\nor\n1 * (\n  (\n    (min by(hostname) (min_over_time(amd_gpu_health{hostname=~"$hostname"}[$__range]))) == bool 1\n  ) == 1\n  or\n  (\n    (max by(hostname) (max_over_time(DCGM_EXP_GPU_HEALTH_STATUS{hostname=~"$hostname"}[$__range]))) == bool 0\n  ) == 1\n)',
        legendFormat: '{{hostname}}',
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
          mappings: [
            {
              options: {
                '0': {
                  color: 'red',
                  text: 'Failed',
                },
                '1': {
                  color: 'green',
                  text: 'OK',
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
      id: 9,
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
      title: 'Power Throttle / Violation',
      type: 'stat',
      description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
    },
    layout.grid(3, 3, 6, 3),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * (\n  (\n    (sum by(hostname) (increase(amd_gpu_violation_ppt_residency_accumulated{hostname=~"$hostname"}[$__range]))) > bool 0\n  ) == 1\n  or\n  (\n    (sum by(hostname) (increase(DCGM_FI_DEV_POWER_VIOLATION{hostname=~"$hostname"}[$__range]))) > bool 0\n  ) == 1\n)\nor\n(\n  (\n  0 * (\n    label_replace(\n      max by(node) (\n        kube_node_status_capacity{resource=~"(amd|nvidia)_com_gpu", node=~"$hostname"} > 0\n      ),\n      "hostname", "$1", "node", "(.*)"\n    )\n  )\n  + 2\n)\n  unless on(hostname)\n  (\n    max by(hostname) (\n  present_over_time(amd_gpu_violation_ppt_residency_accumulated{hostname=~"$hostname"}[10m])\n)\n    or\n    max by(hostname) (\n  present_over_time(DCGM_FI_DEV_POWER_VIOLATION{hostname=~"$hostname"}[10m])\n)\n  )\n)\nor\n1 * (\n  (\n    (sum by(hostname) (increase(amd_gpu_violation_ppt_residency_accumulated{hostname=~"$hostname"}[$__range]))) == bool 0\n  ) == 1\n  or\n  (\n    (sum by(hostname) (increase(DCGM_FI_DEV_POWER_VIOLATION{hostname=~"$hostname"}[$__range]))) == bool 0\n  ) == 1\n)',
        legendFormat: '{{hostname}}',
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
          mappings: [
            {
              options: {
                '0': {
                  color: 'red',
                  text: 'Failed',
                },
                '1': {
                  color: 'green',
                  text: 'OK',
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
      title: 'Processor Hot / Board Limit',
      type: 'stat',
      description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
    },
    layout.grid(3, 3, 9, 3),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * (\n  (\n    (sum by(hostname) (increase(amd_gpu_violation_processor_hot_residency_accumulated{hostname=~"$hostname"}[$__range]))) > bool 0\n  ) == 1\n  or\n  (\n    (sum by(hostname) (increase(DCGM_FI_DEV_BOARD_LIMIT_VIOLATION{hostname=~"$hostname"}[$__range]))) > bool 0\n  ) == 1\n)\nor\n(\n  (\n  0 * (\n    label_replace(\n      max by(node) (\n        kube_node_status_capacity{resource=~"(amd|nvidia)_com_gpu", node=~"$hostname"} > 0\n      ),\n      "hostname", "$1", "node", "(.*)"\n    )\n  )\n  + 2\n)\n  unless on(hostname)\n  (\n    max by(hostname) (\n  present_over_time(amd_gpu_violation_processor_hot_residency_accumulated{hostname=~"$hostname"}[10m])\n)\n    or\n    max by(hostname) (\n  present_over_time(DCGM_FI_DEV_BOARD_LIMIT_VIOLATION{hostname=~"$hostname"}[10m])\n)\n  )\n)\nor\n1 * (\n  (\n    (sum by(hostname) (increase(amd_gpu_violation_processor_hot_residency_accumulated{hostname=~"$hostname"}[$__range]))) == bool 0\n  ) == 1\n  or\n  (\n    (sum by(hostname) (increase(DCGM_FI_DEV_BOARD_LIMIT_VIOLATION{hostname=~"$hostname"}[$__range]))) == bool 0\n  ) == 1\n)',
        legendFormat: '{{hostname}}',
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
          mappings: [
            {
              options: {
                '0': {
                  color: 'red',
                  text: 'Failed',
                },
                '1': {
                  color: 'green',
                  text: 'OK',
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
      id: 11,
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
      title: 'Thermal Violation',
      type: 'stat',
      description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
    },
    layout.grid(3, 3, 12, 3),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * (\n  (\n    (sum by(hostname) (increase(amd_gpu_violation_socket_thermal_residency_accumulated{hostname=~"$hostname"}[$__range]))) > bool 0\n  ) == 1\n  or\n  (\n    (sum by(hostname) (increase(DCGM_FI_DEV_THERMAL_VIOLATION{hostname=~"$hostname"}[$__range]))) > bool 0\n  ) == 1\n)\nor\n(\n  (\n  0 * (\n    label_replace(\n      max by(node) (\n        kube_node_status_capacity{resource=~"(amd|nvidia)_com_gpu", node=~"$hostname"} > 0\n      ),\n      "hostname", "$1", "node", "(.*)"\n    )\n  )\n  + 2\n)\n  unless on(hostname)\n  (\n    max by(hostname) (\n  present_over_time(amd_gpu_violation_socket_thermal_residency_accumulated{hostname=~"$hostname"}[10m])\n)\n    or\n    max by(hostname) (\n  present_over_time(DCGM_FI_DEV_THERMAL_VIOLATION{hostname=~"$hostname"}[10m])\n)\n  )\n)\nor\n1 * (\n  (\n    (sum by(hostname) (increase(amd_gpu_violation_socket_thermal_residency_accumulated{hostname=~"$hostname"}[$__range]))) == bool 0\n  ) == 1\n  or\n  (\n    (sum by(hostname) (increase(DCGM_FI_DEV_THERMAL_VIOLATION{hostname=~"$hostname"}[$__range]))) == bool 0\n  ) == 1\n)',
        legendFormat: '{{hostname}}',
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
          mappings: [
            {
              options: {
                '0': {
                  color: 'red',
                  text: 'Failed',
                },
                '1': {
                  color: 'green',
                  text: 'OK',
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
      id: 12,
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
      title: 'HBM Thermal / Sync Boost',
      type: 'stat',
      description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
    },
    layout.grid(3, 3, 15, 3),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * (\n  (\n    (sum by(hostname) (increase(amd_gpu_violation_hbm_thermal_residency_accumulated{hostname=~"$hostname"}[$__range]))) > bool 0\n  ) == 1\n  or\n  (\n    (sum by(hostname) (increase(DCGM_FI_DEV_SYNC_BOOST_VIOLATION{hostname=~"$hostname"}[$__range]))) > bool 0\n  ) == 1\n)\nor\n(\n  (\n  0 * (\n    label_replace(\n      max by(node) (\n        kube_node_status_capacity{resource=~"(amd|nvidia)_com_gpu", node=~"$hostname"} > 0\n      ),\n      "hostname", "$1", "node", "(.*)"\n    )\n  )\n  + 2\n)\n  unless on(hostname)\n  (\n    max by(hostname) (\n  present_over_time(amd_gpu_violation_hbm_thermal_residency_accumulated{hostname=~"$hostname"}[10m])\n)\n    or\n    max by(hostname) (\n  present_over_time(DCGM_FI_DEV_SYNC_BOOST_VIOLATION{hostname=~"$hostname"}[10m])\n)\n  )\n)\nor\n1 * (\n  (\n    (sum by(hostname) (increase(amd_gpu_violation_hbm_thermal_residency_accumulated{hostname=~"$hostname"}[$__range]))) == bool 0\n  ) == 1\n  or\n  (\n    (sum by(hostname) (increase(DCGM_FI_DEV_SYNC_BOOST_VIOLATION{hostname=~"$hostname"}[$__range]))) == bool 0\n  ) == 1\n)',
        legendFormat: '{{hostname}}',
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
          mappings: [
            {
              options: {
                '0': {
                  color: 'red',
                  text: 'Failed',
                },
                '1': {
                  color: 'green',
                  text: 'OK',
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
      id: 13,
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
      title: 'VR Thermal / Reliability',
      type: 'stat',
      description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
    },
    layout.grid(3, 3, 18, 3),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * (\n  (\n    (sum by(hostname) (increase(amd_gpu_violation_vr_thermal_residency_accumulated{hostname=~"$hostname"}[$__range]))) > bool 0\n  ) == 1\n  or\n  (\n    (sum by(hostname) (increase(DCGM_FI_DEV_RELIABILITY_VIOLATION{hostname=~"$hostname"}[$__range]))) > bool 0\n  ) == 1\n)\nor\n(\n  (\n  0 * (\n    label_replace(\n      max by(node) (\n        kube_node_status_capacity{resource=~"(amd|nvidia)_com_gpu", node=~"$hostname"} > 0\n      ),\n      "hostname", "$1", "node", "(.*)"\n    )\n  )\n  + 2\n)\n  unless on(hostname)\n  (\n    max by(hostname) (\n  present_over_time(amd_gpu_violation_vr_thermal_residency_accumulated{hostname=~"$hostname"}[10m])\n)\n    or\n    max by(hostname) (\n  present_over_time(DCGM_FI_DEV_RELIABILITY_VIOLATION{hostname=~"$hostname"}[10m])\n)\n  )\n)\nor\n1 * (\n  (\n    (sum by(hostname) (increase(amd_gpu_violation_vr_thermal_residency_accumulated{hostname=~"$hostname"}[$__range]))) == bool 0\n  ) == 1\n  or\n  (\n    (sum by(hostname) (increase(DCGM_FI_DEV_RELIABILITY_VIOLATION{hostname=~"$hostname"}[$__range]))) == bool 0\n  ) == 1\n)',
        legendFormat: '{{hostname}}',
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
          mappings: [
            {
              options: {
                '0': {
                  color: 'red',
                  text: 'Failed',
                },
                '1': {
                  color: 'green',
                  text: 'OK',
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
      id: 14,
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
      title: 'PCIE Correctable',
      type: 'stat',
      description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
    },
    layout.grid(3, 3, 21, 3),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * (\n  ((max by(hostname) (\n    max_over_time(problem_gauge{reason="PcieCorrectable", type="NodeHasPcieErrors", hostname=~"$hostname"}[$__range])\n  )) > bool 0) == 1\n    )\n    or\n    (\n      (\n        0 * (\n          label_replace(\n            max by(node) (\n              kube_node_status_capacity{resource=~"(amd|nvidia)_com_gpu", node=~"$hostname"} > 0\n            ),\n            "hostname", "$1", "node", "(.*)"\n          )\n        )\n        + 2\n      )\n      unless on(hostname)\n      max by(hostname) (\n        present_over_time(problem_gauge{reason="PcieCorrectable", type="NodeHasPcieErrors", hostname=~"$hostname"}[10m])\n      )\n    )\n    or\n    1 * (\n  ((max by(hostname) (\n    max_over_time(problem_gauge{reason="PcieCorrectable", type="NodeHasPcieErrors", hostname=~"$hostname"}[$__range])\n  )) == bool 0) == 1\n      and on(hostname)\n      max by(hostname) (\n        present_over_time(problem_gauge{reason="PcieCorrectable", type="NodeHasPcieErrors", hostname=~"$hostname"}[10m])\n      )\n    )',
        legendFormat: '{{hostname}}',
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
          mappings: [
            {
              options: {
                '0': {
                  color: 'red',
                  text: 'Failed',
                },
                '1': {
                  color: 'green',
                  text: 'OK',
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
      id: 15,
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
      title: 'PCIE Non Fatal',
      type: 'stat',
      description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
    },
    layout.grid(3, 3, 0, 6),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * (\n  ((max by(hostname) (\n    max_over_time(problem_gauge{reason="PcieNonFatal", type="NodeHasPcieErrors", hostname=~"$hostname"}[$__range])\n  )) > bool 0) == 1\n    )\n    or\n    (\n      (\n        0 * (\n          label_replace(\n            max by(node) (\n              kube_node_status_capacity{resource=~"(amd|nvidia)_com_gpu", node=~"$hostname"} > 0\n            ),\n            "hostname", "$1", "node", "(.*)"\n          )\n        )\n        + 2\n      )\n      unless on(hostname)\n      max by(hostname) (\n        present_over_time(problem_gauge{reason="PcieNonFatal", type="NodeHasPcieErrors", hostname=~"$hostname"}[10m])\n      )\n    )\n    or\n    1 * (\n  ((max by(hostname) (\n    max_over_time(problem_gauge{reason="PcieNonFatal", type="NodeHasPcieErrors", hostname=~"$hostname"}[$__range])\n  )) == bool 0) == 1\n      and on(hostname)\n      max by(hostname) (\n        present_over_time(problem_gauge{reason="PcieNonFatal", type="NodeHasPcieErrors", hostname=~"$hostname"}[10m])\n      )\n    )',
        legendFormat: '{{hostname}}',
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
          mappings: [
            {
              options: {
                '0': {
                  color: 'red',
                  text: 'Failed',
                },
                '1': {
                  color: 'green',
                  text: 'OK',
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
      id: 16,
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
      title: 'PCIE Fatal',
      type: 'stat',
      description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
    },
    layout.grid(3, 3, 3, 6),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * (\n  ((max by(hostname) (\n    max_over_time(problem_gauge{reason="PcieFatal", type="NodeHasPcieErrors", hostname=~"$hostname"}[$__range])\n  )) > bool 0) == 1\n    )\n    or\n    (\n      (\n        0 * (\n          label_replace(\n            max by(node) (\n              kube_node_status_capacity{resource=~"(amd|nvidia)_com_gpu", node=~"$hostname"} > 0\n            ),\n            "hostname", "$1", "node", "(.*)"\n          )\n        )\n        + 2\n      )\n      unless on(hostname)\n      max by(hostname) (\n        present_over_time(problem_gauge{reason="PcieFatal", type="NodeHasPcieErrors", hostname=~"$hostname"}[10m])\n      )\n    )\n    or\n    1 * (\n  ((max by(hostname) (\n    max_over_time(problem_gauge{reason="PcieFatal", type="NodeHasPcieErrors", hostname=~"$hostname"}[$__range])\n  )) == bool 0) == 1\n      and on(hostname)\n      max by(hostname) (\n        present_over_time(problem_gauge{reason="PcieFatal", type="NodeHasPcieErrors", hostname=~"$hostname"}[10m])\n      )\n    )',
        legendFormat: '{{hostname}}',
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
          mappings: [
            {
              options: {
                '0': {
                  color: 'red',
                  text: 'Failed',
                },
                '1': {
                  color: 'green',
                  text: 'OK',
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
      id: 18,
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
      title: 'PCIE Link Width',
      type: 'stat',
      description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
    },
    layout.grid(3, 3, 6, 6),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * (\n  label_replace(\n        max by(node) (\n          max_over_time(\n            kube_node_status_condition{\n              condition="GpuPcie",\n              status="true",\n              node=~"$hostname"\n            }[$__range]\n          )\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )\n    or\n    2 * (\n  label_replace(\n        max by(node) (\n          kube_node_status_condition{\n            condition="GpuPcie",\n            status="unknown",\n            node=~"$hostname"\n          }\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )\n    or\n    1 * (\n  label_replace(\n        max by(node) (\n          kube_node_status_condition{\n            condition="GpuPcie",\n            status="false",\n            node=~"$hostname"\n          }\n        ) == 1,\n        "hostname", "$1", "node", "(.*)"\n      )\n    )',
        legendFormat: '{{hostname}}',
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
          mappings: [
            {
              options: {
                '0': {
                  color: 'red',
                  text: 'Failed',
                },
                '1': {
                  color: 'green',
                  text: 'OK',
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
      id: 19,
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
      title: 'Disk free',
      type: 'stat',
      description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
    },
    layout.grid(3, 3, 9, 6),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * (\n  ((min by(hostname) (\n    min_over_time(node_filesystem_avail_bytes{mountpoint="/", device=~"/dev/sd.*", hostname=~"$hostname"}[$__range])\n  )) < bool 50 * 1024 * 1024 * 1024) == 1\n    )\n    or\n    (\n      (\n        0 * (\n          label_replace(\n            max by(node) (\n              kube_node_status_capacity{resource=~"(amd|nvidia)_com_gpu", node=~"$hostname"} > 0\n            ),\n            "hostname", "$1", "node", "(.*)"\n          )\n        )\n        + 2\n      )\n      unless on(hostname)\n      max by(hostname) (\n        present_over_time(node_filesystem_avail_bytes{mountpoint="/", device=~"/dev/sd.*", hostname=~"$hostname"}[10m])\n      )\n    )\n    or\n    1 * (\n  ((min by(hostname) (\n    min_over_time(node_filesystem_avail_bytes{mountpoint="/", device=~"/dev/sd.*", hostname=~"$hostname"}[$__range])\n  )) >= bool 50 * 1024 * 1024 * 1024) == 1\n      and on(hostname)\n      max by(hostname) (\n        present_over_time(node_filesystem_avail_bytes{mountpoint="/", device=~"/dev/sd.*", hostname=~"$hostname"}[10m])\n      )\n    )',
        legendFormat: '{{hostname}}',
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
          mappings: [
            {
              options: {
                '0': {
                  color: 'red',
                  text: 'Failed',
                },
                '1': {
                  color: 'green',
                  text: 'OK',
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
      id: 20,
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
      title: 'Mem free',
      type: 'stat',
      description: 'Failed if the condition occurred during the selected range. Otherwise shows the current state. Missing recent metrics are Unknown.',
    },
    layout.grid(3, 3, 12, 6),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * (\n  ((min by(hostname) (\n    min_over_time(node_memory_MemAvailable_bytes{instance_shape=~"(BM|VM).GPU.*", hostname=~"$hostname"}[$__range])\n  )) < bool 50 * 1024 * 1024 * 1024) == 1\n    )\n    or\n    (\n      (\n        0 * (\n          label_replace(\n            max by(node) (\n              kube_node_status_capacity{resource=~"(amd|nvidia)_com_gpu", node=~"$hostname"} > 0\n            ),\n            "hostname", "$1", "node", "(.*)"\n          )\n        )\n        + 2\n      )\n      unless on(hostname)\n      max by(hostname) (\n        present_over_time(node_memory_MemAvailable_bytes{instance_shape=~"(BM|VM).GPU.*", hostname=~"$hostname"}[10m])\n      )\n    )\n    or\n    1 * (\n  ((min by(hostname) (\n    min_over_time(node_memory_MemAvailable_bytes{instance_shape=~"(BM|VM).GPU.*", hostname=~"$hostname"}[$__range])\n  )) >= bool 50 * 1024 * 1024 * 1024) == 1\n      and on(hostname)\n      max by(hostname) (\n        present_over_time(node_memory_MemAvailable_bytes{instance_shape=~"(BM|VM).GPU.*", hostname=~"$hostname"}[10m])\n      )\n    )',
        legendFormat: '{{hostname}}',
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
                  text: 'OK',
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
      id: 21,
      options: {
        alignValue: 'left',
        legend: {
          displayMode: 'list',
          placement: 'bottom',
          showLegend: true,
        },
        mergeValues: true,
        perPage: 25,
        rowHeight: 0.9,
        showValue: 'never',
        tooltip: {
          hideZeros: false,
          mode: 'single',
          sort: 'none',
        },
      },
      pluginVersion: '12.1.1',
      title: 'PCIE Health history',
      type: 'state-timeline',
    },
    layout.grid(24, 12, 0, 9),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * label_replace(\n  max by(node) (\n    kube_node_status_condition{condition=~"GpuPcie|NodeHasPcieErrors", status="true", node=~"$hostname"} == 1\n  ),\n  "hostname", "$1", "node", "(.*)"\n)\nor\n2 * label_replace(\n  max by(node) (\n    kube_node_status_condition{condition=~"GpuPcie|NodeHasPcieErrors", status="unknown", node=~"$hostname"} == 1\n  ),\n  "hostname", "$1", "node", "(.*)"\n)\nor\n1 * label_replace(\n  min by(node) (\n    kube_node_status_condition{condition=~"GpuPcie|NodeHasPcieErrors", status="false", node=~"$hostname"}\n  ) == 1,\n  "hostname", "$1", "node", "(.*)"\n)',
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
                  text: 'OK',
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
      id: 22,
      options: {
        alignValue: 'left',
        legend: {
          displayMode: 'list',
          placement: 'bottom',
          showLegend: true,
        },
        mergeValues: true,
        perPage: 25,
        rowHeight: 0.9,
        showValue: 'never',
        tooltip: {
          hideZeros: false,
          mode: 'single',
          sort: 'none',
        },
      },
      pluginVersion: '12.1.1',
      title: 'RDMA Link Flapping history',
      type: 'state-timeline',
    },
    layout.grid(24, 10, 0, 21),
    [
      queries.fromObject({
        datasource: {
          type: 'prometheus',
          uid: '$PROMETHEUS_DS',
        },
        editorMode: 'code',
        expr: '0 * label_replace(\n  max by(node) (\n    kube_node_status_condition{condition="RdmaLinkFlapping", status="true", node=~"$hostname"} == 1\n  ),\n  "hostname", "$1", "node", "(.*)"\n)\nor\n2 * label_replace(\n  max by(node) (\n    kube_node_status_condition{condition="RdmaLinkFlapping", status="unknown", node=~"$hostname"} == 1\n  ),\n  "hostname", "$1", "node", "(.*)"\n)\nor\n1 * label_replace(\n  max by(node) (\n    kube_node_status_condition{condition="RdmaLinkFlapping", status="false", node=~"$hostname"} == 1\n  ),\n  "hostname", "$1", "node", "(.*)"\n)',
        legendFormat: '{{hostname}}',
        range: true,
        refId: 'A',
      }),
    ],
  ),
];
local firstVendorPanel = amdGpuBadPages;
local includeFirstVendorPanel = includeAmd;
local secondVendorPanel = nvidiaRowRemap;
local includeSecondVendorPanel = includeNvidia;
local selectedPanels =
  beforeVendorPanels
  + (if includeFirstVendorPanel then [firstVendorPanel] else [])
  + betweenVendorPanels
  + (if includeSecondVendorPanel then [secondVendorPanel] else [])
  + afterVendorPanels;

assert std.member(['nvidia', 'amd', 'mixed'], gpuVendor) : 'gpu_vendor must be nvidia, amd, or mixed';
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
    description: 'GPU Node Component Health Status\n',
    editable: true,
    fiscalYearStartMonth: 0,
    graphTooltip: 1,
    id: 26,
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
    title: 'GPU Health Status',
    uid: 'gpu-health',
    version: 7,
  },
  layout.reflowHealthStats(selectedPanels),
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
      allowCustomValue: false,
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
      definition: 'label_values(kube_node_status_capacity{resource=~"(amd|nvidia)_com_gpu"},node)',
      includeAll: true,
      label: 'Node',
      multi: true,
      name: 'hostname',
      options: [],
      query: {
        qryType: 1,
        query: 'label_values(kube_node_status_capacity{resource=~"(amd|nvidia)_com_gpu"},node)',
        refId: 'PrometheusVariableQueryEditor-VariableQuery',
      },
      refresh: 1,
      type: 'query',
    }),
  ],
)
