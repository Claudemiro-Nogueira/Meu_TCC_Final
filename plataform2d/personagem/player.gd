extends CharacterBody2D
 
# -------------------------------- Variaveis ---------------------------------------
@export var speed = 200
@export var jump_velocity = 400
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var node_2d: CharacterBody2D = $"."
@onready var ProjetilScene = preload("res://scenes/projetil.tscn")
@onready var attak_area: Area2D = $attak_area
@onready var jump_sfx: AudioStreamPlayer2D = $jump_sfx
@onready var attack_sfx: AudioStreamPlayer2D = $attack_sfx
@onready var damage_sfx: AudioStreamPlayer2D = $damage_sfx
@onready var walk_sfx: AudioStreamPlayer2D = $walk_sfx
@onready var player: CharacterBody2D = $"."



var gravity: int = 1000
var direction: float 
var pulo_duplo: bool = false
var is_moving: bool = false  
var pode_atacar: bool = false
var jumps: int = 0

var step_interval = 0.32  # segundos entre os sons de passos
var step_timer = 0.0

const VIDA_MAX = 10
const DANO = 3
var atacando: bool = false
var vida: int  = VIDA_MAX
var is_dead: bool = false
var levando_hit: bool = false
var foi_morto: bool = false
var pode_crescer: bool = false;
# ----------------------------------------------------------------------------------


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	animate()
	flip_h()
	


	
func _physics_process(delta: float) -> void:
	if foi_morto:
		velocity.x = move_toward(velocity.x,0,speed)
	gravidade(delta)
	mover(delta)
	move_and_slide()


func _input(event: InputEvent) -> void:

	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("pular"):
		if jumps == 0 and is_on_floor() :
			jump(direction)
	
		if jumps < Global.max_jumps:
			jump(direction)
			print(jumps)
			jumps += 1
	
#	Mecanica de atauqe
	if Input.is_action_just_pressed("ataque"):
		atacar()
	 


	if Input.is_action_just_pressed("nanicolina") and Global.pegou_pilula_nanicolina:
		if Global.ativar_pilula == false:
			if !pode_crescer:
				player.scale = Vector2(1, 1)
				Global.ativar_pilula = true
		elif Global.ativar_pilula:
			player.scale = Vector2(0.3, 0.3)
			Global.ativar_pilula = false

	direction = Input.get_axis("esquerda", "direita")
	
	
#	Aqui é so para testes, quando terminar de fazer os testes precisa comentar essas 2 linhas
	#if Input.is_action_just_pressed("nanicolina"):
		#usar_pilula_nanicolina()


func flip_h():
	if velocity.x > 0:
		animated_sprite_2d.flip_h = false
		$attak_area/Collision.position.x = 40
	
	if velocity.x < 0:
		animated_sprite_2d.flip_h = true
		$attak_area/Collision.position.x = -20
	
		

		
func animate():
	if foi_morto:
		$AnimatedSprite2D.play("death")
		return
	if levando_hit:
		animated_sprite_2d.play("hit")
		return
	if pode_atacar:
		$AnimationPlayer.play("attack")
		animated_sprite_2d.play("attack_do_player")
		return
	if velocity.y > 0 and not is_on_floor():
		animated_sprite_2d.play("fall")
		return
	if velocity.y < 0 and not is_on_floor():
		animated_sprite_2d.play("jump")
		return
	if velocity.x != 0:
		animated_sprite_2d.play("run")
		return
	if velocity.x == 0:
		animated_sprite_2d.play("idle")
		return
		

func gravidade(delta: float):
	if not is_on_floor():
		velocity.y += delta * gravity
	if is_on_floor():
		jumps = 0   

		
func jump(direction):
	jump_sfx.play(0.0)
	velocity.y = - jump_velocity

func mover(delta):
	if foi_morto:
		return
#	Adicionar o som ao caminhar
	if direction != 0 and is_on_floor() and not is_on_wall():
		step_timer -= delta
		if step_timer <= 0.0:
			walk_sfx.play()
			step_timer = step_interval
	else:
		step_timer = 0.0  # reseta o timer quando para de andar ou pula

		
	var current_speed = speed
	
	if not is_on_floor():
		current_speed *= 1.2  # Aumenta a velocidade horizontal no ar (ajuste esse valor como quiser)
	
	velocity.x = direction * current_speed

 
func atacar():
	attack_sfx.play(0.0)
	pode_atacar = true


func _on_animated_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "attack_do_player":
		pode_atacar = false
	if $AnimatedSprite2D.animation == "hit":
		levando_hit = false
	if $AnimatedSprite2D.animation == "death":
		queue_free()
		Global.morto = true
		Global.resetar()
		call_deferred("mudar_mundo")
		
		
		
func mudar_mundo():
	get_tree().change_scene_to_file("res://scenes/node_2d.tscn")


func take_damage(amount: int):

	if foi_morto:
		return

	Global.vida_player -= amount
	
	print("levou dano do inimigo")
	print(amount)
	print(Global.vida_player)
	if Global.vida_player <= 0:
		damage_sfx.play(0.0)
		foi_morto = true
	else:
		damage_sfx.play(0.0)
		levando_hit = true
		

func _on_attak_area_body_entered(body: Node2D) -> void:
	print(body)
	if body.is_in_group("enemy"):
		print("inimigo")
		atacando = true
		print(body)
		body.take_damage(DANO)



func usar_pilula_nanicolina():
	if Global.pegou_pilula_nanicolina:
		if Global.ativar_pilula == false:
			if !pode_crescer:
				player.scale = Vector2(1, 1)
				Global.ativar_pilula = true
		elif Global.ativar_pilula:
			player.scale = Vector2(0.3, 0.3)
			Global.ativar_pilula = false
