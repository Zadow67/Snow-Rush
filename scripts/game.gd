extends Node2D

@onready var hearts_container: HBoxContainer = $CanvasLayer/HeartsContainer
@onready var score_ui = $UI/Score

var snow_flower_count: int = 0

var currentHealth = 5

func _ready() -> void:
	hearts_container.setMaxHeart(currentHealth)
	update_flower_ui()

func take_damage(amount):
	currentHealth -= amount
	print("Health: ", currentHealth)
	hearts_container.setMaxHeart(currentHealth)

	if currentHealth <= 0:
		print("you died")
		get_tree().reload_current_scene()


func add_snow_flower() -> void:
	snow_flower_count += 1
	print("Snow Flowers collected: ", snow_flower_count)
	update_flower_ui()

func update_flower_ui() -> void:
	if score_ui:
		score_ui.update_score(snow_flower_count)
