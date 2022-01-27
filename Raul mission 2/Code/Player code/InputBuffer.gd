extends Spatial

var buffer = []
var released_buffer = []
var released_time = 0
var idle = 0

enum key {left, left_up, left_down, right_up, right_down, right, up, down,
			none, bomb, punch}

func _ready():
	buffer.append(key.none)
	released_buffer.append(key.none)

func GetArrows():
	var k = key.none
	var left = false
	var right = false
	var up = false
	var down = false
	if Input.is_action_pressed("LEFT"):
		left = true
	if Input.is_action_pressed("RIGHT"):
		right = true
	if Input.is_action_pressed("UP"):
		up = true
	if Input.is_action_pressed("DOWN"):
		down = true
	if left and not right and not up and not down:
		k = key.left
	if left and not right and up and not down:
		k = key.left_up
	if left and not right and not up and down:
		k = key.left_down
	if not left and not right and up and not down:
		k = key.up
	if not left and not right and not up and down:
		k = key.down
	if not left and right and not up and not down:
		k = key.right
	if not left and right and up and not down:
		k = key.right_up
	if not left and right and not up and down:
		k = key.right_down
	
	return k
	
func GetReleasedArrows():
	var k = key.none
	var left = false
	var right = false
	var up = false
	var down = false
	if Input.is_action_just_released("LEFT"):
		left = true
	if Input.is_action_just_released("RIGHT"):
		right = true
	if Input.is_action_just_released("UP"):
		up = true
	if Input.is_action_just_released("DOWN"):
		down = true
	if left and not right and not up and not down:
		k = key.left
	if left and not right and up and not down:
		k = key.left_up
	if left and not right and not up and down:
		k = key.left_down
	if not left and not right and up and not down:
		k = key.up
	if not left and not right and not up and down:
		k = key.down
	if not left and right and not up and not down:
		k = key.right
	if not left and right and up and not down:
		k = key.right_up
	if not left and right and not up and down:
		k = key.right_down
	
	return k

func AddBuffer(k, released):
	if k != key.none:
		idle = 0
	elif idle < 100:
		idle += 1
	if len(buffer) > 10:
		buffer.remove(len(buffer)-1)
	if len(released_buffer) > 10:
		released_buffer.remove(len(released_buffer)-1)
	if k != buffer[0] and k != key.none:
		buffer.insert(0, k)
	if released and k != key.none:
		released_buffer.insert(0, k)
		released_buffer.insert(0, key.none)
		released_time = 0
	else:
		if released_time < 100:
			released_time += 1

func _physics_process(delta):
	var k = GetArrows()
	AddBuffer(k, false)
	k = GetReleasedArrows()
	AddBuffer(k, true)
	
	#var p = str(buffer) + " | " + str(released_buffer) + " last pressed: " + str(released_time)
	#$BUFFERPRINT.text = p
