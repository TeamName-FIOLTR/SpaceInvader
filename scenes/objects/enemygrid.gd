extends Node3D

@export var alian_speed : float = 1.0/20
@export var paththingig : Path3D
@export var grid_size : Vector2 = Vector2(10,10)
@export var alian_rows : int = 10

@export var difficulty_increase_speed : float = 0.1

var offset_array : Array = [0.0]
# Called when the node enters the scene tree for the first time.
func _ready():
	paththingig.curve = generate_curve()
	
	var child_count = paththingig.get_child_count()
	var children = paththingig.get_children()
	offset_array.resize(child_count)
	for i in range(child_count):
		children[i].progress_ratio = i/float(child_count)
		offset_array[i] = i/float(child_count)
	pass # Replace with function body.

func generate_curve():
	var n_curve = Curve3D.new()
	var row_gap = grid_size.y/alian_rows
	for i in range(alian_rows):
		n_curve.add_point(Vector3(row_gap*i,0,-grid_size.x/2.0))
		n_curve.add_point(Vector3(row_gap*i,0,grid_size.x/2.0))
		n_curve.add_point(Vector3(row_gap*(i+0.5),0,grid_size.x/2.0))
		n_curve.add_point(Vector3(row_gap*(i+0.5),0,-grid_size.x/2.0))
	return n_curve

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var children = paththingig.get_children()
	var child_count = paththingig.get_child_count()
	for i in range(child_count):
		children[i].progress_ratio = pingpong(offset_array[i],1.0)
		offset_array[i] += delta*alian_speed
#	for child in paththingig.get_children(): ## yeah idk old code ig
#		child.progress_ratio = pingpong(child.progress_ratio+delta*alian_speed, 1.0)

	if len(offset_array) > 0 and offset_array[len(offset_array)-1] > .9:
		position.x -= difficulty_increase_speed*delta
