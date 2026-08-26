local dashboard = import '../../lib/dashboard.libsonnet';
local layout = import '../../lib/layout.libsonnet';
local panels = import '../../lib/panels.libsonnet';
local queries = import '../../lib/queries.libsonnet';
local thresholds = import '../../lib/thresholds.libsonnet';
local variables = import '../../lib/variables.libsonnet';

dashboard.fromObjects(
  {
    description: 'File Storage Service\n',
    graphTooltip: 1,
    refresh: '30s',
    schemaVersion: 39,
    time: {
      from: 'now-5m',
      to: 'now',
    },
    timezone: 'browser',
    title: 'File Storage Service',
    uid: 'oci-fss',
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
        title: 'FileSystem Read Throughput',
        type: 'timeseries',
      },
      layout.grid(12, 8, 0, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'avg(oci_filestorage:file_system_read_throughput_count)',
          legendFormat: '{{display_name}}',
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
        title: 'FileSystem Write Throughput',
        type: 'timeseries',
      },
      layout.grid(12, 8, 12, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'avg(oci_filestorage:file_system_write_throughput_count)',
          legendFormat: '{{display_name}}',
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
        title: 'MountTarget Read Throughput',
        type: 'timeseries',
      },
      layout.grid(12, 8, 0, 8),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'avg(oci_filestorage:mount_target_read_throughput_count)',
          legendFormat: '{{display_name}}:{{current_throughput}}Gbps',
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
        title: 'MountTarget Write Throughput',
        type: 'timeseries',
      },
      layout.grid(12, 8, 12, 8),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'avg(oci_filestorage:mount_target_write_throughput_count)',
          legendFormat: '{{display_name}}:{{current_throughput}}Gbps',
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
            unit: 'iops',
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
        title: 'Metadata IOPS',
        type: 'timeseries',
      },
      layout.grid(12, 8, 0, 16),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'avg(oci_filestorage:metadata_iops_count)',
          legendFormat: '{{display_name}}:{{operation}}',
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
            unit: 'none',
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
        title: 'MountTarget Connections',
        type: 'timeseries',
      },
      layout.grid(12, 8, 12, 16),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'oci_filestorage:mount_target_connections_count',
          legendFormat: '{{display_name}}',
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
          },
        },
        pluginVersion: 'v11.4.0',
        title: 'MountTarget Health',
        type: 'timeseries',
      },
      layout.grid(12, 8, 0, 24),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'avg(oci_filestorage:mount_target_health_count)',
          legendFormat: '{{display_name}}',
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
