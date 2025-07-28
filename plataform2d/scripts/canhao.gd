extends StaticBody2D
const BOLA_DO_CANHAO = preload("res://inimigos/bola_do_canhao.tscn")
@onready var marker_2d: Marker2D = $Marker2D
@onready var animeted_sprite_2d: AnimatedSprite2D = $Sprite2D
@export var velocidade_tiro: int = 0
var pode_atirar: bool = false

func atirar():
	animeted_sprite_2d.play("attack")
	await get_tree().create_timer(0.4).timeout
	var bola = BOLA_DO_CANHAO.instantiate()
	add_child(bola)
	bola.global_position = marker_2d.global_position

	
func _on_timer_timeout() -> void:
	var tempo_entre_tiro = randi_range(1, 3)
	await get_tree().create_timer(tempo_entre_tiro).timeout
	atirar()



func _on_sprite_2d_animation_finished() -> void:
	if animeted_sprite_2d.animation == "attack":
		animeted_sprite_2d.play("idle")
