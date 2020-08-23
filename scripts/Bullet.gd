extends Area2D

export(int) var speed
export(int) var damage
export(float) var lifetime

var velocity = Vector2()

func start(_position, _direction, _damage):
	position = _position
	rotation = _direction.angle()
	velocity = _direction * speed
	damage = _damage
	$Lifetime.wait_time = lifetime

func _process(delta):
	position += velocity * delta
	
func explode():
	queue_free()

func _on_Lifetime_timeout():
	explode()

func _on_Bullet_area_entered(area):
	if area.has_method("take_damage"):
		explode()
		area.take_damage(damage)
