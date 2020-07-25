extends Node2D

onready var p = get_parent()
onready var settings = preload("res://scenes/Settings.tscn")

func _ready():
    $TowerButton.connect("pressed", self, "_tb_pressed")
    $NextWaveButton.connect("pressed", self, "_nwb_pressed")
    $PauseButton.connect("pressed", self, "_p_pressed")

func _tb_pressed():
    get_tree().paused = true
    p.currentState = p.state.TOWER_SELECT

func _nwb_pressed():
    p.get_node("VirusSpawner").spawnVirus()

func _p_pressed():
    get_tree().paused = true
    add_child(settings.instance())

func _process(delta):
    $HBoxContainer/BorderHealth.text = "BORDER HEALTH: %d" % Game.borderHealth
    $HBoxContainer/Coins.text = "COINS: %d" % Game.coins
