extends Node

var stageData
var currentNode
var currentStageData
var sceneHistory = [2, 3]
var guiTweenDuration = 0.5
enum stages { VAIRENGTE, LENGPUI }

func change_scene(scene):
    sceneHistory.append(get_tree().current_scene.name)
    get_tree().change_scene(scene)
    
func previous_scene():
    var prevScene = sceneHistory.pop_back()
    var path = "res://scenes/%s.tscn" % prevScene
    get_tree().change_scene(path)
    pass
