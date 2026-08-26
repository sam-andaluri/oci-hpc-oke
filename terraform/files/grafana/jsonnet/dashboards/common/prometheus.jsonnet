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
    id: 43,
    links: [],
    liveNow: false,
    refresh: '',
    schemaVersion: 38,
    tags: [
      'monitoring',
    ],
    time: {
      from: 'now-24h',
      to: 'now',
    },
    timepicker: {},
    timezone: '',
    title: 'Prometheus',
    uid: 'e0b5e43c-3332-4ce3-a680-4919458f7b1d',
    version: 2,
    weekStart: '',
  },
  [
    panels.fromObject(
      {
        id: 12,
        title: 'TSDB',
        type: 'row',
      },
      layout.grid(24, 1, 0, 0),
      null,
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
              showPoints: 'never',
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
          overrides: [
            {
              __systemRef: 'hideSeriesFrom',
              matcher: {
                id: 'byNames',
                options: {
                  mode: 'exclude',
                  names: [
                    'Used: monitoring',
                  ],
                  prefix: 'All except:',
                  readOnly: true,
                },
              },
              properties: [
                {
                  id: 'custom.hideFrom',
                  value: {
                    legend: false,
                    tooltip: false,
                    viz: true,
                  },
                },
              ],
            },
          ],
        },
        id: 10,
        links: [],
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
        pluginVersion: '10.2.2',
        title: 'Persistent Volume usage',
        type: 'timeseries',
      },
      layout.grid(12, 6, 0, 1),
      [
        queries.fromObject({
          datasource: {
            uid: '$datasource',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'sum by(namespace) (kubelet_volume_stats_capacity_bytes{job="kubelet", metrics_path="/metrics"}) - sum by(namespace) (kubelet_volume_stats_available_bytes{job="kubelet", metrics_path="/metrics"})',
          format: 'time_series',
          fullMetaSearch: false,
          includeNullMetadata: true,
          intervalFactor: 1,
          legendFormat: 'Used: {{namespace}}',
          range: true,
          refId: 'A',
          useBackend: false,
        }),
        queries.fromObject({
          datasource: {
            uid: '$datasource',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'sum by(namespace) (kubelet_volume_stats_available_bytes{job="kubelet", metrics_path="/metrics"})',
          format: 'time_series',
          fullMetaSearch: false,
          includeNullMetadata: true,
          intervalFactor: 1,
          legendFormat: 'Free: {{namespace}}',
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
        id: 2,
        options: {
          legend: {
            calcs: [
              'last',
            ],
            displayMode: 'list',
            placement: 'bottom',
            showLegend: true,
          },
          tooltip: {
            mode: 'single',
            sort: 'none',
          },
        },
        title: 'TSDB WAL storage',
        type: 'timeseries',
      },
      layout.grid(12, 6, 12, 1),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'max by(instance) (max_over_time(prometheus_tsdb_wal_storage_size_bytes[$__interval]))',
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
        id: 8,
        options: {
          legend: {
            calcs: [
              'lastNotNull',
            ],
            displayMode: 'table',
            placement: 'bottom',
            showLegend: true,
            sortBy: 'Last *',
            sortDesc: true,
          },
          tooltip: {
            mode: 'single',
            sort: 'none',
          },
        },
        title: 'TSDB head chunks storage',
        type: 'timeseries',
      },
      layout.grid(12, 5, 0, 7),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'max(prometheus_tsdb_head_chunks_storage_size_bytes)',
          fullMetaSearch: false,
          hide: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '__auto',
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
        id: 6,
        options: {
          legend: {
            calcs: [],
            displayMode: 'list',
            placement: 'bottom',
            showLegend: true,
          },
          tooltip: {
            mode: 'single',
            sort: 'none',
          },
        },
        title: 'TSDB storage blocks',
        type: 'timeseries',
      },
      layout.grid(12, 5, 12, 7),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'max(prometheus_tsdb_storage_blocks_bytes)',
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
        id: 7,
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
        title: 'Target metadata cache size',
        type: 'timeseries',
      },
      layout.grid(24, 5, 0, 12),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'max by(scrape_job) (prometheus_target_metadata_cache_bytes)',
          fullMetaSearch: false,
          hide: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '__auto',
          range: true,
          refId: 'B',
          useBackend: false,
        }),
      ],
    ),
    panels.fromObject(
      {
        collapsed: false,
        id: 11,
        panels: [],
        title: 'Discovery',
        type: 'row',
      },
      layout.grid(24, 1, 0, 17),
      null,
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
                log: 2,
                type: 'log',
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
        id: 15,
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
        title: 'Discovered targets',
        type: 'timeseries',
      },
      layout.grid(19, 6, 0, 18),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'label_replace(max by(config) (prometheus_sd_discovered_targets), "prefix", "$2", "config", "(serviceMonitor/monitoring)/(.*)")',
          fullMetaSearch: false,
          hide: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '{{prefix}}',
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
              drawStyle: 'points',
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
            unit: 'ms',
          },
          overrides: [
            {
              matcher: {
                id: 'byName',
                options: '0.99',
              },
              properties: [
                {
                  id: 'color',
                  value: {
                    fixedColor: 'red',
                    mode: 'fixed',
                  },
                },
              ],
            },
            {
              matcher: {
                id: 'byName',
                options: '0.9',
              },
              properties: [
                {
                  id: 'color',
                  value: {
                    fixedColor: 'light-red',
                    mode: 'fixed',
                  },
                },
              ],
            },
            {
              matcher: {
                id: 'byName',
                options: '0.5',
              },
              properties: [
                {
                  id: 'color',
                  value: {
                    fixedColor: 'yellow',
                    mode: 'fixed',
                  },
                },
              ],
            },
          ],
        },
        id: 9,
        maxDataPoints: 100,
        options: {
          legend: {
            calcs: [
              'mean',
            ],
            displayMode: 'table',
            placement: 'bottom',
            showLegend: true,
            sortBy: 'Mean',
            sortDesc: true,
          },
          tooltip: {
            mode: 'single',
            sort: 'none',
          },
        },
        title: 'Grafana dashboard GET',
        type: 'timeseries',
      },
      layout.grid(5, 10, 19, 18),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'max by(quantile) (max_over_time(grafana_api_dashboard_get_milliseconds[$__interval])) > 0',
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
            unit: 'none',
          },
          overrides: [],
        },
        id: 4,
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
        title: 'Scrape jobs',
        type: 'timeseries',
      },
      layout.grid(19, 6, 0, 24),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'max by(scrape_job) (prometheus_target_scrape_pool_targets) > 0',
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
              drawStyle: 'bars',
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
            mappings: [],
            min: 0,
            thresholds: thresholds.standardNull,
            unit: 'none',
          },
          overrides: [],
        },
        id: 14,
        maxDataPoints: 100,
        options: {
          legend: {
            calcs: [
              'lastNotNull',
            ],
            displayMode: 'table',
            placement: 'bottom',
            showLegend: true,
            sortBy: 'Last *',
            sortDesc: true,
          },
          tooltip: {
            mode: 'single',
            sort: 'none',
          },
        },
        title: 'Kubernetes work queue depth',
        type: 'timeseries',
      },
      layout.grid(5, 7, 19, 28),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'max by(queue_name) (prometheus_sd_kubernetes_workqueue_depth)',
          fullMetaSearch: false,
          hide: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '__auto',
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
              lineInterpolation: 'linear',
              lineWidth: 3,
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
        id: 17,
        interval: '60s',
        maxDataPoints: 100,
        options: {
          legend: {
            calcs: [],
            displayMode: 'list',
            placement: 'bottom',
            showLegend: false,
          },
          tooltip: {
            mode: 'single',
            sort: 'none',
          },
        },
        title: 'Ready',
        type: 'timeseries',
      },
      layout.grid(3, 5, 0, 30),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'min(min_over_time(prometheus_ready[$__interval]))',
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
            unit: 'none',
          },
          overrides: [],
        },
        id: 5,
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
        title: 'Scrape errors',
        type: 'timeseries',
      },
      layout.grid(16, 5, 3, 30),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'max by(scrape_job) (prometheus_target_scrapes_exceeded_body_size_limit_total)',
          fullMetaSearch: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '__auto',
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
          expr: 'max by(scrape_job) (prometheus_target_scrape_pool_exceeded_label_limits_total)',
          fullMetaSearch: false,
          hide: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '__auto',
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
          expr: 'max by(scrape_job) (prometheus_target_scrapes_exceeded_sample_limit_total)',
          fullMetaSearch: false,
          hide: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '__auto',
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
          expr: 'max by(job) (prometheus_target_scrape_pool_exceeded_target_limit_total)',
          fullMetaSearch: false,
          hide: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '__auto',
          range: true,
          refId: 'D',
          useBackend: false,
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'max by(job) (prometheus_target_scrape_pool_reloads_failed_total)',
          fullMetaSearch: false,
          hide: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '__auto',
          range: true,
          refId: 'E',
          useBackend: false,
        }),
      ],
    ),
    panels.fromObject(
      {
        collapsed: false,
        id: 16,
        panels: [],
        title: 'Queries',
        type: 'row',
      },
      layout.grid(24, 1, 0, 35),
      null,
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
            thresholds: thresholds.legacyNoValue,
            unit: 'none',
          },
          overrides: [],
        },
        id: 3,
        maxDataPoints: 100,
        options: {
          legend: {
            calcs: [
              'sum',
            ],
            displayMode: 'list',
            placement: 'bottom',
            showLegend: true,
          },
          tooltip: {
            mode: 'single',
            sort: 'none',
          },
        },
        title: 'Queries',
        type: 'timeseries',
      },
      layout.grid(3, 8, 0, 36),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'sum by(instance) (sum_over_time(prometheus_engine_queries[$__interval])) > 0',
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
            thresholds: thresholds.legacyNoValue,
          },
          overrides: [],
        },
        id: 1,
        interval: '1m',
        options: {
          legend: {
            calcs: [
              'mean',
            ],
            displayMode: 'table',
            placement: 'right',
            showLegend: true,
            sortBy: 'Mean',
            sortDesc: true,
          },
          tooltip: {
            mode: 'single',
            sort: 'none',
          },
        },
        title: 'Prometheus HTTP success',
        type: 'timeseries',
      },
      layout.grid(13, 8, 3, 36),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'max by(code, handler) (increase(prometheus_http_requests_total{code=~"2.+"}[$__interval])) > 0',
          fullMetaSearch: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '{{handler}} {{code}}',
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
            thresholds: thresholds.legacyNoValue,
          },
          overrides: [],
        },
        id: 13,
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
        title: 'Prometheus HTTP failure',
        type: 'timeseries',
      },
      layout.grid(8, 8, 16, 36),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: 'prometheus',
          },
          disableTextWrap: false,
          editorMode: 'builder',
          expr: 'sum by(code, handler) (sum_over_time(prometheus_http_requests_total{code!~"2.+"}[$__interval])) > 0',
          fullMetaSearch: false,
          includeNullMetadata: true,
          instant: false,
          legendFormat: '{{handler}} {{code}}',
          range: true,
          refId: 'A',
          useBackend: false,
        }),
      ],
    ),
  ],
  {},
  [

  ],
)
