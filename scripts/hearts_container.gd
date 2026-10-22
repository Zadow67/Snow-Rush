extends HBoxContainer
@onready var heartguiClass = preload("res://scenes/heartgui.tscn")

func setMaxHeart(max: int):
	for child in get_children():
		child.queue_free()
	
	for i in range(max):
		var heart = heartguiClass.instantiate()
		add_child(heart)
