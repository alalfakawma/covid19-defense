extends Node2D

signal set_data
signal destroy_data

enum stages { VAIRENGTE, LENGPUI }
var stageData
onready var stageNodes = [$VairengteNode/Vairengte, $LengpuiNode/Lengpui]
var currentStage
var tweenReturnPos = []
var tweenDuration = 1

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
    currentStage = node.stageId
    node.disabled = true # Disable node button
    node.get_parent().z_index = 2 # Set node above other nodes
    var tweenPos = $TweenPosition.position
    for n in stageNodes:
        $Tween.interpolate_property(n, "rect_position", n.rect_position, tweenPos, tweenDuration, Tween.TRANS_BACK) # Move all nodes to the left
        tweenReturnPos.append(n.get_node("Position2D").get_global_transform().origin)
    match node.stageId:
        stages.VAIRENGTE:
            self.emit_signal("set_data", stageData[node.stageId])
            $Tween.start()
        stages.LENGPUI:
            self.emit_signal("set_data", stageData[node.stageId])
            $Tween.start()

func _stage_select_back():
    var node = stageNodes[currentStage]
    node.disabled = false # Enable mode button
    for n in stageNodes:
        $Tween.interpolate_property(n, "rect_position", n.rect_position, tweenReturnPos[stageNodes.find(n)], tweenDuration, Tween.TRANS_BACK)
        n.get_parent().z_index = 1
    $Tween.start()
    self.emit_signal("destroy_data")
    pass
