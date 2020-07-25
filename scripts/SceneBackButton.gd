extends TextureButton

func _pressed():
    if not find_parent("GameUI"):
        Game.previous_scene()
