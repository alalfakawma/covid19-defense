extends Node2D

onready var tower = preload("res://scenes/Tower.tscn")

func _ready():
    $CloseButton.connect("pressed", self, "_close")
    
    for i in range(Game.towerData.size()):
        for j in range(Game.towerData[i].size()):
            var t = tower.instance()
            var rect = ColorRect.new()
            rect.rect_min_size = Vector2(64, 64)
            rect.color = Color(1, 1, 1, 0.1)
            t.set_tower(i, j)
            t.scale = Vector2(0.7, 0.7)
            t.menu = true
            t.position = Vector2(32, 32)
            rect.add_child(t)
            rect.connect("gui_input", self, "_gui_input", [rect, i, j])
            $HBoxContainer.add_child(rect)

func _close():
    var p = get_parent()
    p.currentState = p.state.GAME

func _gui_input(event, rect, tier, level):
    if event.is_action_pressed("touch"):
        rect.color = Color(1, 1, 1, 0.3)
    elif event.is_action_released("touch"):
        var p = get_parent()
        rect.color = Color(1, 1, 1, 0.1)
        p.currentState = p.state.PLACE
        var t = tower.instance()
        t.set_tower(tier, level)
        p.selectedTower = t
