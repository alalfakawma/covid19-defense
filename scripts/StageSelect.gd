extends Node2D

signal set_data
signal destroy_data

enum stages { VAIRENGTE, LENGPUI }
var stageData
onready var stageNodes = [$Vairengte, $Lengpui]
var currentNode
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
    currentNode = node
    var tweenPos = $TweenPosition.position
    for n in stageNodes:
        n.disabled = true
        $Tween.interpolate_property(n, "rect_position", n.rect_position, tweenPos, tweenDuration, Tween.TRANS_BACK) # Move all nodes to the left
        if n.stageId != node.stageId:
            $Tween.interpolate_property(n, "modulate:a", n.modulate.a, 0, tweenDuration, Tween.TRANS_BACK) # Hide non-active nodes
            $Tween.interpolate_callback(n, 0.75, "_toggle_visible", "hide")
        tweenReturnPos.append(n.get_node("Position2D").get_global_transform().origin)
    match node.stageId:
        stages.VAIRENGTE:
            self.emit_signal("set_data", stageData[node.stageId])
            $Tween.start()
        stages.LENGPUI:
            self.emit_signal("set_data", stageData[node.stageId])
            $Tween.start()

func _stage_select_back():
    var node = currentNode
    for n in stageNodes:
        n.disabled = false
        $Tween.interpolate_property(n, "rect_position", n.rect_position, tweenReturnPos[stageNodes.find(n)], tweenDuration, Tween.TRANS_BACK)
        if n.stageId != node.stageId:
            n._toggle_visible("show")
            $Tween.interpolate_property(n, "modulate:a", n.modulate.a, 1, tweenDuration, Tween.TRANS_BACK)
    $Tween.start()
    self.emit_signal("destroy_data")
    pass
