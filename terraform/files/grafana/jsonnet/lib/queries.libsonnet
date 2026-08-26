local exact = import './exact.libsonnet';
local g = import './grafonnet.libsonnet';

{
  fromObject(target):
    local isPrometheus =
      std.objectHas(target, 'expr') &&
      std.objectHas(target, 'datasource') &&
      std.objectHas(target.datasource, 'type') &&
      target.datasource.type == 'prometheus';
    local base =
      if isPrometheus then
        g.query.prometheus.new(target.datasource.uid, target.expr)
      else {};
    exact(target, base),
}
