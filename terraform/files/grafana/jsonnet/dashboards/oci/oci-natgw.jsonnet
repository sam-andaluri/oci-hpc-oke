local dashboard = import '../../lib/dashboard.libsonnet';
local layout = import '../../lib/layout.libsonnet';
local panels = import '../../lib/panels.libsonnet';
local queries = import '../../lib/queries.libsonnet';
local thresholds = import '../../lib/thresholds.libsonnet';
local variables = import '../../lib/variables.libsonnet';

dashboard.fromObjects(
  {
    description: 'NAT Gateway\n',
    graphTooltip: 1,
    refresh: '30s',
    schemaVersion: 39,
    time: {
      from: 'now-5m',
      to: 'now',
    },
    timezone: 'browser',
    title: 'NAT Gateway',
    uid: 'oci-natgw',
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
        title: 'Bytes From NAT Gateway',
        type: 'timeseries',
      },
      layout.grid(12, 8, 0, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'oci_nat_gateway:bytes_from_natgw_count',
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
        title: 'Bytes To NAT Gateway',
        type: 'timeseries',
      },
      layout.grid(12, 8, 12, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'oci_nat_gateway:bytes_to_natgw_count',
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
            unit: 'pps',
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
        title: 'Packets From NAT Gateway',
        type: 'timeseries',
      },
      layout.grid(12, 8, 0, 8),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'oci_nat_gateway:packets_from_natgw_count',
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
            unit: 'pps',
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
        title: 'Packets To NAT Gateway',
        type: 'timeseries',
      },
      layout.grid(12, 8, 12, 8),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'oci_nat_gateway:packets_to_natgw_count',
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
            unit: 'none',
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
        title: 'Drops To NAT Gateway',
        type: 'timeseries',
      },
      layout.grid(12, 8, 12, 16),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'oci_nat_gateway:drops_to_natgw_count',
          legendFormat: '{{drop_type}}',
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
  ],
)
