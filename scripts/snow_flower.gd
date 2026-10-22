extends Area2D

@onready var sfx_collect: AudioStreamPlayer = $sfx_collect

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		set_deferred("monitoring", false)
		hide()
		
		get_tree().current_scene.add_snow_flower()
		sfx_collect.play()

		await sfx_collect.finished
		queue_free()
