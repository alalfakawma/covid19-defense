extends Node2D

onready var tower = preload("res://scenes/Tower.tscn")

func _ready():
	$CloseButton.connect("pressed", self, "_close")
	
	# draw the towers
	for i in range(Game.towerData.size()):
		for j in range(Game.towerData[i].size()):
			if Game.towerData[i][j].level == 1:
				var t = tower.instance()
				var rect = ColorRect.new()
				rect.rect_min_size = Vector2(64, 64)
				rect.color = Color(1, 1, 1, 0.3)
				t.set_tower(i, j)
				t.scale = Vector2(0.7, 0.7)
				t.menu = true
				t.position = Vector2(32, 32)
				rect.add_child(t)
				rect.connect("gui_input", self, "_gui_input", [rect, i, j])
				# price label
				var l = Label.new()
				l.text = "Price: %s" % Game.towerData[i][j].price
				var rx = rect.get_rect().position.x
				var ry = rect.get_rect().position.y
				l.rect_position = Vector2(rx, ry + 64 + 20)
				l.rect_position.x = 32 - (l.rect_size.x / 2)
				rect.add_child(l)
				$HBoxContainer.add_child(rect)

func _close():
	AudioManager.playAudio("buttonClick")
	var p = get_parent()
	get_tree().paused = false
	p.currentState = p.state.GAME

func _gui_input(event, rect, tier, level):
	if Game.towerData[tier][level].price <= Game.coins:
		if event.is_action_pressed("touch"):
			rect.color = Color(1, 1, 1, 0.2)
		elif event.is_action_released("touch"):
			AudioManager.playAudio("buttonClick")
			var p = get_parent()
			rect.color = Color(1, 1, 1, 0.3)
			p.currentState = p.state.PLACE
			var t = tower.instance()
			t.set_tower(tier, level)
			p.selectedTower = t
		
func _process(delta):
	for hb in $HBoxContainer.get_children():
		var t = hb.get_children()[0]
		if t.price > Game.coins:
			hb.color = Color(1, 1, 1, 0.1)
	$Coins.text = "COINS: %d" % Game.coins
