extends Node2D

enum Levels { LEVEL1, LEVEL2, LEVEL3 }
onready var buttons = []

func _ready():
    createStageButtons()
    $MainLayout/Title.text = Game.currentStageData.name

func _levelButtonPressed(btn):
    Game.coins = Game.START_COINS
    AudioManager.playAudio("buttonClick")
    
    match buttons.find(btn):
        Levels.LEVEL1:
            Game.change_scene("res://scenes/stages/%s/Level-1.tscn" % Game.currentStageData.name.to_lower())
        Levels.LEVEL2:
            print("Level 2")
        Levels.LEVEL3:
            print("Level 3")

func createStageButtons():
    for i in range(Game.currentStageData.missions.size()):
        var level = Game.currentStageData.missions[i]
        var b = TextureButton.new()
        b.texture_normal = load("res://assets/gui_buttons/level_select/level%d/level%d_unpressed.png" % [(i + 1),(i + 1)])
        b.texture_pressed = load("res://assets/gui_buttons/level_select/level%d/level%d_pressed.png" % [(i + 1),(i + 1)])
        b.connect("pressed", self, "_levelButtonPressed", [b])
        buttons.push_back(b)
        if i != 0:
            b.disabled = true
            if Game.currentStageData.missions[i - 1].completed:
                b.disabled = false
        $HBoxContainer.add_child(b)
