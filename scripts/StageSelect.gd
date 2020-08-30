extends Node2D

signal set_data
signal destroy_data

onready var stageNodes = [$Vairengte, $Lengpui, $Aizawl]
var tweenReturnPos = []

func _ready():
    # Connect to StageData to set the labels
    self.connect("set_data", $StageData, "_set_data")
    self.connect("destroy_data", $StageData, "_destroy_data")

    
    for n in stageNodes:
        n.connect("pressed", self, "_stage_button_pressed", [n])

func _stage_button_pressed(node):
    AudioManager.playAudio("buttonClick")
    Game.currentNode = node
    var tweenPos = $TweenPosition.position
    for n in stageNodes:
        n.disabled = true
        $Tween.interpolate_property(n, "rect_position", n.rect_position, tweenPos, Game.guiTweenDuration, Tween.TRANS_LINEAR) # Move all nodes to the left
        if n.stageId != node.stageId:
            $Tween.interpolate_property(n, "modulate:a", n.modulate.a, 0, Game.guiTweenDuration, Tween.TRANS_LINEAR) # Hide non-active nodes
            $Tween.interpolate_callback(n, 0.25, "_toggle_visible", "hide")
        tweenReturnPos.append(n.get_node("Position2D").get_global_transform().origin)
    match node.stageId:
        Game.stages.VAIRENGTE:
            self.emit_signal("set_data", Game.stageData[node.stageId])
            $Tween.start()
        Game.stages.LENGPUI:
            self.emit_signal("set_data", Game.stageData[node.stageId])
            $Tween.start()
        Game.stages.Aizawl:
            self.emit_signal("set_data", Game.stageData[node.stageId])
            $Tween.start()

func _stage_select_back():
    AudioManager.playAudio("buttonClick")
    var node = Game.currentNode
    for n in stageNodes:
        if (!Game.stageData[n.stageId].locked):
            n.disabled = false
        $Tween.interpolate_property(n, "rect_position", n.rect_position, tweenReturnPos[stageNodes.find(n)], Game.guiTweenDuration, Tween.TRANS_LINEAR)
        if n.stageId != node.stageId:
            n._toggle_visible("show")
            $Tween.interpolate_property(n, "modulate:a", n.modulate.a, 1, Game.guiTweenDuration, Tween.TRANS_LINEAR)
    $Tween.start()
    self.emit_signal("destroy_data")
    pass

func _stage_select_start():
    AudioManager.playAudio("buttonClick")
    Game.currentStageData = Game.stageData[Game.currentNode.stageId]
    Game.change_scene("res://scenes/LevelSelect.tscn")
