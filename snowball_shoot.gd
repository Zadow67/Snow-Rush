extends Node2D

const SPEED = 200.0
var direction = 1 # Set by snowman when spawned (1 for right, -1 for left)
var distance_traveled = 0.0
const MAX_DISTANCE = 300.0 # Maximum pixels it travels before disappearing

func _process(delta: float) -> void:
	# Move the snowball horizontally
	var move_amount = SPEED * delta
	position.x += direction * move_amount
	distance_traveled += move_amount
	
	# Delete snowball if it travels beyond max distance
	if distance_traveled >= MAX_DISTANCE:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	# Ignore colliding with the snowman itself
	if "snowman" in body.name.to_lower():
		return
		
	# If it hits the player, deal damage and destroy the snowball
	if body.name == "player":
		if body.has_method("take_damage"):
			body.take_damage(1)
		elif get_tree().current_scene.has_method("take_damage"):
			get_tree().current_scene.take_damage(1)
		queue_free()
		
	# Delete if it hits solid ground/tilemap walls
	elif body is TileMap or body is StaticBody2D:
		queue_free()
