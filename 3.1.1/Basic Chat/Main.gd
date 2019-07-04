extends Node2D

const PORT = 3000
const MAX_USERS = 4

func _ready():
	$Leave.hide()
	get_tree().connect("connected_to_server", self, "enter_room")
	get_tree().connect("network_peer_connected", self, "user_entered")
	get_tree().connect("network_peer_disconnected", self, "user_exited")
	get_tree().connect("server_disconnected", self, "_server_disconnected")

func _server_disconnected():
	$Panel/TextEdit.text += "Disconnected from Server\n"
	Leave_room()

func user_entered(id):
	$Panel/TextEdit.text += str(id) + " joined the room\n"
	
func user_exited(id):
	$Panel/TextEdit.text += str(id) + " left the room\n"
	

func join_room():
	var ip = $IP.text
	var host = NetworkedMultiplayerENet.new()
	host.create_client(ip, PORT)
	get_tree().set_network_peer(host)
	enter_room()
	var id = get_tree().get_network_unique_id()
	rpc("Joined", id)
	
func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			send_message()

func send_message():
	var msg = $Panel/LineEdit.text
	$Panel/LineEdit.text = ""
	var id = get_tree().get_network_unique_id()
	rpc("receive_message", id, msg)

sync func Joined(id):
	$Panel/TextEdit.text += str(id) + ": " + "Has joined the chat" + "\n"

sync func receive_message(id, msg):
	$Panel/TextEdit.text += str(id) + ": " + msg + "\n"
	

func enter_room():
	$Leave.show()
	$Host.hide()
	$Join.hide()
	$IP.hide()
	
func Leave_room():
	$Leave.hide()
	$Join.show()
	$Host.show()
	$IP.show()
	var id = get_tree().get_network_unique_id()
	user_exited(id)

func Host_room():
	var host = NetworkedMultiplayerENet.new()
	host.create_server(PORT, MAX_USERS)
	get_tree().set_network_peer(host)
	enter_room()
	$Panel/TextEdit.text = "Room Created\n"
