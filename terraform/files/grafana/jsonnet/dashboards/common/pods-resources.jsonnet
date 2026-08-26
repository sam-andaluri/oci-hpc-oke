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
    title: 'Kubernetes / Compute Resources / Namespace (Pods)',
    uid: '85a562078cdf77779eaa1add43ccec1e',
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
            unit: 'percentunit',
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
        title: 'CPU Utilisation (from requests)',
        type: 'stat',
      },
      layout.grid(6, 3, 0, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster="$cluster", namespace="$namespace"}) / sum(kube_pod_container_resource_requests{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", resource="cpu"})',
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
            unit: 'percentunit',
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
        title: 'CPU Utilisation (from limits)',
        type: 'stat',
      },
      layout.grid(6, 3, 6, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster="$cluster", namespace="$namespace"}) / sum(kube_pod_container_resource_limits{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", resource="cpu"})',
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
            unit: 'percentunit',
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
        title: 'Memory Utilisation (from requests)',
        type: 'stat',
      },
      layout.grid(6, 3, 12, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(container_memory_working_set_bytes{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace",container!="", image!=""}) / sum(kube_pod_container_resource_requests{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", resource="memory"})',
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
            unit: 'percentunit',
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
        title: 'Memory Utilisation (from limits)',
        type: 'stat',
      },
      layout.grid(6, 3, 18, 0),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(container_memory_working_set_bytes{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace",container!="", image!=""}) / sum(kube_pod_container_resource_limits{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", resource="memory"})',
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
          },
          overrides: [
            {
              matcher: {
                id: 'byFrameRefID',
                options: 'B',
              },
              properties: [
                {
                  id: 'custom.lineStyle',
                  value: {
                    fill: 'dash',
                  },
                },
                {
                  id: 'custom.lineWidth',
                  value: 2,
                },
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
                id: 'byFrameRefID',
                options: 'C',
              },
              properties: [
                {
                  id: 'custom.lineStyle',
                  value: {
                    fill: 'dash',
                  },
                },
                {
                  id: 'custom.lineWidth',
                  value: 2,
                },
                {
                  id: 'color',
                  value: {
                    fixedColor: 'orange',
                    mode: 'fixed',
                  },
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
        title: 'CPU Usage',
        type: 'timeseries',
      },
      layout.grid(24, 7, 0, 3),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster="$cluster", namespace="$namespace"}) by (pod)',
          legendFormat: '__auto',
          refId: 'A',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'scalar(max(kube_resourcequota{cluster="$cluster", namespace="$namespace", type="hard",resource="requests.cpu"}))',
          legendFormat: 'quota - requests',
          refId: 'B',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'scalar(max(kube_resourcequota{cluster="$cluster", namespace="$namespace", type="hard",resource="limits.cpu"}))',
          legendFormat: 'quota - limits',
          refId: 'C',
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
            custom: {
              align: 'auto',
              cellOptions: {
                type: 'auto',
              },
              inspect: false,
            },
            mappings: [],
            thresholds: thresholds.standardNull,
          },
          overrides: [
            {
              matcher: {
                id: 'byRegexp',
                options: '/%/',
              },
              properties: [
                {
                  id: 'unit',
                  value: 'percentunit',
                },
              ],
            },
            {
              matcher: {
                id: 'byName',
                options: 'Pod',
              },
              properties: [
                {
                  id: 'links',
                  value: [
                    {
                      title: 'Drill down to pods',
                      url: '/d/6581e46e4e5c7ba40a07646395ef7b23/k8s-resources-pod?${datasource:queryparam}&var-cluster=$cluster&var-namespace=$namespace&var-pod=${__data.fields.Pod}',
                    },
                  ],
                },
              ],
            },
          ],
        },
        id: 6,
        options: {
          cellHeight: 'sm',
          footer: {
            countRows: false,
            fields: '',
            reducer: [
              'sum',
            ],
            show: false,
          },
          showHeader: true,
        },
        pluginVersion: '11.5.2',
        title: 'CPU Quota',
        transformations: [
          {
            id: 'joinByField',
            options: {
              byField: 'pod',
              mode: 'outer',
            },
          },
          {
            id: 'organize',
            options: {
              excludeByName: {
                Time: true,
                'Time 1': true,
                'Time 2': true,
                'Time 3': true,
                'Time 4': true,
                'Time 5': true,
              },
              indexByName: {
                'Time 1': 0,
                'Time 2': 1,
                'Time 3': 2,
                'Time 4': 3,
                'Time 5': 4,
                'Value #A': 6,
                'Value #B': 7,
                'Value #C': 8,
                'Value #D': 9,
                'Value #E': 10,
                pod: 5,
              },
              renameByName: {
                'Value #A': 'CPU Usage',
                'Value #B': 'CPU Requests',
                'Value #C': 'CPU Requests %',
                'Value #D': 'CPU Limits',
                'Value #E': 'CPU Limits %',
                pod: 'Pod',
              },
            },
          },
        ],
        type: 'table',
      },
      layout.grid(24, 7, 0, 10),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster="$cluster", namespace="$namespace"}) by (pod)',
          format: 'table',
          instant: true,
          refId: 'A',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(cluster:namespace:pod_cpu:active:kube_pod_container_resource_requests{cluster="$cluster", namespace="$namespace"}) by (pod)',
          format: 'table',
          instant: true,
          refId: 'B',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster="$cluster", namespace="$namespace"}) by (pod) / sum(cluster:namespace:pod_cpu:active:kube_pod_container_resource_requests{cluster="$cluster", namespace="$namespace"}) by (pod)',
          format: 'table',
          instant: true,
          refId: 'C',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(cluster:namespace:pod_cpu:active:kube_pod_container_resource_limits{cluster="$cluster", namespace="$namespace"}) by (pod)',
          format: 'table',
          instant: true,
          refId: 'D',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster="$cluster", namespace="$namespace"}) by (pod) / sum(cluster:namespace:pod_cpu:active:kube_pod_container_resource_limits{cluster="$cluster", namespace="$namespace"}) by (pod)',
          format: 'table',
          instant: true,
          refId: 'E',
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
          overrides: [
            {
              matcher: {
                id: 'byFrameRefID',
                options: 'B',
              },
              properties: [
                {
                  id: 'custom.lineStyle',
                  value: {
                    fill: 'dash',
                  },
                },
                {
                  id: 'custom.lineWidth',
                  value: 2,
                },
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
                id: 'byFrameRefID',
                options: 'C',
              },
              properties: [
                {
                  id: 'custom.lineStyle',
                  value: {
                    fill: 'dash',
                  },
                },
                {
                  id: 'custom.lineWidth',
                  value: 2,
                },
                {
                  id: 'color',
                  value: {
                    fixedColor: 'orange',
                    mode: 'fixed',
                  },
                },
              ],
            },
          ],
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
        title: 'Memory Usage (w/o cache)',
        type: 'timeseries',
      },
      layout.grid(24, 7, 0, 17),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(container_memory_working_set_bytes{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace", container!="", image!=""}) by (pod)',
          legendFormat: '__auto',
          refId: 'A',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'scalar(max(kube_resourcequota{cluster="$cluster", namespace="$namespace", type="hard",resource="requests.memory"}))',
          legendFormat: 'quota - requests',
          refId: 'B',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'scalar(max(kube_resourcequota{cluster="$cluster", namespace="$namespace", type="hard",resource="limits.memory"}))',
          legendFormat: 'quota - limits',
          refId: 'C',
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
            custom: {
              align: 'auto',
              cellOptions: {
                type: 'auto',
              },
              inspect: false,
            },
            mappings: [],
            thresholds: thresholds.standardNull,
            unit: 'bytes',
          },
          overrides: [
            {
              matcher: {
                id: 'byRegexp',
                options: '/%/',
              },
              properties: [
                {
                  id: 'unit',
                  value: 'percentunit',
                },
              ],
            },
            {
              matcher: {
                id: 'byName',
                options: 'Pod',
              },
              properties: [
                {
                  id: 'links',
                  value: [
                    {
                      title: 'Drill down to pods',
                      url: '/d/6581e46e4e5c7ba40a07646395ef7b23/k8s-resources-pod?${datasource:queryparam}&var-cluster=$cluster&var-namespace=$namespace&var-pod=${__data.fields.Pod}',
                    },
                  ],
                },
              ],
            },
          ],
        },
        id: 8,
        options: {
          cellHeight: 'sm',
          footer: {
            countRows: false,
            fields: '',
            reducer: [
              'sum',
            ],
            show: false,
          },
          showHeader: true,
        },
        pluginVersion: '11.5.2',
        title: 'Memory Quota',
        transformations: [
          {
            id: 'joinByField',
            options: {
              byField: 'pod',
              mode: 'outer',
            },
          },
          {
            id: 'organize',
            options: {
              excludeByName: {
                Time: true,
                'Time 1': true,
                'Time 2': true,
                'Time 3': true,
                'Time 4': true,
                'Time 5': true,
                'Time 6': true,
                'Time 7': true,
                'Time 8': true,
              },
              indexByName: {
                'Time 1': 0,
                'Time 2': 1,
                'Time 3': 2,
                'Time 4': 3,
                'Time 5': 4,
                'Time 6': 5,
                'Time 7': 6,
                'Time 8': 7,
                'Value #A': 9,
                'Value #B': 10,
                'Value #C': 11,
                'Value #D': 12,
                'Value #E': 13,
                'Value #F': 14,
                'Value #G': 15,
                'Value #H': 16,
                pod: 8,
              },
              renameByName: {
                'Value #A': 'Memory Usage',
                'Value #B': 'Memory Requests',
                'Value #C': 'Memory Requests %',
                'Value #D': 'Memory Limits',
                'Value #E': 'Memory Limits %',
                'Value #F': 'Memory Usage (RSS)',
                'Value #G': 'Memory Usage (Cache)',
                'Value #H': 'Memory Usage (Swap)',
                pod: 'Pod',
              },
            },
          },
        ],
        type: 'table',
      },
      layout.grid(24, 7, 0, 24),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(container_memory_working_set_bytes{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace",container!="", image!=""}) by (pod)',
          format: 'table',
          instant: true,
          refId: 'A',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_requests{cluster="$cluster", namespace="$namespace"}) by (pod)',
          format: 'table',
          instant: true,
          refId: 'B',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(container_memory_working_set_bytes{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace",container!="", image!=""}) by (pod) / sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_requests{cluster="$cluster", namespace="$namespace"}) by (pod)',
          format: 'table',
          instant: true,
          refId: 'C',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_limits{cluster="$cluster", namespace="$namespace"}) by (pod)',
          format: 'table',
          instant: true,
          refId: 'D',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(container_memory_working_set_bytes{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace",container!="", image!=""}) by (pod) / sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_limits{cluster="$cluster", namespace="$namespace"}) by (pod)',
          format: 'table',
          instant: true,
          refId: 'E',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(container_memory_rss{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace",container!=""}) by (pod)',
          format: 'table',
          instant: true,
          refId: 'F',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(container_memory_cache{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace",container!=""}) by (pod)',
          format: 'table',
          instant: true,
          refId: 'G',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(container_memory_swap{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace",container!=""}) by (pod)',
          format: 'table',
          instant: true,
          refId: 'H',
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
            custom: {
              align: 'auto',
              cellOptions: {
                type: 'auto',
              },
              inspect: false,
            },
            mappings: [],
            thresholds: thresholds.standardNull,
          },
          overrides: [
            {
              matcher: {
                id: 'byRegexp',
                options: '/Bandwidth/',
              },
              properties: [
                {
                  id: 'unit',
                  value: 'Bps',
                },
              ],
            },
            {
              matcher: {
                id: 'byRegexp',
                options: '/Packets/',
              },
              properties: [
                {
                  id: 'unit',
                  value: 'pps',
                },
              ],
            },
            {
              matcher: {
                id: 'byName',
                options: 'Pod',
              },
              properties: [
                {
                  id: 'links',
                  value: [
                    {
                      title: 'Drill down to pods',
                      url: '/d/6581e46e4e5c7ba40a07646395ef7b23/k8s-resources-pod?${datasource:queryparam}&var-cluster=$cluster&var-namespace=$namespace&var-pod=${__data.fields.Pod}',
                    },
                  ],
                },
              ],
            },
          ],
        },
        id: 9,
        options: {
          cellHeight: 'sm',
          footer: {
            countRows: false,
            fields: '',
            reducer: [
              'sum',
            ],
            show: false,
          },
          showHeader: true,
        },
        pluginVersion: '11.5.2',
        title: 'Current Network Usage',
        transformations: [
          {
            id: 'joinByField',
            options: {
              byField: 'pod',
              mode: 'outer',
            },
          },
          {
            id: 'organize',
            options: {
              excludeByName: {
                Time: true,
                'Time 1': true,
                'Time 2': true,
                'Time 3': true,
                'Time 4': true,
                'Time 5': true,
                'Time 6': true,
              },
              indexByName: {
                'Time 1': 0,
                'Time 2': 1,
                'Time 3': 2,
                'Time 4': 3,
                'Time 5': 4,
                'Time 6': 5,
                'Value #A': 7,
                'Value #B': 8,
                'Value #C': 9,
                'Value #D': 10,
                'Value #E': 11,
                'Value #F': 12,
                pod: 6,
              },
              renameByName: {
                'Value #A': 'Current Receive Bandwidth',
                'Value #B': 'Current Transmit Bandwidth',
                'Value #C': 'Rate of Received Packets',
                'Value #D': 'Rate of Transmitted Packets',
                'Value #E': 'Rate of Received Packets Dropped',
                'Value #F': 'Rate of Transmitted Packets Dropped',
                pod: 'Pod',
              },
            },
          },
        ],
        type: 'table',
      },
      layout.grid(24, 7, 0, 31),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(container_network_receive_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])) by (pod)',
          format: 'table',
          instant: true,
          refId: 'A',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(container_network_transmit_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])) by (pod)',
          format: 'table',
          instant: true,
          refId: 'B',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(container_network_receive_packets_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])) by (pod)',
          format: 'table',
          instant: true,
          refId: 'C',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(container_network_transmit_packets_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])) by (pod)',
          format: 'table',
          instant: true,
          refId: 'D',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(container_network_receive_packets_dropped_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])) by (pod)',
          format: 'table',
          instant: true,
          refId: 'E',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(container_network_transmit_packets_dropped_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])) by (pod)',
          format: 'table',
          instant: true,
          refId: 'F',
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
            unit: 'Bps',
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
        title: 'Receive Bandwidth',
        type: 'timeseries',
      },
      layout.grid(12, 7, 0, 38),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(container_network_receive_bytes_total{cluster="$cluster", namespace="$namespace"}[$__rate_interval])) by (pod)',
          legendFormat: '__auto',
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
            unit: 'Bps',
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
        title: 'Transmit Bandwidth',
        type: 'timeseries',
      },
      layout.grid(12, 7, 12, 38),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(rate(container_network_transmit_bytes_total{cluster="$cluster", namespace="$namespace"}[$__rate_interval])) by (pod)',
          legendFormat: '__auto',
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
            unit: 'pps',
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
        title: 'Rate of Received Packets',
        type: 'timeseries',
      },
      layout.grid(12, 7, 0, 45),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(irate(container_network_receive_packets_total{cluster="$cluster", namespace="$namespace"}[$__rate_interval])) by (pod)',
          legendFormat: '__auto',
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
            unit: 'pps',
          },
          overrides: [],
        },
        id: 13,
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
        title: 'Rate of Transmitted Packets',
        type: 'timeseries',
      },
      layout.grid(12, 7, 12, 45),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(irate(container_network_transmit_packets_total{cluster="$cluster", namespace="$namespace"}[$__rate_interval])) by (pod)',
          legendFormat: '__auto',
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
            unit: 'pps',
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
        title: 'Rate of Received Packets Dropped',
        type: 'timeseries',
      },
      layout.grid(12, 7, 0, 52),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(irate(container_network_receive_packets_dropped_total{cluster="$cluster", namespace="$namespace"}[$__rate_interval])) by (pod)',
          legendFormat: '__auto',
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
            unit: 'pps',
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
        title: 'Rate of Transmitted Packets Dropped',
        type: 'timeseries',
      },
      layout.grid(12, 7, 12, 52),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum(irate(container_network_transmit_packets_dropped_total{cluster="$cluster", namespace="$namespace"}[$__rate_interval])) by (pod)',
          legendFormat: '__auto',
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
            unit: 'iops',
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
        title: 'IOPS(Reads+Writes)',
        type: 'timeseries',
      },
      layout.grid(12, 7, 0, 59),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'ceil(sum by(pod) (rate(container_fs_reads_total{container!="", device=~"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|md.+|dasd.+)", cluster="$cluster", namespace="$namespace"}[$__rate_interval]) + rate(container_fs_writes_total{container!="", device=~"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|md.+|dasd.+)", cluster="$cluster", namespace="$namespace"}[$__rate_interval])))',
          legendFormat: '__auto',
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
            unit: 'Bps',
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
        title: 'ThroughPut(Read+Write)',
        type: 'timeseries',
      },
      layout.grid(12, 7, 12, 59),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum by(pod) (rate(container_fs_reads_bytes_total{container!="", device=~"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|md.+|dasd.+)", cluster="$cluster", namespace="$namespace"}[$__rate_interval]) + rate(container_fs_writes_bytes_total{container!="", device=~"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|md.+|dasd.+)", cluster="$cluster", namespace="$namespace"}[$__rate_interval]))',
          legendFormat: '__auto',
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
            custom: {
              align: 'auto',
              cellOptions: {
                type: 'auto',
              },
              inspect: false,
            },
            mappings: [],
            thresholds: thresholds.standardNull,
          },
          overrides: [
            {
              matcher: {
                id: 'byRegexp',
                options: '/IOPS/',
              },
              properties: [
                {
                  id: 'unit',
                  value: 'iops',
                },
              ],
            },
            {
              matcher: {
                id: 'byRegexp',
                options: '/Throughput/',
              },
              properties: [
                {
                  id: 'unit',
                  value: 'Bps',
                },
              ],
            },
            {
              matcher: {
                id: 'byName',
                options: 'Pod',
              },
              properties: [
                {
                  id: 'links',
                  value: [
                    {
                      title: 'Drill down to pods',
                      url: '/d/6581e46e4e5c7ba40a07646395ef7b23/k8s-resources-pod?${datasource:queryparam}&var-cluster=$cluster&var-namespace=$namespace&var-pod=${__data.fields.Pod}',
                    },
                  ],
                },
              ],
            },
          ],
        },
        id: 18,
        options: {
          cellHeight: 'sm',
          footer: {
            countRows: false,
            fields: '',
            reducer: [
              'sum',
            ],
            show: false,
          },
          showHeader: true,
        },
        pluginVersion: '11.5.2',
        title: 'Current Storage IO',
        transformations: [
          {
            id: 'joinByField',
            options: {
              byField: 'pod',
              mode: 'outer',
            },
          },
          {
            id: 'organize',
            options: {
              excludeByName: {
                Time: true,
                'Time 1': true,
                'Time 2': true,
                'Time 3': true,
                'Time 4': true,
                'Time 5': true,
                'Time 6': true,
              },
              indexByName: {
                'Time 1': 0,
                'Time 2': 1,
                'Time 3': 2,
                'Time 4': 3,
                'Time 5': 4,
                'Time 6': 5,
                'Value #A': 7,
                'Value #B': 8,
                'Value #C': 9,
                'Value #D': 10,
                'Value #E': 11,
                'Value #F': 12,
                pod: 6,
              },
              renameByName: {
                'Value #A': 'IOPS(Reads)',
                'Value #B': 'IOPS(Writes)',
                'Value #C': 'IOPS(Reads + Writes)',
                'Value #D': 'Throughput(Read)',
                'Value #E': 'Throughput(Write)',
                'Value #F': 'Throughput(Read + Write)',
                pod: 'Pod',
              },
            },
          },
        ],
        type: 'table',
      },
      layout.grid(24, 7, 0, 66),
      [
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum by(pod) (rate(container_fs_reads_total{job="kubelet", metrics_path="/metrics/cadvisor", device=~"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|md.+|dasd.+)", container!="", cluster="$cluster", namespace="$namespace"}[$__rate_interval]))',
          format: 'table',
          instant: true,
          refId: 'A',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum by(pod) (rate(container_fs_writes_total{job="kubelet", metrics_path="/metrics/cadvisor", device=~"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|md.+|dasd.+)", container!="", cluster="$cluster", namespace="$namespace"}[$__rate_interval]))',
          format: 'table',
          instant: true,
          refId: 'B',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum by(pod) (rate(container_fs_reads_total{job="kubelet", metrics_path="/metrics/cadvisor", device=~"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|md.+|dasd.+)", container!="", cluster="$cluster", namespace="$namespace"}[$__rate_interval]) + rate(container_fs_writes_total{job="kubelet", metrics_path="/metrics/cadvisor", device=~"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|md.+|dasd.+)", container!="", cluster="$cluster", namespace="$namespace"}[$__rate_interval]))',
          format: 'table',
          instant: true,
          refId: 'C',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum by(pod) (rate(container_fs_reads_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", device=~"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|md.+|dasd.+)", container!="", cluster="$cluster", namespace="$namespace"}[$__rate_interval]))',
          format: 'table',
          instant: true,
          refId: 'D',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum by(pod) (rate(container_fs_writes_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", device=~"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|md.+|dasd.+)", container!="", cluster="$cluster", namespace="$namespace"}[$__rate_interval]))',
          format: 'table',
          instant: true,
          refId: 'E',
        }),
        queries.fromObject({
          datasource: {
            type: 'prometheus',
            uid: '${datasource}',
          },
          expr: 'sum by(pod) (rate(container_fs_reads_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", device=~"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|md.+|dasd.+)", container!="", cluster="$cluster", namespace="$namespace"}[$__rate_interval]) + rate(container_fs_writes_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", device=~"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|md.+|dasd.+)", container!="", cluster="$cluster", namespace="$namespace"}[$__rate_interval]))',
          format: 'table',
          instant: true,
          refId: 'F',
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
      query: 'label_values(up{job="kube-state-metrics"}, cluster)',
      refresh: 2,
      sort: 1,
      type: 'query',
    }),
    variables.fromObject({
      current: {
        text: 'monitoring',
        value: 'monitoring',
      },
      datasource: {
        type: 'prometheus',
        uid: '${datasource}',
      },
      label: 'namespace',
      name: 'namespace',
      options: [],
      query: 'label_values(kube_namespace_status_phase{job="kube-state-metrics", cluster="$cluster"}, namespace)',
      refresh: 2,
      sort: 1,
      type: 'query',
    }),
  ],
)
