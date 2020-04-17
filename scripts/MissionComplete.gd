extends Node2D

func _next_mission():
    Game.currentMission += 1
    get_tree().change_scene("res://scenes/Game.tscn")

func _main_menu():
    get_tree().change_scene("res://scenes/MainMenu.tscn")
