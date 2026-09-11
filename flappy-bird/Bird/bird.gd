extends CharacterBody2D


const JUMP_VELOCITY = -500.0 # 向上飞行时的瞬时速度
const GRAVITY = 1500         # 模拟重力加速度

const HIT = preload("res://assets/hit.wav")
const POINT = preload("res://assets/point.wav")
const WING = preload("res://assets/wing.wav")

var rot_degree = 0
var is_dead = true

@export var max_speed := 700

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var cpu_particles_2d = $CPUParticles2D
@onready var fly_sound: AudioStreamPlayer = $FlySound
@onready var score_sound: AudioStreamPlayer = $ScoreSound

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if not is_dead:
		velocity.y += GRAVITY * delta
		
		if Input.is_action_just_pressed("fly"):
			velocity.y = JUMP_VELOCITY
			fly_sound.stream = WING #<mark> 为什么在处理过程中设置为WING，而不是在一开始就设置好？
			fly_sound.play()
		
		rot_degree = clampf(-30 * velocity.y / JUMP_VELOCITY, -30, 30)
		rotation_degrees = rot_degree
		
		velocity.y = clampf(velocity.y, -max_speed, max_speed)
		move_and_slide()
