# Godot MIDI Player

Software MIDI player library for Godot Engine 3.1 later

* Changes play speed.
* Set tempo.
* Emit on some events (tempo change, appears lyric ...)
* Can control like AudioStreamPlayer.

I develop it for use embedding in game.

## Try it

1. Copy *.mid to "res://"
2. Copy *.sf2 to "res://"
3. Set MIDI path to MidiPlayer "file" parameter.
4. Set SoundFont path to MidiPlayer "soundfont" parameter.
5. Play

## How to use

* See [wiki](https://bitbucket.org/arlez80/godot-midi-player/wiki/)

### Demo

* [download](https://bitbucket.org/arlez80/godot-midi-player/downloads/demo.zip)
* BGM "failyland_gm.mid" from [IvyMaze]( http://ivymaze.sakura.ne.jp/ )

## TODO

* See [issues]( https://bitbucket.org/arlez80/godot-midi-player/issues )

## Not TODO

* Supports play format 2
* Implements some effects (Use godot's mixer!)

## Known Problem

* Player's timebase is 1/60.
    * It probably need 1/240 at least.
* Sometimes appear petit noises.

## License

MIT License

## Author

* @arlez80 あるる / きのもと 結衣 ( Yui Kinomoto )
