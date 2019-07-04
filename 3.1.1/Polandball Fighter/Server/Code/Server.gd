extends Node2D

var ready_players = []
var players = 5

remote func player_ready():
	var caller_id = get_tree().get_rpc_sender_id()
	
	if not ready_players.has(caller_id):
		ready_players.append(caller_id)
	
	if ready_players.size() == players.size():
		pre_start_game()
		
func pre_start_game():
	var world = load("res://Scenes/World.tscn").instance()
	get_tree().get_root().add_child(world)
	
	for id in players:
		get_node("/root/World").spawn_player(Vector2(0,0), id)
	
	rpc("pre_start_game")

remote func post_start_game():
	var caller_id = get_tree().get_rpc_sender_id()
	var world = get_node("/root/World")
	
	for player in world.get_node("Players").get_children():
		world.rpc_id(caller_id, "spawn_player", player.position, player.get_network_master())