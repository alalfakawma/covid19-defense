extends Node2D

func _ready():
    $HBoxContainer/NextMission.connect("pressed", self, "_next_mission")
    $HBoxContainer/MainMenu.connect("pressed", self, "_main_menu")

func _next_mission():
    AudioManager.playAudio("buttonClick")
    Game.currentMission += 1
    # Check if next mission exists
    if Game.currentMission >= Game.currentStageData.missions.size():
        $Label.text = "Select Stage"
        get_tree().change_scene("res://scenes/StageSelect.tscn")
    else:
        get_tree().change_scene("res://scenes/Game.tscn")

func _main_menu():
    AudioManager.playAudio("buttonClick")
    get_tree().change_scene("res://scenes/MainMenu.tscn")
