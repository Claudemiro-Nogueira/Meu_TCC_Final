extends AnimatedSprite2D
@onready var pegar_sfx: AudioStreamPlayer2D = $pegar_sfx
@onready var aviso: CanvasLayer = $"../aviso"


var is_playng: bool = false
var entrou: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.pegou_pulo_duplo == true:
		$AnimationPlayer.play("new_animation")
		
	if is_playng == true:
		pegar_sfx.play(0.0)
		is_playng = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if entrou == 0:
		print(body.name)
		Global.max_jumps = 1
		Global.pegou_pulo_duplo = true
		is_playng = true
		entrou = 1
		aviso.get_child(1).play("aparece")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free();
	


func _on_pegar_sfx_finished() -> void:
	is_playng =  false


func _on_area_2d_body_exited(body: Node2D) -> void:
	is_playng = false
	pass # Replace with function body.
