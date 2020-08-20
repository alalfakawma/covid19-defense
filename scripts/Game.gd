extends Node2D

signal spawn_wave

var bullet = preload("res://scenes/Bullet.tscn")
var waveCountdown = preload("res://scenes/WaveCountdown.tscn")

var wcd
enum state { GAME, PAUSE_MENU, PLACE, TOWER_SELECT }
var currentState = state.GAME setget set_state
var currentWave = 0 setget set_wave
onready var mission = Game.currentMission setget set_mission
var missionData
var selectedTower setget set_selected_tower

onready var t_Select = preload("res://scenes/TowerSelect.tscn")

func _ready():
    Game.navPath = $VirusPath.get_simple_path($VirusSpawner.position, $EndPosition.position)
    missionData = Game.currentStageData.missions[mission]
    
    Game.borderHealth = missionData.baseHealth
    
    $WaveTimer.connect("timeout", self, "_wt_timeout")
    $WaveTimer.wait_time = missionData.waveDelay
    waveSpawnCountdown(missionData.waveDelay, (currentWave + 1))
    $WaveTimer.start()
    
    self.connect("spawn_wave", $VirusSpawner, "_spawn_wave")
    $VirusSpawner.connect("wave_depleted", self, "_wave_depleted")
    
    # Add rects to the PlacementTile cells
    addPlacementTileRects()

func set_state(s):
    currentState = s
    match currentState:
        state.GAME:
            $GameUI/NonPlaceRender.visible = true
            $GameUI/Cancel.visible = false
            if wcd: wcd.visible = true
            $PlacementTileRects.visible = false
            $TowerSelect.visible = false
        state.PLACE:
            $GameUI/NonPlaceRender.visible = false
            $GameUI/Cancel.visible = true
            if wcd: wcd.visible = false
            $TowerSelect.visible = false
            $PlacementTileRects.visible = true
        state.TOWER_SELECT:
            $TowerSelect.visible = true    
            $PlacementTileRects.visible = false     

func _wt_timeout():
    emit_signal("spawn_wave", missionData.waves[currentWave])
    $WaveTimer.stop()

func set_selected_tower(t):
    selectedTower = t
    # Selected Tower logic goes here, in case there is any

func _wave_depleted():
    # Restart the wave timer, increment the currentWave
    currentWave += 1
    # Check if the currentWave var has surpassed the max wave for the current mission
    # This will determine whether or not the user has completed the mission or not
    if currentWave >= missionData.waves.size():
        # Mission is complete
        Game.missionComplete(mission)
        get_tree().change_scene("res://scenes/MissionComplete.tscn")
    waveSpawnCountdown(missionData.waveDelay, (currentWave + 1))
    
    # Enable the nextwave button
    $GameUI/NonPlaceRender/NextWaveButton.disabled = false
    
    if currentWave <= (missionData.waves.size() - 1):
        $WaveTimer.start()

func addPlacementTileRects():
    var cells = $PlacementTile.get_used_cells()
    for i in range(cells.size()):
        var pos = $PlacementTile.map_to_world(cells[i])
        var rect = TextureRect.new()
        rect.rect_scale = Vector2(0.5, 0.5)
        rect.rect_position = pos
        rect.texture = load("res://assets/towers/tower_placement.png")
        rect.connect("gui_input", self, "_gui_input", [rect])
        $PlacementTileRects.add_child(rect)
        
func _gui_input(event, rect):
    if event.is_action_pressed("touch"):
        rect.modulate.a = 0.8
    elif event.is_action_released("touch"):
        $GameUI/NonPlaceRender.visible = true
        if wcd: wcd.visible = true
        $GameUI/Cancel.visible = false
        self.currentState = state.GAME
        for ptr in $PlacementTileRects.get_children():
            if ptr.rect_position == rect.rect_position:
                ptr.queue_free()
        # Add the tower
        selectedTower.position = Vector2((rect.rect_position.x + 16), (rect.rect_position.y + 16))
        selectedTower.connect("shoot", self, "_tower_shoot")
        selectedTower.get_node("Click").visible = true
        Game.coins -= selectedTower.price
        $Towers.add_child(selectedTower)
        get_tree().paused = false

func _tower_shoot(pos, dir, sprite, damage):
    var b = bullet.instance()
    b.start(pos, dir, damage)
    b.scale = Vector2(0.6, 0.6)
    b.get_node("Sprite").texture = sprite
    b.get_node("CollisionShape2D").shape.extents.x = sprite.get_width()
    add_child(b)

func waveSpawnCountdown(time, waveNum):
    wcd = waveCountdown.instance()
    var ypos = $VirusSpawner.position.y
    var wh = wcd.get_node("Container").rect_size.y
    wcd.position = Vector2(0, (ypos - (wh / 2)) - 2)
    wcd.start(time, waveNum)
    add_child(wcd)

func set_mission(m):
    if m >= (Game.currentStageData.missions.size() - 1):
        # All missions done
        Game.stageComplete()
        mission = (Game.currentStageData.missions.size() - 1)
    else:
        mission = m

func set_wave(w):
    currentWave = w
    
