extends Node2D

onready var musicOnPressed = preload("res://assets/gui_buttons/music/music_on_pressed.png")
onready var musicOnUnpressed = preload("res://assets/gui_buttons/music/music_on_unpressed.png")
onready var musicOffPressed = preload("res://assets/gui_buttons/music/music_off_pressed.png")
onready var musicOffUnpressed = preload("res://assets/gui_buttons/music/music_off_unpressed.png")

func _ready():
    if find_parent("GameUI"):
        # in-game
        $MainLayout/Background.modulate.a = 0.9
        $MainLayout/SceneBackButton.connect("pressed", self, "_s_b_pressed")
        $MainMenu.visible = true
        $MainMenu.connect("pressed", self, "_m_pressed")
    
    if !Game.musicOn:
        $VBoxContainer/MusicButton.texture_normal = musicOffUnpressed
        $VBoxContainer/MusicButton.texture_pressed = musicOffPressed

func _on_MusicButton_pressed():
    if Game.musicOn:
        Game.musicOn = false
        $VBoxContainer/MusicButton.texture_normal = musicOffUnpressed
        $VBoxContainer/MusicButton.texture_pressed = musicOffPressed
    else:
        Game.musicOn = true
        $VBoxContainer/MusicButton.texture_normal = musicOnUnpressed
        $VBoxContainer/MusicButton.texture_pressed = musicOnPressed

func _s_b_pressed():
    if get_parent().name == "GameUI":
        get_tree().paused = false
        queue_free()

func _m_pressed():
    get_tree().paused = false
    Game.change_scene("res://scenes/MainMenu.tscn")
