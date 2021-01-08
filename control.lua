--Detect the state

RGB = {
  ["signal-R"] = "r",
  ["signal-G"] = "g",
  ["signal-B"] = "b",
  ["signal-A"] = "a"
}
TRAIN_DEFAULT = { r=234, g=17, b=0, a=128 }

ERROR = { ["type"] = "virtual", ["name"] = "signal-red" }

MODES = {
  do_nothing = 0,
  set_colour = 1,
  reset_colour = 2
}

CONTROL_SIGNALS = {
  ["sstc-set-color"] = MODES.set_colour,
  ["sstc-reset-color"] = MODES.reset_colour
}

function set_train_colour(train, colour)
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
  end
end

script.on_event(defines.events.on_train_changed_state,
  function (event)
    local train = event.train
    if train.state == defines.train_state.wait_station and train.station ~= nil then
      local station = train.station
      local signals = station.get_merged_signals()
      local out = serpent.line(signals)
      -- game.print("Train "..train.id.." waiting at station "..train.station.backer_name.." [Signals: "..out.."]")

      local rgb = { r=0, g=0, b=0, a=128 }

      if signals == nil then
        return
      end

      local mode = MODES.do_nothing

      for _,s in pairs(signals) do
        if RGB[s.signal.name] then
          if s.count > 255 then
            player_alert(station, ERROR, "RGB values out of range", true)
            return
          end
          rgb[RGB[s.signal.name]] = s.count
        elseif CONTROL_SIGNALS[s.signal.name] and s.count > 0 then
          mode = bit32.bor(mode, CONTROL_SIGNALS[s.signal.name])
        end
      end

      -- game.print("Operation: MODE is "..mode)

      if bit32.band(mode, MODES.set_colour) > 0 then
        set_train_colour(train, rgb)
      end
      if bit32.band(mode, MODES.reset_colour) > 0 then
        set_train_colour(train, TRAIN_DEFAULT)
      end
    end
  end
)

