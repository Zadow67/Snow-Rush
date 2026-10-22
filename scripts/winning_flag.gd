extends Area2D

func _on_body_entered(body: Node2D) -> void:
	# This line stops the TileMap or enemies from triggering the game over
	if body.name == "player":
		get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
