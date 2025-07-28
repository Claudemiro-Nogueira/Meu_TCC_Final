extends Sprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $"."
@onready var aviso: CanvasLayer = $"../aviso"


# Called when the node enters tdhe scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	print(Global.pegou_pilula_nanicolina )
	if Global.pegou_pilula_nanicolina == true:
		queue_free()

# Quando o player entrar vai ativar a animação de sumir 
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		animation_player.play("sumir")
		aviso.get_child(1).play("aparece_pilula")
		#body.scale = Vector2(0.4, 0.4)


# Quando finalizar a animação vai atribuir a pilula de nanicolina para ativa
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "sumir":
		Global.pegou_pilula_nanicolina = true
