extends RigidBody

var current 
var Near = false
var Far = false

func _ready():
	current = $STATES/IDLE
	
func _process(delta):
	current._Update()
	
func _physics_process(delta):
	current._Physics()
	
func _ChangeStatus(new_status):
	print (new_status)
	match(new_status):
		"idle" : current = $STATES/IDLE
		"chase" : current = $STATES/CHASING
		"far" : current = $STATES/FAR


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
