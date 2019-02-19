extends RigidBody

var current 
var Near = false
var Far = false

func _ready():
	current = $STATES/IDLE
	
func _process(delta):
	if current != null:
		current._Update()
	
func _physics_process(delta):
	if current != null:
		current._Physics()
	
func _ChangeStatus(new_status):
	match(new_status):
		"idle" : current = $STATES/IDLE
		"chase" : current = $STATES/CHASING
		"far" : current = $STATES/FAR
		"dead" : current = $STATES/DEAD


func _Near_entered(body):
	if body.is_in_group("Player"):
		Near = true

func _Near_exited(body):
	if body.is_in_group("Player"):
		Near = false


func _Far_entered(body):
	if body.is_in_group("Player"):
		Far = true

func _Far_exited(body):
	if body.is_in_group("Player"):
		Far = false

func _PistolHit():
	_ChangeStatus("dead")
	
func _Delete():
	self.queue_free()