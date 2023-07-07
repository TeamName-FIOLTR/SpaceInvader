extends CharacterBody3D

class_name DefaultBullet

@export 
var deathParticles : PackedScene

func die():
	print("calling the die function")
	var dp = deathParticles.instantiate()
	
	dp.global_transform = self.global_transform 
	get_parent().add_child(dp)

	queue_free()

func _physics_process(delta):
	print(self.velocity)
	var bz = velocity.cross(Vector3(0,1,0)).normalized()
	var bx = velocity.cross(bz).normalized()
	var new_bas = Basis()
	new_bas.x = bx 
	new_bas.y = velocity.normalized()
	new_bas.z = bz


	if new_bas.determinant() != 0:
		print("setting the transformation!")

		print(new_bas)
		self.transform.basis = new_bas
	move_and_collide(delta*velocity)
