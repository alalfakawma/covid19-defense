extends Node2D

func _ready():
	$HBoxContainer/RetryMission.connect("pressed", self, "_retry_mission")
	$HBoxContainer/MainMenu.connect("pressed", self, "_main_menu")

func _retry_mission():
	AudioManager.playAudio("buttonClick")
	Game.missionRetry()

func _main_menu():
	AudioManager.playAudio("buttonClick")
	Game.change_scene("res://scenes/MainMenu.tscn")
