extends CharacterBody3D

@export 
var projectile : PackedScene 
@export 
var projectile_speed : float = 10.0

@export
var speed = 5.0


var rotation_target : float = 0.0

var can_shoot : bool = true
func reset_can_shoot():
	can_shoot = true 


func _ready():
	tip_angle(Vector3(1,0,0))
	$shoot_cooldown.timeout.connect(reset_can_shoot)

#sigmoid squishification function
func sig(x):
	var ex = exp(x)
	return ex/(1+ex)

func shoot()->void:
	if can_shoot:
		var proj = projectile.instantiate()
		proj.velocity = global_transform.basis*Vector3(1,0,0).normalized()*10.0
		add_sibling(proj)
		proj.global_transform = $fire_location.global_transform 
		can_shoot = false

		$shoot_cooldown.start()
	
func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

#returns the ange necessary for tiping given a velocity
func tip_angle(vel : Vector3)->float:
	print(transform.basis.inverse()*velocity)
	return (sig((transform.basis.inverse()*velocity)[2]) - 0.5)/2
func die():
	get_tree().change_scene_to_file("res://scenes/UI/exit/exit.tscn")

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
