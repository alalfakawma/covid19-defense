extends Node2D

onready var soundOnPressed = preload("res://assets/gui_buttons/music/sound/soundon_pressed.png")
onready var soundOnUnpressed = preload("res://assets/gui_buttons/music/sound/soundon_unpressed.png")
onready var soundOffPressed = preload("res://assets/gui_buttons/music/sound/soundoff_pressed.png")
onready var soundOffUnpressed = preload("res://assets/gui_buttons/music/sound/soundoff_unpressed.png")

func _ready():
    if find_parent("GameUI"):
        # in-game
        $MainLayout/Background.modulate.a = 0.9
        $MainLayout/SceneBackButton.connect("pressed", self, "_s_b_pressed")
        $MainMenu.visible = true
        $MainMenu.connect("pressed", self, "_m_pressed")
    
    if !Game.soundOn:
        $VBoxContainer/SoundButton.texture_normal = soundOffUnpressed
        $VBoxContainer/SoundButton.texture_pressed = soundOffPressed

func _s_b_pressed():
    if get_parent().name == "GameUI":
        get_tree().paused = false
        queue_free()

func _m_pressed():
    AudioManager.playAudio("buttonClick")
    get_tree().paused = false
    Game.change_scene("res://scenes/MainMenu.tscn")


func _on_SoundButton_pressed():
    if Game.soundOn:
        Game.soundOn = false
        $VBoxContainer/SoundButton.texture_normal = soundOffUnpressed
        $VBoxContainer/SoundButton.texture_pressed = soundOffPressed
    else:
        Game.soundOn = true
        AudioManager.playAudio("buttonClick")        
        $VBoxContainer/SoundButton.texture_normal = soundOnUnpressed
        $VBoxContainer/SoundButton.texture_pressed = soundOnPressed


func _on_MusicButton_pressed():
    pass # Replace with function body.
