extends TextureButton

func _pressed():
    AudioManager.playAudio("buttonClick")
    if not find_parent("GameUI"):
        Game.previous_scene()
