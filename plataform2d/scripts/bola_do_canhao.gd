extends Sprite2D

var dano: int = 3
var direction := -1
func _process(delta: float) -> void:
	position.x += delta * direction * 300

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(dano)
	if body.is_in_group("canhao"):
		print("canhao")
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.
