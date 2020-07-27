extends Node2D

enum Levels { LEVEL1, LEVEL2, LEVEL3 }
onready var buttons = []

func _ready():
    createStageButtons()
    $MainLayout/Title.text = Game.currentStageData.name

func _levelButtonPressed(btn):
    Game.coins = 50
    AudioManager.playAudio("buttonClick")
    match buttons.find(btn):
        Levels.LEVEL1:
            Game.change_scene("res://scenes/Game.tscn")
        Levels.LEVEL2:
            print("Level 2")
        Levels.LEVEL3:
            print("Level 3")

func createStageButtons():
    for i in range(Game.currentStageData.missions.size()):
        var level = Game.currentStageData.missions[i]
        var b = Button.new()
        b.connect("pressed", self, "_levelButtonPressed", [b])
        buttons.push_back(b)
        b.text = "Level %d" % (i + 1)
        if i != 0:
            b.disabled = true
            if Game.currentStageData.missions[i - 1].completed:
                b.disabled = false
        $HBoxContainer.add_child(b)
