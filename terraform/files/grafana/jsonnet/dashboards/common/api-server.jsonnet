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
    id: 50,
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
    title: 'Kubernetes / API server',
    uid: '09ec8aa1e996d6ffcd6817bbaff4db1b',
    version: 1,
    weekStart: '',
  },
  [
    panels.fromObject(
      {
        description: 'The SLO (service level objective) and other metrics displayed on this dashboard are for informational purposes only.',
        fieldConfig: {
          defaults: {},
          overrides: [],
        },
        id: 1,
        options: {
          code: {
            language: 'plaintext',
            showLineNumbers: false,
            showMiniMap: false,
          },
          content: 'The SLO (service level objective) and other metrics displayed on this dashboard are for informational purposes only.',
          mode: 'markdown',
        },
        pluginVersion: '11.5.2',
        transparent: true,
        title: '',
        type: 'text',
      },
      layout.grid(24, 3, 0, 0),
      null,
    ),
    panels.fromObject(
      {
        datasource: {
          type: 'datasource',
          uid: '-- Mixed --',
        },
        description: 'How many percent of requests (both read and write) in 30 days have been answered successfully and fast enough?',
        fieldConfig: {
          defaults: {
            decimals: 3,
            mappings: [],
            thresholds: thresholds.standardNull,
            unit: 'percentunit',
          },
          overrides: [],
        },
        id: 2,
        interval: '1m',
        options: {
          colorMode: 'value',
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
        title: 'Availability (30d) > 99.000%',
        type: 'stat',
      },
      layout.grid(8, 7, 0, 3),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'apiserver_request:availability30d{verb="all", cluster="$cluster"}',
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
        description: 'How much error budget is left looking at our 0.990% availability guarantees?',
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
              fillOpacity: 100,
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
            decimals: 3,
            mappings: [],
            thresholds: thresholds.standardNull,
            unit: 'percentunit',
          },
          overrides: [],
        },
        id: 3,
        interval: '1m',
        options: {
          legend: {
            asTable: true,
            calcs: [],
            displayMode: 'list',
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
        title: 'ErrorBudget (30d) > 99.000%',
        type: 'timeseries',
      },
      layout.grid(16, 7, 8, 3),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: '100 * (apiserver_request:availability30d{verb="all", cluster="$cluster"} - 0.990000)',
          legendFormat: 'errorbudget',
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
        description: 'How many percent of read requests (LIST,GET) in 30 days have been answered successfully and fast enough?',
        fieldConfig: {
          defaults: {
            decimals: 3,
            mappings: [],
            thresholds: thresholds.standardNull,
            unit: 'percentunit',
          },
          overrides: [],
        },
        id: 4,
        interval: '1m',
        options: {
          colorMode: 'value',
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
        title: 'Read Availability (30d)',
        type: 'stat',
      },
      layout.grid(6, 7, 0, 10),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'apiserver_request:availability30d{verb="read", cluster="$cluster"}',
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
        description: 'How many read requests (LIST,GET) per second do the apiservers get by code?',
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
              fillOpacity: 100,
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
                mode: 'normal',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            thresholds: thresholds.standardNull,
            unit: 'reqps',
          },
          overrides: [
            {
              matcher: {
                id: 'byRegexp',
                options: '/2../i',
              },
              properties: [
                {
                  id: 'color',
                  value: '#56A64B',
                },
              ],
            },
            {
              matcher: {
                id: 'byRegexp',
                options: '/3../i',
              },
              properties: [
                {
                  id: 'color',
                  value: '#F2CC0C',
                },
              ],
            },
            {
              matcher: {
                id: 'byRegexp',
                options: '/4../i',
              },
              properties: [
                {
                  id: 'color',
                  value: '#3274D9',
                },
              ],
            },
            {
              matcher: {
                id: 'byRegexp',
                options: '/5../i',
              },
              properties: [
                {
                  id: 'color',
                  value: '#E02F44',
                },
              ],
            },
          ],
        },
        id: 5,
        interval: '1m',
        options: {
          legend: {
            asTable: true,
            calcs: [],
            displayMode: 'list',
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
        title: 'Read SLI - Requests',
        type: 'timeseries',
      },
      layout.grid(6, 7, 6, 10),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum by (code) (code_resource:apiserver_request_total:rate5m{verb="read", cluster="$cluster"})',
          legendFormat: '{{ code }}',
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
        description: 'How many percent of read requests (LIST,GET) per second are returned with errors (5xx)?',
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
            min: 0,
            thresholds: thresholds.standardNull,
            unit: 'percentunit',
          },
          overrides: [],
        },
        id: 6,
        interval: '1m',
        options: {
          legend: {
            asTable: true,
            calcs: [],
            displayMode: 'list',
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
        title: 'Read SLI - Errors',
        type: 'timeseries',
      },
      layout.grid(6, 7, 12, 10),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum by (resource) (code_resource:apiserver_request_total:rate5m{verb="read",code=~"5..", cluster="$cluster"}) / sum by (resource) (code_resource:apiserver_request_total:rate5m{verb="read", cluster="$cluster"})',
          legendFormat: '{{ resource }}',
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
        description: 'How many seconds is the 99th percentile for reading (LIST|GET) a given resource?',
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
            thresholds: thresholds.standardNull,
            unit: 's',
          },
          overrides: [],
        },
        id: 7,
        interval: '1m',
        options: {
          legend: {
            asTable: true,
            calcs: [],
            displayMode: 'list',
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
        title: 'Read SLI - Duration',
        type: 'timeseries',
      },
      layout.grid(6, 7, 18, 10),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'cluster_quantile:apiserver_request_sli_duration_seconds:histogram_quantile{verb="read", cluster="$cluster"}',
          legendFormat: '{{ resource }}',
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
        description: 'How many percent of write requests (POST|PUT|PATCH|DELETE) in 30 days have been answered successfully and fast enough?',
        fieldConfig: {
          defaults: {
            decimals: 3,
            mappings: [],
            thresholds: thresholds.standardNull,
            unit: 'percentunit',
          },
          overrides: [],
        },
        id: 8,
        interval: '1m',
        options: {
          colorMode: 'value',
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
        title: 'Write Availability (30d)',
        type: 'stat',
      },
      layout.grid(6, 7, 0, 17),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'apiserver_request:availability30d{verb="write", cluster="$cluster"}',
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
        description: 'How many write requests (POST|PUT|PATCH|DELETE) per second do the apiservers get by code?',
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
              fillOpacity: 100,
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
                mode: 'normal',
              },
              thresholdsStyle: {
                mode: 'off',
              },
            },
            mappings: [],
            thresholds: thresholds.standardNull,
            unit: 'reqps',
          },
          overrides: [
            {
              matcher: {
                id: 'byRegexp',
                options: '/2../i',
              },
              properties: [
                {
                  id: 'color',
                  value: '#56A64B',
                },
              ],
            },
            {
              matcher: {
                id: 'byRegexp',
                options: '/3../i',
              },
              properties: [
                {
                  id: 'color',
                  value: '#F2CC0C',
                },
              ],
            },
            {
              matcher: {
                id: 'byRegexp',
                options: '/4../i',
              },
              properties: [
                {
                  id: 'color',
                  value: '#3274D9',
                },
              ],
            },
            {
              matcher: {
                id: 'byRegexp',
                options: '/5../i',
              },
              properties: [
                {
                  id: 'color',
                  value: '#E02F44',
                },
              ],
            },
          ],
        },
        id: 9,
        interval: '1m',
        options: {
          legend: {
            asTable: true,
            calcs: [],
            displayMode: 'list',
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
        title: 'Write SLI - Requests',
        type: 'timeseries',
      },
      layout.grid(6, 7, 6, 17),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum by (code) (code_resource:apiserver_request_total:rate5m{verb="write", cluster="$cluster"})',
          legendFormat: '{{ code }}',
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
        description: 'How many percent of write requests (POST|PUT|PATCH|DELETE) per second are returned with errors (5xx)?',
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
            min: 0,
            thresholds: thresholds.standardNull,
            unit: 'percentunit',
          },
          overrides: [],
        },
        id: 10,
        interval: '1m',
        options: {
          legend: {
            asTable: true,
            calcs: [],
            displayMode: 'list',
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
        title: 'Write SLI - Errors',
        type: 'timeseries',
      },
      layout.grid(6, 7, 12, 17),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum by (resource) (code_resource:apiserver_request_total:rate5m{verb="write",code=~"5..", cluster="$cluster"}) / sum by (resource) (code_resource:apiserver_request_total:rate5m{verb="write", cluster="$cluster"})',
          legendFormat: '{{ resource }}',
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
        description: 'How many seconds is the 99th percentile for writing (POST|PUT|PATCH|DELETE) a given resource?',
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
            calcs: [],
            displayMode: 'list',
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
        title: 'Write SLI - Duration',
        type: 'timeseries',
      },
      layout.grid(6, 7, 18, 17),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'cluster_quantile:apiserver_request_sli_duration_seconds:histogram_quantile{verb="write", cluster="$cluster"}',
          legendFormat: '{{ resource }}',
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
            min: 0,
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
            calcs: [],
            displayMode: 'list',
            placement: 'right',
            showLegend: false,
          },
          tooltip: {
            hideZeros: false,
            mode: 'single',
            sort: 'none',
          },
        },
        pluginVersion: '11.5.2',
        title: 'Work Queue Add Rate',
        type: 'timeseries',
      },
      layout.grid(12, 7, 0, 24),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(workqueue_adds_total{job="apiserver", instance=~"$instance", cluster="$cluster"}[$__rate_interval])) by (instance, name)',
          legendFormat: '{{instance}} {{name}}',
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
            min: 0,
            thresholds: thresholds.standardNull,
            unit: 'short',
          },
          overrides: [],
        },
        id: 13,
        interval: '1m',
        options: {
          legend: {
            asTable: true,
            calcs: [],
            displayMode: 'list',
            placement: 'right',
            showLegend: false,
          },
          tooltip: {
            hideZeros: false,
            mode: 'single',
            sort: 'none',
          },
        },
        pluginVersion: '11.5.2',
        title: 'Work Queue Depth',
        type: 'timeseries',
      },
      layout.grid(12, 7, 12, 24),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(workqueue_depth{job="apiserver", instance=~"$instance", cluster="$cluster"}[$__rate_interval])) by (instance, name)',
          legendFormat: '{{instance}} {{name}}',
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
            min: 0,
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
            displayMode: 'list',
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
        title: 'Work Queue Latency',
        type: 'timeseries',
      },
      layout.grid(24, 7, 0, 31),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'histogram_quantile(0.99, sum(rate(workqueue_queue_duration_seconds_bucket{job="apiserver", instance=~"$instance", cluster="$cluster"}[$__rate_interval])) by (instance, name, le))',
          legendFormat: '{{instance}} {{name}}',
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
            thresholds: thresholds.standardNull,
            unit: 'bytes',
          },
          overrides: [],
        },
        id: 15,
        interval: '1m',
        options: {
          legend: {
            asTable: true,
            calcs: [],
            displayMode: 'list',
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
      layout.grid(8, 7, 0, 38),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'process_resident_memory_bytes{job="apiserver",instance=~"$instance", cluster="$cluster"}',
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
            min: 0,
            thresholds: thresholds.standardNull,
            unit: 'short',
          },
          overrides: [],
        },
        id: 16,
        interval: '1m',
        options: {
          legend: {
            asTable: true,
            calcs: [],
            displayMode: 'list',
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
      layout.grid(8, 7, 8, 38),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'rate(process_cpu_seconds_total{job="apiserver",instance=~"$instance", cluster="$cluster"}[$__rate_interval])',
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
            unit: 'short',
          },
          overrides: [],
        },
        id: 17,
        interval: '1m',
        options: {
          legend: {
            asTable: true,
            calcs: [],
            displayMode: 'list',
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
      layout.grid(8, 7, 16, 38),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'go_goroutines{job="apiserver",instance=~"$instance", cluster="$cluster"}',
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
      query: 'label_values(up{job="apiserver"}, cluster)',
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
      name: 'instance',
      options: [],
      query: 'label_values(up{job="apiserver", cluster="$cluster"}, instance)',
      refresh: 2,
      sort: 1,
      type: 'query',
    }),
  ],
)
