extends GutTest

const PLAYER_SCENE = preload("res://personagem/player.tscn")
var personagem_instance: CharacterBody2D

func before_all():
	personagem_instance = PLAYER_SCENE.instantiate()
	add_child(personagem_instance)

func test_se_personagem_existe():
	assert_not_null(personagem_instance, "A instância do personagem não deve ser nula.")
	assert_true(personagem_instance is CharacterBody2D, "A instância deve ser do tipo CharacterBody2D.")

func test_personagem_nao_esta_morto():
	assert_false(personagem_instance.is_dead, "O personagem não deve estar morto ao iniciar.")

func test_personagem_se_move_para_direita():
	var posicao_inicial = personagem_instance.global_position
	personagem_instance.direction = 1  # Simula pressionar "direita"
	personagem_instance._physics_process(0.1)
	
	var nova_posicao = personagem_instance.global_position
	assert_true(nova_posicao.x > posicao_inicial.x, "O personagem deveria ter se movido para a direita.")

func test_personagem_se_move_para_esquerda():
	var posicao_inicial = personagem_instance.global_position
	personagem_instance.direction = -1  # Simula pressionar "esquerda"
	personagem_instance._physics_process(0.1)
	
	var nova_posicao = personagem_instance.global_position
	assert_true(nova_posicao.x < posicao_inicial.x, "O personagem deveria ter se movido para a esquerda.")

func test_personagem_nao_se_move_sem_input():
	var posicao_inicial = personagem_instance.global_position
	personagem_instance.direction = 0
	personagem_instance._physics_process(0.1)

	var nova_posicao = personagem_instance.global_position
	assert_eq(posicao_inicial.x, nova_posicao.x, "O personagem não deveria ter se movido.")


func test_personagem_pula_com_velocity_negativa():
	personagem_instance.velocity = Vector2.ZERO
	personagem_instance.jumps = 0

	# Força as condições para pular
	personagem_instance.foi_morto = false
	personagem_instance.jump(0)  # Chama o método direto

	assert_lt(personagem_instance.velocity.y, 0, "A velocity.y deve ser negativa após o pulo.")

func test_valor_de_vida_do_global():
	Global.vida_player = 10
	assert_eq(Global.vida_player, 10, "O valor da vida do player no Global deve ser 10.")

func test_personagem_toma_dano():
	Global.vida_player = 10
	personagem_instance.foi_morto = false
	personagem_instance.levando_hit = false

	personagem_instance.take_damage(3)

	assert_eq(Global.vida_player, 7, "A vida do player deve ter diminuído para 7.")
	assert_true(personagem_instance.levando_hit, "O personagem deveria estar no estado de levando_hit.")


func test_personagem_morre_ao_zerar_vida():
	Global.vida_player = 2
	personagem_instance.foi_morto = false

	personagem_instance.take_damage(5)

	assert_true(personagem_instance.foi_morto, "O personagem deveria estar morto.")
	assert_eq(Global.vida_player, -3, "A vida pode ficar negativa, mas o player deve estar morto.")


func test_player_fica_pequeno_ao_usar_pilula():
	Global.pegou_pilula_nanicolina = true
	Global.ativar_pilula = true
	personagem_instance.pode_crescer = false
	personagem_instance.scale = Vector2(1, 1)

	personagem_instance.usar_pilula_nanicolina()

	assert_eq(personagem_instance.scale, Vector2(0.3, 0.3), "O personagem deveria ter ficado pequeno.")
	assert_false(Global.ativar_pilula, "A pílula deveria estar desativada.")
