var Tile
var pos
var position
enum type {
	wall, rock, empty, grass, dirt,
	sprout,
	enemy
	}

var item = type.empty
var object
var cost = 0
var cost2 = 0

func Gettype():
	var tmp = "EMPTY"
	match (item):
		type.wall : tmp = "WALL"
		type.rock : tmp = "ROCK"
		type.grass : tmp = "GRASS"
		type.dirt : tmp = "DIRT"
		type.sprout : tmp = "SPROUT"
	return tmp
