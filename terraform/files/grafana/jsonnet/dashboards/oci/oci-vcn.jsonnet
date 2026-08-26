local dashboard = import '../../lib/dashboard.libsonnet';
local layout = import '../../lib/layout.libsonnet';
local panels = import '../../lib/panels.libsonnet';
local queries = import '../../lib/queries.libsonnet';
local thresholds = import '../../lib/thresholds.libsonnet';
local variables = import '../../lib/variables.libsonnet';

dashboard.fromObjects(
  {
    description: 'Virtual Cloud Network\n',
    graphTooltip: 1,
    refresh: '30s',
    schemaVersion: 39,
    time: {
      from: 'now-5m',
      to: 'now',
    },
    timezone: 'browser',
    title: 'Virtual Cloud Network',
    uid: 'oci-vcn',
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
        title: 'VNIC Ingress Bytes Top 10',
        type: 'timeseries',
      },
      layout.grid(12, 8, 0, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'topk(10, oci_vcn:vnic_from_network_bytes_count)',
          legendFormat: '{{display_name}}:{{hostname}}',
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
        title: 'VNIC Egress Bytes Top 10',
        type: 'timeseries',
      },
      layout.grid(12, 8, 12, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'topk(10, oci_vcn:vnic_to_network_bytes_count)',
          legendFormat: '{{display_name}}:{{hostname}}',
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
        title: 'VNIC Ingress Drops',
        type: 'timeseries',
      },
      layout.grid(12, 8, 0, 8),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'topk(10, oci_vcn:vnic_ingress_drops_throttle_count)',
          legendFormat: '{{display_name}}:{{hostname}}',
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
        title: 'VNIC Egress Drops',
        type: 'timeseries',
      },
      layout.grid(12, 8, 12, 8),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'topk(10, oci_vcn:vnic_egress_drops_throttle_count)',
          legendFormat: '{{display_name}}:{{hostname}}',
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
        title: 'VNIC ConnTrack Util',
        type: 'timeseries',
      },
      layout.grid(12, 8, 0, 16),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'topk(10, oci_vcn:vnic_conntrack_util_percent_count)',
          legendFormat: '{{display_name}}:{{hostname}}',
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
        title: 'VNIC ConnTrack Is Full',
        type: 'timeseries',
      },
      layout.grid(12, 8, 12, 16),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'topk(10, oci_vcn:vnic_conntrack_is_full_count)',
          legendFormat: '{{display_name}}:{{hostname}}',
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
        title: 'VNIC To Network Packets',
        type: 'timeseries',
      },
      layout.grid(12, 8, 0, 24),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'topk(10, oci_vcn:vnic_to_network_packet_count)',
          legendFormat: '{{display_name}}:{{hostname}}',
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
        id: 8,
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
        title: 'VNIC From Network Packets',
        type: 'timeseries',
      },
      layout.grid(12, 8, 12, 24),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'topk(10, oci_vcn:vnic_from_network_packet_count)',
          legendFormat: '{{display_name}}:{{hostname}}',
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
        id: 9,
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
        title: 'Smart NIC Buffer Drops From Host',
        type: 'timeseries',
      },
      layout.grid(12, 8, 0, 32),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'topk(10, oci_vcn:smart_nic_buffer_drops_from_host_count)',
          legendFormat: '{{display_name}}:{{hostname}}',
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
        id: 10,
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
        title: 'Smart NIC Buffer Drops To Host',
        type: 'timeseries',
      },
      layout.grid(12, 8, 12, 32),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '$PROMETHEUS_DS',
          },
          expr: 'topk(10, oci_vcn:smart_nic_buffer_drops_to_host_count)',
          legendFormat: '{{display_name}}:{{hostname}}',
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
