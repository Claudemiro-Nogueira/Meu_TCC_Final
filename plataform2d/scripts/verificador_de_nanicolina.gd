extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	body.pode_crescer = true
	print("Não pode crescer")
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	body.pode_crescer = false
	print("Pode crescer")
	pass # Replace with function body.
