{
  grid(w, h, x, y): {
    h: h,
    w: w,
    x: x,
    y: y,
  },

  // Match the legacy Terraform expression exactly: the filtered panel's
  // position in the full panel array determines stat-panel placement.
  reflowHealthStats(panels):
    std.mapWithIndex(
      function(index, panel)
        if panel.type == 'stat' then
          panel {
            gridPos+: {
              x: (index % 8) * 3,
              y: std.floor(index / 8) * 3,
            },
          }
        else panel,
      panels,
    ),
}
