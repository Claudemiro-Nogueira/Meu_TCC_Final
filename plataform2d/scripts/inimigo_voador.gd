extends CharacterBody2D

@onready var player: CharacterBody2D = $"../player"
@onready var character_body_2d: CharacterBody2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $collision
@export var jogador: Node2D  # arraste o nó do jogador no Inspetor


const VIDA_MAX = 5
const DANO = 3
var atacando: bool = false
var vida: int  = VIDA_MAX
var is_dead: bool = false
var levando_hit: bool = false
var delay: float = 2

const SPEED = 100.0
var limite_superior = -60
var limite_inferior = 60
var start_position := Vector2.ZERO
var direction = 1

func _ready() -> void:
	start_position = position
	
func _process(_delta: float) -> void:
	if is_dead:
		return
		
	if jogador.global_position.x < global_position.x:
		animated_sprite_2d.flip_h = true  # Vira para a esquerda
	else:
		animated_sprite_2d.flip_h = false  # Vira para a direita

	animate()
	
func _physics_process(delta: float) -> void:

	if is_dead:
		velocity.y += delta * 1000
		move_and_slide()
		return
	
	position.y += SPEED * direction * delta
	
	var offset_y = position.y - start_position.y
	
	if offset_y > limite_inferior:
		direction = -1
	elif offset_y < limite_superior:
		direction = 1

	move_and_slide()


		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_dead:
		return
	if body.is_in_group("player"):
		body.take_damage(DANO)
	pass # Replace with function body.



func take_damage(amount: int):
	if is_dead:
		return
	vida -= amount
	if vida <= 0:
		die()
	else:
		levando_hit = true


func die():
	is_dead = true
	collision.position.y = 11
	animated_sprite_2d.play("death")
	
	
func animate():
	if levando_hit:
		animated_sprite_2d.play("hit")

		
func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "hit":
		levando_hit = false
		animated_sprite_2d.play("fly")
