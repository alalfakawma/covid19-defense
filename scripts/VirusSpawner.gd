extends Position2D

var virus = load("res://scenes/Virus.tscn")

func _input(event):
    if event.is_action_released('touch'):
        # Spawn a virus
        var v = virus.instance()
        v.position = position
        get_parent().add_child(v)
