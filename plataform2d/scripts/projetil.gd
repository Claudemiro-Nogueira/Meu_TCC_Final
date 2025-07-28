# Projetil.gd
extends Area2D

@export var velocidade: float = 400.0
var direcao = Vector2.ZERO

func _process(delta):
	pass

func _on_timer_timeout():
	queue_free()

func _on_area_entered(area):
	queue_free()  # Destroi o projétil ao colidir com algo

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "ataque":
		queue_free()
