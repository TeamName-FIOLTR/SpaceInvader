extends DefaultBullet

var time : float = 0

func _physics_process(delta):
	time += delta
	velocity = Vector3(cos(time),0,sin(time))
	super._physics_process(delta)
