extends Node2D

const SPEED = 200.0
var direction = 1
var distance_traveled = 0.0
const MAX_DISTANCE = 50

func _process(delta: float) -> void:
	var move_amount = SPEED * delta
	position.x += direction * move_amount
	distance_traveled += move_amount
	
	# Disappear after traveling max distance
	if distance_traveled >= MAX_DISTANCE:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	# Ignore colliding with the snowman itself
	if "snowman" in body.name.to_lower():
		return
		
	# Hit the player -> deal damage & delete snowball immediately!
	if body.name == "player":
		if body.has_method("take_damage"):
			body.take_damage(1)
		elif get_tree().current_scene.has_method("take_damage"):
			get_tree().current_scene.take_damage(1)
		
		queue_free() # Makes the snowball disappear!
		
	# Destroy snowball if it hits walls or floor
	elif body is TileMap or body is StaticBody2D:
		queue_free()
