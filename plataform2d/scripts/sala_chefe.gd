extends Node2D

@onready var frog: CharacterBody2D = $frog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if frog == null:
		get_tree().change_scene_to_file("res://scenes/tela_fim.tscn")
	pass
