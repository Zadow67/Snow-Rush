extends Area2D
@onready var timer: Timer = $Timer
@onready var hearts_container: HBoxContainer = %HeartsContainer



func _on_body_entered(body):
	hearts_container.setMaxHeart(0)
	print("You Died!")
	timer.start()


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
