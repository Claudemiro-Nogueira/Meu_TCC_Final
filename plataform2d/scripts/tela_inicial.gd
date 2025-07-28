extends Control
#
#var _tree_override : SceneTree = null
#
#func get_scene_tree() -> SceneTree:
	#return _tree_override if _tree_override else get_tree()
#
#func _on_jogar_pressed() -> void:
	#get_scene_tree().change_scene_to_file("res://scenes/node_2d.tscn")
#
#func _on_opcao_pressed() -> void:
	#get_scene_tree().change_scene_to_file("res://scenes/tela_sobre.tscn")
#
#func _on_sair_pressed() -> void:
	#get_scene_tree().quit()


var _tree_override = null

func _get_scene_tree():
	return _tree_override if _tree_override else get_tree()

func _on_jogar_pressed() -> void:
	_get_scene_tree().change_scene_to_file("res://scenes/node_2d.tscn")

func _on_opcao_pressed() -> void:
	_get_scene_tree().change_scene_to_file("res://scenes/tela_sobre.tscn")

func _on_sair_pressed() -> void:
	_get_scene_tree().quit()
