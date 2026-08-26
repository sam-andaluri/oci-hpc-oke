local exact = import './exact.libsonnet';
local g = import './grafonnet.libsonnet';

{
  fromObject(panel, gridPos=null, targets=null):
    local original =
      panel
      + (if gridPos == null then {} else { gridPos: gridPos })
      + (if targets == null then {} else { targets: targets });
    local base =
      if original.type == 'timeseries' then g.panel.timeSeries.new(original.title)
      else if original.type == 'stat' then g.panel.stat.new(original.title)
      else if original.type == 'gauge' then g.panel.gauge.new(original.title)
      else if original.type == 'table' then g.panel.table.new(original.title)
      else if original.type == 'state-timeline' then g.panel.stateTimeline.new(original.title)
      else if original.type == 'row' then g.panel.row.new(original.title)
      else if original.type == 'text' then g.panel.text.new(original.title)
      else if original.type == 'alertlist' then g.panel.alertList.new(original.title)
      else error 'Unsupported Grafana panel type: ' + original.type;
    exact(original, base),
}
