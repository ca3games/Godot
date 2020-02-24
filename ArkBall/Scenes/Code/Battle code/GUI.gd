extends CanvasLayer

onready var Mana = $Mana
onready var HP = $HP

func _ready():
	Mana.value = 0

func _process(delta):
	if Mana.value < 40:
		$Health.disabled = true
	else:
		$Health.disabled = false
	
	if Mana.value < 25:
		$Switch.disabled = true
	else:
		$Switch.disabled = false
	
	if Mana.value < 15:
		$Spell.disabled = true
	else:
		$Spell.disabled = false
		
	if $Time/TimeTimer.time_left < 10:
		$Time.tint_progress = Color.red
		$Time/TimeLabel.set("custom_colors/font_color", Color.red)
	elif $Time/TimeTimer.time_left < 25:
		$Time.tint_progress = Color.orange
		$Time/TimeLabel.set("custom_colors/font_color", Color.orange)
	elif $Time/TimeTimer.time_left < 35:
		$Time.tint_progress = Color.yellow
		$Time/TimeLabel.set("custom_colors/font_color", Color.yellow)
	else:
		$Time.tint_progress = Color.green
		$Time/TimeLabel.set("custom_colors/font_color", Color.green)
	
func Hide():
	$HP.hide()
	$Health.hide()
	$Mana.hide()
	$Switch.hide()
	$HP2.hide()
	$MP.hide()
	$Spell.hide()
	$Level.hide()
	$TimeButton.hide()
	$SCORE.hide()

func Show():
	$HP.show()
	$Health.show()
	$Mana.show()
	$Switch.show()
	$HP2.show()
	$MP.show()
	$Spell.show()
	$Level.show()
	$TimeButton.show()
	$SCORE.show()
	$TimeButton.disabled = false
