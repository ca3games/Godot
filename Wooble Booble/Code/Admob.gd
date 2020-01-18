extends Node

var admob = null
var isReal = true
var isTop = true
var adBannerId = "ca-app-pub-5865058758227989/7849903116" 




func _ready():
	if(Engine.has_singleton("AdMob")):
		admob = Engine.get_singleton("AdMob")
		admob.init(isReal, get_instance_id())
		loadBanner()
		admob.showBanner()
		
	get_tree().connect("screen_resized", self, "onResize")

func loadBanner():
	if admob != null:
		admob.loadBanner(adBannerId, isTop)
		
func _on_admob_network_error():
	print("Network Error")

func _on_admob_ad_loaded():
	print("Ad loaded success")
	get_node("CanvasLayer/BtnBanner").set_disabled(false)
	


func onResize():
	if admob != null:
		admob.resize()
