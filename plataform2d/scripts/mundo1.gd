extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.from_world != null:
		$player.global_position = get_node(Global.from_world+"Pos")
		

	
