extends Node2D

const DEFAULT_PORT = 8000

var game
var upnp

func _player_connected(id):
	$Panel.hide()
	print("player connected")
	game = load("res://Scene/Map.tscn").instance()
	game.connect("game_finished", self, "_end_game", [], CONNECT_DEFERRED)
	get_tree().get_root().add_child(game)

func _player_disconnected(id):
	if get_tree().is_network_server():
		_end_game("Client disconnected")
	else:
		_end_game("Server disconnected")
		
func _connected_ok():
	pass

func _connected_fail():
	$Panel/Info.text = "Couldn't connect"
	get_tree().set_network_peer(null)
	
	get_node("Panel/join").set_disabled(false)
	get_node("Panel/host").set_disabled(false)

func _server_disconnected():
	_end_game("Server disconnected")

func _end_game(with_error=""):
	if has_node("root/Map"):
		get_node("root/Map").free()
		show()
	get_tree().set_network_peer(null)
	$Panel/Info.text = with_error

func GAMEOVER(boolean):
	
	game.queue_free()
	get_tree().set_network_peer(null)
	upnp.delete_port_mapping(8000)
	Variables.GameOver(boolean)
	

func _ready():
	Variables.type = Variables.typemode.network
	get_tree().connect("network_peer_connected",self,"_player_connected")
	get_tree().connect("network_peer_disconnected",self,"_player_disconnected")
	get_tree().connect("connected_to_server",self,"_connected_ok")
	get_tree().connect("connection_failed",self,"_connected_fail")
	get_tree().connect("server_disconnected",self,"_server_disconnected")
	
	upnp = UPNP.new()
	upnp.discover()
	if upnp.get_gateway() and upnp.get_gateway().is_valid_gateway():
    	upnp.add_port_mapping(DEFAULT_PORT, DEFAULT_PORT, 'Godot', 'UDP')
    	upnp.add_port_mapping(DEFAULT_PORT, DEFAULT_PORT, 'Godot', 'TCP')
	

func host_room():
	var host = NetworkedMultiplayerENet.new()
	var error = host.create_server(DEFAULT_PORT, 2)
	if (error != OK):
		$Panel/Info.text = "Can't host"
		return
	
	$Panel/Info.text = "Waiting for player 2..."	
	get_tree().set_network_peer(host)

func join_room():
	var ip = $Panel/LineEdit.text
	if (not ip.is_valid_ip_address()):
		$Panel/Info.text = "IP address is invalid"
		return
	var host = NetworkedMultiplayerENet.new()
	host.create_client(ip, DEFAULT_PORT)
	get_tree().set_network_peer(host)
	
	$Panel/Info.text = "Connecting..."
	
func leave_room():
	get_tree().set_network_peer(null)
	$Panel.show()

func _on_host_pressed():
	host_room()


func _on_join_pressed():
	join_room()
