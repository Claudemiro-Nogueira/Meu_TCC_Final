extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	if Global.morto:
		$player.global_position = get_node("morto").global_position
		print("MORTOOOOOOOOOOOO")
		Global.morto = false
		Global.from_world = null

	if Global.from_world != null:
		print(get_node(Global.from_world+"Pos"))
		$player.global_position = get_node(Global.from_world+"Pos").global_position
		print(Global.from_world+"Pos")
	
