extends Control

var stageData

func _ready():
    var file = File.new()
    file.open("res://gamedata/levels.json", File.READ)
    stageData = JSON.parse(file.get_as_text()).result
    file.close()
