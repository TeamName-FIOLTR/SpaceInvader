extends Node3D

var die_particlez = preload("res://scenes/objects/die_particles.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func die():
	var dp = die_particlez.instantiate()
	add_sibling(dp)
	dp.global_transform = global_transform
	queue_free()
	pass

func _on_area_3d_body_entered(body):
	die()
	if body.has_method("die"): body.die()
	pass # Replace with function body.
