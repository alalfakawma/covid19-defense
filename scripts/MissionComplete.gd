extends Node2D

func _next_mission():
    Game.currentMission += 1
    # Check if next mission exists
    if Game.currentMission >= Game.currentStageData.missions.size():
        $Label.text = "Select Stage"
        get_tree().change_scene("res://scenes/StageSelect.tscn")
    else:
        get_tree().change_scene("res://scenes/Game.tscn")

func _main_menu():
    get_tree().change_scene("res://scenes/MainMenu.tscn")
