extends CharacterBody3D

@export 
var projectile : PackedScene 
@export 
var projectile_speed : float = 10.0

@export
var speed = 5.0


var rotation_target : float = 0.0

func _ready():
	tip_angle(Vector3(1,0,0))

#sigmoid squishification function
func sig(x):
	var ex = exp(x)
	return ex/(1+ex)

func shoot()->void:
	print("im firin' my lazers!")
	var proj = projectile.instantiate()
	proj.velocity = global_transform.basis*Vector3(1,0,0).normalized()*10.0
	add_sibling(proj)
	proj.global_transform = $fire_location.global_transform 
	
func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

#returns the ange necessary for tiping given a velocity
func tip_angle(vel : Vector3)->float:
	return (sig(vel[0]) - 0.5)/2

func _physics_process(delta):
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(0, 0, input_dir.x)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed 
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)


	rotation_target = tip_angle(velocity)


	#tip based on our current velocity	
	$Center.rotation[0] = lerp($Center.rotation[0],rotation_target,5*delta)

	move_and_collide(velocity*delta)
