extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	self.pressed.connect(on_pressed)

func on_pressed():
	get_tree().quit() 

