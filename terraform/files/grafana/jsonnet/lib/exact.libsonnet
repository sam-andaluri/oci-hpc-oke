function(original, constructed={})
  local combined = constructed + original;
  { [field]: combined[field] for field in std.objectFields(original) }
