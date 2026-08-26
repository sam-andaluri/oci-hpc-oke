local dashboard = import '../../lib/dashboard.libsonnet';
local layout = import '../../lib/layout.libsonnet';
local panels = import '../../lib/panels.libsonnet';
local queries = import '../../lib/queries.libsonnet';
local thresholds = import '../../lib/thresholds.libsonnet';
local variables = import '../../lib/variables.libsonnet';

dashboard.fromObjects(
  {
    description: 'Lustre File System\n',
    graphTooltip: 1,
    refresh: '30s',
    schemaVersion: 39,
    time: {
      from: 'now-5m',
      to: 'now',
    },
    timezone: 'browser',
    title: 'Lustre File System',
    uid: 'oci-lustre',
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
            unit: 'Bps',
          },
        },
        id: 1,
        options: {
          legend: {
            calcs: [
              'p99',
              'p95',
              'p90',
            ],
            displayMode: 'table',
            placement: 'right',
          },
        },
        pluginVersion: 'v11.4.0',
        title: 'Read Throughput',
        type: 'timeseries',
      },
      layout.grid(12, 8, 0, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'avg(oci_lustrefilesystem:read_throughput_count)',
          legendFormat: '{{display_name}}:{{performance_tier}}',
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
            unit: 'Bps',
          },
        },
        id: 2,
        options: {
          legend: {
            calcs: [
              'p99',
              'p95',
              'p90',
            ],
            displayMode: 'table',
            placement: 'right',
          },
        },
        pluginVersion: 'v11.4.0',
        title: 'Write Throughput',
        type: 'timeseries',
      },
      layout.grid(12, 8, 12, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'avg(oci_lustrefilesystem:write_throughput_count)',
          legendFormat: '{{display_name}}:{{performance_tier}}',
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
            unit: 'ops',
          },
        },
        id: 3,
        options: {
          legend: {
            calcs: [
              'p99',
              'p95',
              'p90',
            ],
            displayMode: 'table',
            placement: 'right',
          },
        },
        pluginVersion: 'v11.4.0',
        title: 'Data Read Operations',
        type: 'timeseries',
      },
      layout.grid(12, 8, 0, 8),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'oci_lustrefilesystem:data_read_operations_count',
          legendFormat: '{{display_name}}:{{performance_tier}}',
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
            unit: 'ops',
          },
        },
        id: 4,
        options: {
          legend: {
            calcs: [
              'p99',
              'p95',
              'p90',
            ],
            displayMode: 'table',
            placement: 'right',
          },
        },
        pluginVersion: 'v11.4.0',
        title: 'Data Write Operations',
        type: 'timeseries',
      },
      layout.grid(12, 8, 12, 8),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'oci_lustrefilesystem:data_write_operations_count',
          legendFormat: '{{display_name}}:{{performance_tier}}',
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
            unit: 'percent',
          },
        },
        id: 5,
        options: {
          legend: {
            calcs: [
              'p99',
              'p95',
              'p90',
            ],
            displayMode: 'table',
            placement: 'right',
          },
        },
        pluginVersion: 'v11.4.0',
        title: 'Capacity Util - Space',
        type: 'timeseries',
      },
      layout.grid(12, 8, 0, 16),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'avg(oci_lustrefilesystem:file_system_capacity_count)',
          legendFormat: '{{display_name}}:{{ad}}',
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
            unit: 'percent',
          },
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
          },
        },
        pluginVersion: 'v11.4.0',
        title: 'Capacity Util - Inode',
        type: 'timeseries',
      },
      layout.grid(12, 8, 12, 16),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'avg(oci_lustrefilesystem:file_system_inode_capacity_count)',
          legendFormat: '{{display_name}}:{{ad}}',
        }),
      ],
    ),
  ],
  {},
  [
    variables.fromObject({
      hide: 1,
      name: 'PROMETHEUS_DS',
      query: 'prometheus',
      type: 'datasource',
    }),
    variables.fromObject({
      datasource: {
        type: 'prometheus',
        uid: '${PROMETHEUS_DS}',
      },
      includeAll: true,
      multi: true,
      name: 'hostname',
      query: 'label_values(up, hostname)',
      refresh: 1,
      type: 'query',
    }),
    variables.fromObject({
      datasource: {
        type: 'prometheus',
        uid: '${PROMETHEUS_DS}',
      },
      includeAll: true,
      multi: true,
      name: 'oci_name',
      query: 'label_values(up, oci_name)',
      refresh: 1,
      type: 'query',
    }),
  ],
)
