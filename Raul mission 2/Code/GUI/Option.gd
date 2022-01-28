extends Control

var ID = 0
var typemenu = 0

func ChangePanelColor(id):
	$Panel.theme.get("Panel/styles/panel").set("bg_color", id)
