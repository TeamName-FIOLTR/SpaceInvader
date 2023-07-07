extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	self.pressed.connect(on_btn_pressed)
func on_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/main/main.tscn")
