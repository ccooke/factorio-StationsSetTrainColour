# Stations Set Train Colour

I couldn't find any mod doing exactly this, so I wrote my own

This mod allows you to set the colour of a train when it arrives (and waits) at a station. Note - nothing will happen unless the train actually stops.

## Setting the colour

Connect a circuit network to a station and set the ![sstc-set-colour](https://github.com/ccooke/factorio-StationsSetTrainColour/blob/main/icons/sstc-set-color.png?raw=true) signal.
When a train stops, the `R`, `G`, `B` and `A` signals will be read and used to set the colour and transparency. They default to 0,0,0,128.

## Resetting the colour

Connect a circuit network to a station and set the ![sstc-reset-colour](https://github.com/ccooke/factorio-StationsSetTrainColour/blob/main/icons/sstc-reset-color.png?raw=true) signal.
When a train stops, the train's colour will be reset to the default.

You can also set the module option `Default Reset`, which causes all stations to reset colour unless the ![sstc-set-colour](https://github.com/ccooke/factorio-StationsSetTrainColour/blob/main/icons/sstc-set-color.png?raw=true) signal is set.

## Precedence

If the ![sstc-reset-colour](https://github.com/ccooke/factorio-StationsSetTrainColour/blob/main/icons/sstc-reset-color.png?raw=true) signal is set, the station will *always* reset the train's colour to default.

## Module Options

* `Default Reset` - Reset train colours by default
* Default `Red`, `Green`, `Blue` and `Alpha` - The default colour for trains. Initially set to the vanilla standard of [234,17,0,128]
* `Debug` - Generate debug messages
* `Red`, `Green`, `Blue` and `Alpha` signals - The names of the signals to use for colour. *Do not change these unless you know what you are doing*
