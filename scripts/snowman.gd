extends Node2D

@onready var sfx_shoot: AudioStreamPlayer = $sfx_shoot
@export var snowball_scene: PackedScene = preload("res://scenes/snowball_shoot.tscn")
@export var speed: float = 40.0
@export var patrol_distance: float = 40.0 # Adjust patrol length in Inspector
@export_enum("Right:1", "Left:-1") var starting_direction: int = 1 # Choose starting direction in Inspector

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D
@onready var timer: Timer = $Timer

var direction: int = 1
@onready var initial_position_x: float = position.x 
var is_player_in_range: bool = false

func _ready() -> void:
	direction = starting_direction
	scale.x = -1 if direction == -1 else 1

func _process(delta: float) -> void:
	position.x += direction * speed * delta
	
	# Patrol boundary check based on initial direction and custom patrol distance
	if direction == 1 and position.x >= initial_position_x + patrol_distance:
		direction = -1
		scale.x = -1
		position.x = initial_position_x + patrol_distance
	elif direction == -1 and position.x <= initial_position_x - patrol_distance:
		direction = 1
		scale.x = 1
		position.x = initial_position_x - patrol_distance

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		is_player_in_range = true
		get_tree().current_scene.take_damage(1)
		shoot_snowball()
		timer.start()
	print("shoot")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "player":
		is_player_in_range = false
		timer.stop()
	print("stop")

func _on_timer_timeout() -> void:
	if is_player_in_range:
		shoot_snowball()

func shoot_snowball() -> void:
	if snowball_scene:
		sfx_shoot.play()
		var snowball = snowball_scene.instantiate()
		get_parent().add_child(snowball)
		snowball.global_position = global_position
		snowball.direction = -direction
