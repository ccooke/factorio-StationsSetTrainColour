--Detect the state

-- Define the signals we will use
RGB = {
  [settings.global["sstn-rgb-red-signal"].value] = "r",
  [settings.global["sstn-rgb-green-signal"].value] = "g",
  [settings.global["sstn-rgb-blue-signal"].value] = "b",
  [settings.global["sstn-rgb-alpha-signal"].value] = "a"
}

-- The icon used for our alert signal
ERROR = { ["type"] = "virtual", ["name"] = "sstc-color-error" }

-- flags used to select actions
MODES = {
  do_nothing = 0,
  set_colour = 1,
  reset_colour = 2
}

-- What signals activate modes
CONTROL_SIGNALS = {
  ["sstc-set-color"] = MODES.set_colour,
  ["sstc-reset-color"] = MODES.reset_colour
}

-- Strings for debugging
SET = 'Set (by signal)'
RESET = 'Reset (by signal)'
DEFAULT_RESET = 'Reset'

function default_train_colour()
  return({
    r=settings.global["sstn-default-rgb-red"].value,
    g=settings.global["sstn-default-rgb-green"].value,
    b=settings.global["sstn-default-rgb-blue"].value,
    a=settings.global["sstn-default-rgb-alpha"].value
  })
end

function colour_to_string(colour)
  return "(R="..colour.r..",G="..colour.g..",B="..colour.b..",A="..colour.a..")"
end

function set_train_colour(train, colour, action)
  if settings.global['sstn-debug'].value then
    game.print("Train "..train.id.." waiting at station "..train.station.backer_name.." - "..action.." to "..colour_to_string(colour))
  end
  for _,locomotive in pairs(train.locomotives['front_movers']) do
    locomotive.color = colour
  end
  for _,locomotive in pairs(train.locomotives['back_movers']) do
    locomotive.color = colour
  end
end

function player_alert(entity, icon, message, force)
  force = force or (entity and entity.force)
  if not force or not force.valid then
    return
  end
  for _, player in pairs(force.players) do
    player.add_custom_alert(entity, icon, message, true)
    player.play_sound{path="utility/cannot_build"}
  end
end

script.on_event(defines.events.on_train_changed_state,
  function (event)
    local train = event.train
    if train.state == defines.train_state.wait_station and train.station ~= nil then
      local station = train.station
      local signals = station.get_merged_signals()
      local out = serpent.line(signals)

      local rgb = { r=0, g=0, b=0, a=128 }

      if signals == nil then
        signals = {}
      end

      local mode = MODES.do_nothing
      local colour_error = false

      for _,s in pairs(signals) do
        if RGB[s.signal.name] then
          if s.count > 255 or s.count < 0 then
            colour_error = true
          else
            rgb[RGB[s.signal.name]] = s.count
          end
        elseif CONTROL_SIGNALS[s.signal.name] and s.count > 0 then
          mode = bit32.bor(mode, CONTROL_SIGNALS[s.signal.name])
        end
      end

      if settings.global['sstn-debug'].value then
        game.print("Train "..train.id.." waiting at station "..train.station.backer_name.." - MODE is "..mode.." --- reset=".. bit32.band(mode,MODES.reset_colour) .. ", set="..bit32.band(mode,MODES.set_colour))
      end
      if bit32.band(mode, MODES.reset_colour) > 0 then
        set_train_colour(train, default_train_colour(), RESET)
      elseif bit32.band(mode, MODES.set_colour) > 0 then
        if colour_error then
          player_alert(station, ERROR, "RGB values out of range (0-255) at station "..station.backer_name, station.force)
        else
          set_train_colour(train, rgb, SET)
        end
      elseif settings.global['sstn-default-reset'].value then
        set_train_colour(train, default_train_colour(), DEFAULT_RESET)
      end
    end
  end
)

