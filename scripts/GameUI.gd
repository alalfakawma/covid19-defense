extends Node2D

onready var p = get_parent()

func _ready():
    $TowerButton.connect("pressed", self, "_tb_pressed")
    $NextWaveButton.connect("pressed", self, "_nwb_pressed")

func _tb_pressed():
    p.currentState = p.state.TOWER_SELECT

func _nwb_pressed():
    p.get_node("VirusSpawner").spawnVirus()
