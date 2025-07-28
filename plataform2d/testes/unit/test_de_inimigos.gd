extends GutTest

const FROG_SCENE = preload("res://inimigos/frog.tscn")
var frog: CharacterBody2D

func before_each():
	frog = FROG_SCENE.instantiate()
	add_child_autofree(frog)  # Isso garante que o frog será liberado após o teste

func test_estado_inicial_frog():
	# Verifica se o frog começa com os valores corretos
	#assert_eq(frog.vida, frog.VIDA_MAX, "Deve começar com vida máxima")
	assert_false(frog.is_dead, "Não deve começar morto")
	assert_false(frog.levando_hit, "Não deve começar levando hit")
	assert_eq(frog.direction, -1, "Direção inicial deve ser -1")

func test_receber_dano():
	# Testa se o frog recebe dano corretamente
	frog.take_damage(2)
	assert_eq(frog.vida, frog.VIDA_MAX - 2, "Vida deve diminuir pelo dano")
	assert_true(frog.levando_hit, "Deve estar levando hit após dano")

func test_morrer_quando_vida_zera():
	# Testa se o frog morre quando a vida chega a zero
	frog.take_damage(frog.VIDA_MAX)
	assert_true(frog.is_dead, "Deve estar morto quando vida <= 0")
	# Verifica se a animação de morte é acionada
	frog._process(0.1)
	assert_true(frog.is_queued_for_deletion(), "Deve estar na fila para ser liberado")


func test_inimigo_se_movimenta():
	frog.direction = 1
	add_child(frog)  # só se ainda não tiver feito isso
	var posicao_inicial = frog.position.x
	
	frog._physics_process(0.1)

	var posicao_final = frog.position.x

	assert_gt(posicao_final, posicao_inicial, "O inimigo deve ter se movido para a direita.")

func test_inimigo_toma_dano_e_fica_vivo():
	var inimigo = preload("res://inimigos/frog.tscn").instantiate()
	add_child(inimigo)

	inimigo.vida = 5
	inimigo.is_dead = false
	inimigo.levando_hit = false

	inimigo.take_damage(2)

	assert_eq(inimigo.vida, 3, "A vida do inimigo deve diminuir para 3.")
	assert_true(inimigo.levando_hit, "O inimigo deve estar no estado de levando_hit.")
	assert_false(inimigo.is_dead, "O inimigo ainda não deveria estar morto.")
