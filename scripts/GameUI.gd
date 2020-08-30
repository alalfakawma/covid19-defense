extends Node2D

onready var p = get_parent()
onready var settings = preload("res://scenes/Settings.tscn")

func _ready():
    $NonPlaceRender/TowerButton.connect("pressed", self, "_tb_pressed")
    $NonPlaceRender/NextWaveButton.connect("pressed", self, "_nwb_pressed")
    $NonPlaceRender/PauseButton.connect("pressed", self, "_p_pressed")
    $Cancel.connect("pressed", self, "_p_cancel")

func _tb_pressed():
    AudioManager.playAudio("buttonClick")
    get_tree().paused = true
    p.currentState = p.state.TOWER_SELECT

func _nwb_pressed():
    AudioManager.playAudio("buttonClick")
    p.wcd.countdown = 0
    p.get_node("WaveTimer").emit_signal("timeout")
    $NonPlaceRender/NextWaveButton.disabled = true

func _p_pressed():
    AudioManager.playAudio("buttonClick")
    get_tree().paused = true
    add_child(settings.instance())

func _p_cancel():
    p.currentState = p.state.GAME
    get_tree().paused = false
    
func _process(delta):
    $NonPlaceRender/HBoxContainer/BorderHealth.text = "BORDER HEALTH: %d" % Game.borderHealth
    $NonPlaceRender/HBoxContainer/Coins.text = "COINS: %d" % Game.coins
