
data:extend({
  {
    type = "item-subgroup",
    name = "SSTC-signal",
    group = "signals",
    order = "sstc0[SSTC-signal]"
  },
  {
    type = "virtual-signal",
    name = "sstc-set-color",
    icon = "__StationsSetTrainColour__/icons/sstc-set-color.png",
    icon_size = 64,
    subgroup = "SSTC-signal",
    order = "a-a"
  },
  {
    type = "virtual-signal",
    name = "sstc-reset-color",
    icon = "__StationsSetTrainColour__/icons/sstc-reset-color.png",
    icon_size = 64,
    subgroup = "SSTC-signal",
    order = "a-b"
  }
})
