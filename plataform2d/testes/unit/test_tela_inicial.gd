extends GutTest

class MockSceneTree:
	extends Object

	var chamada_change_scene = false
	var cena_alvo = ""
	var chamada_quit = false

	func change_scene_to_file(scene_path: String) -> void:
		chamada_change_scene = true
		cena_alvo = scene_path

	func quit():
		chamada_quit = true

var tela_inicial

func before_each():
	tela_inicial = preload("res://scenes/tela_inicial.tscn").instantiate()
	add_child(tela_inicial)

func test_on_jogar_pressed_deve_mudar_cena():
	var mock = MockSceneTree.new()
	tela_inicial._tree_override = mock

	tela_inicial._on_jogar_pressed()

	assert_true(mock.chamada_change_scene)
	assert_eq(mock.cena_alvo, "res://scenes/node_2d.tscn")

func test_on_opcao_pressed_deve_ir_para_opcao():
	var mock = MockSceneTree.new()
	tela_inicial._tree_override = mock

	tela_inicial._on_opcao_pressed()

	assert_true(mock.chamada_change_scene)
	assert_eq(mock.cena_alvo, "res://scenes/tela_sobre.tscn")

func test_on_sair_pressed_deve_chamar_quit():
	var mock = MockSceneTree.new()
	tela_inicial._tree_override = mock

	tela_inicial._on_sair_pressed()

	assert_true(mock.chamada_quit)
