local exact = import './exact.libsonnet';
local g = import './grafonnet.libsonnet';
local variable = g.dashboard.variable;

{
  fromObject(value):
    local base =
      if value.type == 'datasource' then
        variable.datasource.new(value.name, value.query)
      else if value.type == 'query' then
        variable.query.new(value.name)
      else {};
    exact(value, base),
}
