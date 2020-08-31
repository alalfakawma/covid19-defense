extends Particles2D

func _ready():
    $Timer.wait_time = lifetime + 0.1
    $Timer.start()
    one_shot = true
    emitting = true

func _on_Timer_timeout():
    emitting = false
    $Timer.stop()
    queue_free()
