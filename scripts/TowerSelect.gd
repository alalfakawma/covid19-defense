extends Node2D

onready var tower = preload("res://scenes/Tower.tscn")

func _ready():
    for i in range(Game.towerData.size()):
        for j in range(Game.towerData[i].size()):
            var t = tower.instance()
            var rect = ColorRect.new()
            rect.set_size(Vector2(64, 64))
            t.tier = i
            t.level = j
            t.scale = Vector2(0.7, 0.7)
            rect.add_child(t)
            $HBoxContainer.add_child(rect)
