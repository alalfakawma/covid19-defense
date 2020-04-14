extends Node2D

enum Levels { LEVEL1, LEVEL2, LEVEL3 }
onready var buttons = [$Level1, $Level2, $Level3]

func _ready():
    # Connect Button pressed signals
    for b in buttons:
        b.connect("pressed", self, "_levelButtonPressed", [b])
    
    $MainLayout/Title.text = Game.currentStageData.name

func _levelButtonPressed(btn):
    match buttons.find(btn):
        Levels.LEVEL1:
            Game.change_scene("res://scenes/Game.tscn")
        Levels.LEVEL2:
            print("Level 2")
        Levels.LEVEL3:
            print("Level 3")
