extends Node2D

var notes = []
var offset = []

func _ready():
	for i in range(0, 12):
		notes.append([])
		offset.append([])
		match (i):
			0: 
				notes[i] = $Piano/C
				offset[i] = Vector2(25, 5)
			1: 
				notes[i] = $Piano/Db
				offset[i] = Vector2(25, 5)
			2: 
				notes[i] = $Piano/D
				offset[i] = Vector2(15, 3)
			3: 
				notes[i] = $Piano/Eb
				offset[i] = Vector2(0, 0)
			4: 
				notes[i] = $Piano/E
				offset[i] = Vector2(-5, -2)
			5: 
				notes[i] = $Piano/F
				offset[i] = Vector2(-20, -5)
			6: 
				notes[i] = $Piano/Gb
				offset[i] = Vector2(30, 8)
			7: 
				notes[i] = $Piano/G
				offset[i] = Vector2(20, 5)
			8: 
				notes[i] = $Piano/Ab
				offset[i] = Vector2(10, 5)
			9: 
				notes[i] = $Piano/A
				offset[i] = Vector2(5, 2)
			10: 
				notes[i] = $Piano/Bb
				offset[i] = Vector2(-5, 0)
			11: 
				notes[i] = $Piano/B
				offset[i] = Vector2(-15, -3)
	Reset_Colors()

func Reset_Colors():
	for i in range(0, 12):
		notes[i].modulate = Color.white
	
	notes[1].modulate = Color.black
	notes[3].modulate = Color.black
	notes[6].modulate = Color.black
	notes[8].modulate = Color.black
	notes[10].modulate = Color.black
	
func Note_ON(note, program, channel):
	Reset_Colors()
	if channel == 9:
		if note%12 <= 5:
			$Cat.animation = "right on"
		else:
			$Cat.animation = "left on"
		notes[note%12].modulate = Color.red
		$Cat.offset = offset[note%12]
		$Block/AnimatedSprite.animation = "Percussion"
		$Block/AnimatedSprite.frame = note
	else:
		if note <= 5:
			$Cat.animation = "right on"
		else:
			$Cat.animation = "left on"
		notes[note].modulate = Color.red
		$Cat.offset = offset[note]
		$Block/AnimatedSprite.animation = "Instruments"
		$Block/AnimatedSprite.frame = program

func Note_OFF(channel):
	if channel == 9:
		$Timer.start(0.2)
	else:
		$Timer.start(1)

func _on_Timer_timeout():
	Reset_Colors()
	$Cat.animation = "off"
