extends Node

var stageData
var towerData
var currentNode
var currentStageData
var sceneHistory = [2, 3]
var guiTweenDuration = 0.5
var navPath
var currentMission = 0
enum stages { VAIRENGTE, LENGPUI }

func _ready():
    # Load the files
    # Level files
    var file = File.new()
    file.open("res://gamedata/levels.json", File.READ)
    stageData = JSON.parse(file.get_as_text()).result
    file.close()
    
    # Tower files
    file = File.new()
    file.open("res://gamedata/towers.json", File.READ)
    towerData = JSON.parse(file.get_as_text()).result
    file.close()

func change_scene(scene):
    sceneHistory.append(get_tree().current_scene.name)
    get_tree().change_scene(scene)
    
func previous_scene():
    var prevScene = sceneHistory.pop_back()
    var path = "res://scenes/%s.tscn" % prevScene
    get_tree().change_scene(path)
    pass
