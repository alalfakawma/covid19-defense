extends Node2D

enum state { GAME, PLACE, MENU }
var currentState = state.GAME setget set_state

onready var t_Select = preload("res://scenes/TowerSelect.tscn")

func _ready():
    Game.navPath = $VirusPath.get_simple_path($VirusSpawner.position, $EndPosition.position)

func _input(event):
    if event.is_action_released("ui_up"):
        self.currentState = state.MENU
    elif event.is_action_released("ui_down"):
        self.currentState = state.GAME

func set_state(s):
    currentState = s
    match currentState:
        state.GAME:
            $PlacementTile.visible = false
            $TowerSelect.visible = false
        state.PLACE:
            $TowerSelect.visible = false
            $PlacementTile.visible = true
        state.MENU:
            $TowerSelect.visible = true            
