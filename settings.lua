data:extend({
  {
    type = "string-setting",
    name = "sstn-rgb-red-signal",
    order = "da",
    setting_type = "runtime-global",
    default_value = "signal-R",
  },
  {
    type = "string-setting",
    name = "sstn-rgb-green-signal",
    order = "db",
    setting_type = "runtime-global",
    default_value = "signal-G",
  },
  {
    type = "string-setting",
    name = "sstn-rgb-blue-signal",
    order = "dc",
    setting_type = "runtime-global",
    default_value = "signal-B",
  },
  {
    type = "string-setting",
    name = "sstn-rgb-alpha-signal",
    order = "dd",
    setting_type = "runtime-global",
    default_value = "signal-A",
  },
  {
    type = "bool-setting",
    name = "sstn-default-reset",
    order = "aa",
    setting_type = "runtime-global",
    default_value = false
  },
  {
    type = "bool-setting",
    name = "sstn-debug",
    order = "ab",
    setting_type = "runtime-global",
    default_value = false
  },
  {
    type = "int-setting",
    name = "sstn-default-rgb-red",
    order = "ba",
    setting_type = "runtime-global",
    default_value = 234,
    minimum_value = 0,
    maximum_value = 255
  },
  {
    type = "int-setting",
    name = "sstn-default-rgb-green",
    order = "bb",
    setting_type = "runtime-global",
    default_value = 17,
    minimum_value = 0,
    maximum_value = 255
  },
  {
    type = "int-setting",
    name = "sstn-default-rgb-blue",
    order = "bc",
    setting_type = "runtime-global",
    default_value = 0,
    minimum_value = 0,
    maximum_value = 255
  },
  {
    type = "int-setting",
    name = "sstn-default-rgb-alpha",
    order = "bd",
    setting_type = "runtime-global",
    default_value = 128,
    minimum_value = 0,
    maximum_value = 255
  }
})

