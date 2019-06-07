extends Node2D

var result = 0
var tmp = 0
var floating = false

onready var TimerTmp = $TimerTmp
onready var TimerResult = $TimerResult


func _ready():
	randomize()
	var sprite = randi()%40+1
	$oreimo.frame = sprite
	ErrorCode("NO ERROR", Color.darkblue)
	SetLabels()


func AddNumber(number):
	$Calculator/Tmp.set("custom_colors/font_color", Color.white)
	
	var size = str(tmp) 
	if size.length() >= 10:
		ErrorCode("CANT HOLD ANYMORE DIGITS", Color.darkblue)
		BounceTmp()
		return
		
	if !floating:
		tmp = int((tmp * 10) + number)
	else:
		var temporal = str(tmp)
		if temporal.find(".") == -1:
			temporal = temporal + "." + str(number)
		else:
			if temporal.ends_with("0"):
				for id in range(0, 5):
					if temporal.ends_with("0"):
						temporal.erase(temporal.length()-1, 1)
					else:
						break;
			temporal = temporal + str(number)
		tmp = float(temporal)
	
	$Sounds.PlayNumber(number)
	
	SetLabels()

func Clean():
	ResetColors()
	tmp = 0
	ErrorCode("NO ERROR", Color.darkblue)
	$SoundOperations/Clean.play()
	SetLabels()

func AllClean():
	ResetColors()
	ErrorCode("NO ERROR", Color.darkblue)
	result = 0
	tmp = 0
	floating = false
	$SoundOperations/Clean.play()
	SetLabels()

func AddDot():
	if str(tmp).length() <= 6:
		floating = true
		tmp = float(tmp)
		
		SetLabels()
	else:
		ErrorCode("DECIMAL TOO BIG", Color.red)
		ErrorTmp()

func ErrorTmp():
	$Calculator/Tmp.set("custom_colors/font_color", Color.red)
	BounceTmp()
	
func BounceTmp():
	var pos = $Calculator/Tmp.get("rect_position")
	TimerTmp.interpolate_property($Calculator/Tmp, "rect_position", Vector2(pos.x+20, pos.y), pos, 0.2, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	TimerTmp.start()

func ErrorResult():
	$Calculator/Result.set("custom_colors/font_color", Color.red)
	BounceResult()

func BounceResult():
	var pos = $Calculator/Result.get("rect_position")
	TimerResult.interpolate_property($Calculator/Result, "rect_position", Vector2(pos.x+20, pos.y), pos, 0.2, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	TimerResult.start()

func Negative():
	tmp *= -1
	SetLabels()

func ResetColors():
	$Calculator/Tmp.set("custom_colors/font_color", Color.white)
	$Calculator/Result.set("custom_colors/font_color", Color.white)

func Operation(operation):
	ResetColors()
	var tmp_result = result
	match (operation):
		"add" : 
			tmp_result += tmp
			ErrorCode("NO ERROR", Color.darkblue)
			$SoundOperations/C.play()
		"minus" :
			tmp_result -= tmp
			ErrorCode("NO ERROR", Color.darkblue)
			$SoundOperations/C.play()
		"multi" :
			tmp_result *= tmp
			ErrorCode("NO ERROR", Color.darkblue)
			$SoundOperations/C.play()
		"div" :
			if tmp != 0:
				tmp_result = float(tmp_result / tmp)
				ErrorCode("NO ERROR", Color.darkblue)
				$SoundOperations/C.play()
			else:
				ErrorCode("CANT DIVIDE BY 0", Color.red)
				ErrorTmp()
		"sqrt" :
			tmp_result = sqrt(result)
			ErrorCode("NO ERROR", Color.darkblue)
			$SoundOperations/C.play()
		"perc" :
			if tmp == 0:
				ErrorCode("CANT MODULO BY 0", Color.red)
			if tmp_result < tmp:
				ErrorCode("CANT MODULO WITH A SMALLER NUMBER", Color.red)				
			if tmp != 0 and tmp_result >= tmp:
				tmp_result = int(tmp_result) % int(tmp)
				ErrorCode("NO ERROR", Color.darkblue)
				$SoundOperations/C.play()
			else:
				ErrorTmp()
	
	if str(tmp_result).length() > 10:
		ErrorCode("OPERATION IS TOO BIG", Color.red)
		ErrorResult()
	else:
		tmp = 0
		result = tmp_result
		floating = false
		SetLabels()

func BackSpace():
	ResetColors()
	$SoundOperations/Delete.play()
	var number = str(tmp)
	if number.length()-1 > 0:
		ErrorCode("NO ERROR", Color.darkblue)
		number.erase(number.length()-1,  1)
		tmp = float(number)
	else:
		floating = false
		Clean()
	SetLabels()

func Result():
	ErrorCode("NO ERROR", Color.darkblue)
	ResetColors()
	result = tmp
	tmp = 0
	SetLabels()

func SetLabels():
	var size = GetSizeFloating()
	SetLabel($Calculator/Tmp, tmp, size.x)
	SetLabel($Calculator/Result, result, size.y)
		

func SetLabel(label, text, size):
	label.text = ("%." + str(size) + "f") % text

func GetDecimals(textvar):
	var size = 0
	if textvar.find(".") and len(textvar) <= 9:
		var dot = false
		for i in range(0, len(textvar)):
			if dot:
				size += 1
			if textvar[i] == ".":
				dot = true
	return size

func ErrorCode(text, color):
	$Calculator/Error.text = text
	$Calculator/Error.set("custom_colors/font_color", color)
	if color == Color.red:
		$SoundOperations/Delete.play()

func GetSizeFloating():
	var size = Vector2(1,1)
	var stringtmp = str(tmp)
	var stringresult = str(result)
	return Vector2(GetDecimals(stringtmp), GetDecimals(stringresult))
	

func _on_Change_pressed():
	var sprite = randi()%40+1
	$oreimo.frame = sprite
