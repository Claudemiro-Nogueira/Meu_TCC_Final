extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		call_deferred("mudar_mundo")
		

func mudar_mundo():
#	Antes de mudar de tela ele vai pegar o pai do nó e salvar em uma variavel global
	Global.from_world = get_parent().name
	print(">>>>>>>>" +get_parent().name)
#												Vai pegar o nome do nó
	get_tree().change_scene_to_file("res://scenes/"+ name + ".tscn")
