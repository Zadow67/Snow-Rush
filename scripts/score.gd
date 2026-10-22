extends Control

@onready var label: Label = $Label

func update_score(count: int) -> void:
	label.text = str(count)
