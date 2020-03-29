extends Node2D

signal set_data
signal destroy_data

enum stages { VAIRENGTE, LENGPUI }
var stageData
onready var stageNodes = [$Vairengte, $Lengpui]
var currentStage
var tweenReturnPos

func _ready():
    # Connect to StageData to set the labels
    self.connect("set_data", $StageData, "_set_data")
    self.connect("destroy_data", $StageData, "_destroy_data")
    
    var file = File.new()
    file.open("res://gamedata/levels.json", File.READ)
    stageData = JSON.parse(file.get_as_text()).result
    file.close()
    
    for n in stageNodes:
        n.connect("pressed", self, "_stage_button_pressed", [n])

func _stage_button_pressed(node):
    var id = node.stageId
    currentStage = node.stageId
    var tweenPos = $TweenPosition.position
    tweenReturnPos = stageNodes[id].get_node("Position2D").get_global_transform().origin
    $Tween.interpolate_property(stageNodes[id], "rect_position", stageNodes[id].rect_position, tweenPos, 1, Tween.TRANS_BACK)
    for n in stageNodes:
        if n.stageId != id:
            $Tween.interpolate_property(n, "visible", true, false, 1, Tween.TRANS_BACK)       
            $Tween.start()
    match id:
        stages.VAIRENGTE:
            self.emit_signal("set_data", stageData[id])
            $Tween.start()
        stages.LENGPUI:
            self.emit_signal("set_data", stageData[id])
            $Tween.start()
            


func _stage_select_back():
    var node = stageNodes[currentStage]
    $Tween.interpolate_property(node, "rect_position", node.rect_position, tweenReturnPos, 1, Tween.TRANS_BACK)
    $Tween.start()
    for n in stageNodes:
        if n.stageId != currentStage:
            $Tween.interpolate_property(n, "visible", false, true, 1, Tween.TRANS_BACK)       
            $Tween.start()
    self.emit_signal("destroy_data")
    pass
