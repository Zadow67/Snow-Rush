extends Control
@onready var button: Button = $VBoxContainer/Button
@onready var button_2: Button = $VBoxContainer/Button2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")



func _on_button_2_pressed() -> void:
	get_tree().quit()
