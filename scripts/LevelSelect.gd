extends Node2D

func _ready():
    $MainLayout/Title.text = Game.currentStageData.name
    pass
