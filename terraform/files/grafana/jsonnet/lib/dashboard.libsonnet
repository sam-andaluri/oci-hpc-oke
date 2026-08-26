local exact = import './exact.libsonnet';
local g = import './grafonnet.libsonnet';

{
  fromObjects(metadata, panels, templating, variables):
    local original = metadata {
      panels: panels,
      templating: templating { list: variables },
    };
    local base =
      g.dashboard.new(original.title)
      + (if std.objectHas(original, 'uid') then g.dashboard.withUid(original.uid) else {});
    exact(original, base),
}
