extends CharacterBody2D


@export var SPEED = 2000.0
const JUMP_VELOCITY = -400.0
var direction := -1

const DANO = 2

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $Area2D/Collision

var atacando: bool = false
@export var vida: int  = 5
var VIDA_MAX = vida
var is_dead: bool = false
var levando_hit: bool = false
var delay: float = 2


func _process(delta: float) -> void:
	if is_dead:
		queue_free()
	animate()
	darHit(delta)

		
func darHit(delta):
	if $Area2D.get_overlapping_bodies():
		delay -= delta
		print(delay)
		if delay <= 0:
			delay = 2
			if $Area2D.get_overlapping_bodies().size() > 0:
				var primeiro_elemento = $Area2D.get_overlapping_bodies()[0]
				print(">>>>>>>>>>>>> "+primeiro_elemento.name)  # Imprime o nome do primeiro corpo que está colidindo
				primeiro_elemento.take_damage(DANO)
		
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	mover(delta)
		

	move_and_slide()


# Verifica se algum objeto entrou na Area2D 
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("verdade")
		atacando = true
		#sprite_2d.play("jump")
		body.take_damage(DANO)
		


func mover(delta):
	if ray_cast_2d.is_colliding():
		direction *= -1
		ray_cast_2d.scale.x *= 1
		scale.x *= -1

	velocity.x = direction * SPEED * delta


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("falso")
		atacando = false


func _on_sprite_2d_animation_finished() -> void:
	if is_dead:
		queue_free()
		return;
	if $Sprite2D.animation == "hit":
		levando_hit = false
		sprite_2d.play("jump")
		
func take_damage(amount: int):
	print("levou dano o inimigo")
	print(amount)
	print(vida)
	print(">>>>>> ", Global.vida_player)
	if is_dead:
		return
	vida -= amount
	if vida <= 0:
		die()
	else:
		levando_hit = true
		
func die():
	is_dead = true
	velocity = Vector2.ZERO
	
	
func animate():
	if levando_hit:
		sprite_2d.play("hit")
