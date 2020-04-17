extends Node2D

signal spawn_wave

var bullet = load("res://scenes/Bullet.tscn")
var waveCountdown = load("res://scenes/WaveCountdown.tscn")

enum state { GAME, PAUSE_MENU, PLACE, TOWER_SELECT }
var currentState = state.GAME setget set_state
var currentWave = 0
var mission = 0
var missionData
var selectedTower setget set_selected_tower

onready var t_Select = preload("res://scenes/TowerSelect.tscn")

func _ready():
    Game.navPath = $VirusPath.get_simple_path($VirusSpawner.position, $EndPosition.position)
    missionData = Game.currentStageData.missions[mission]
    
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
            $PlacementTileRects.visible = false
            $TowerSelect.visible = false
        state.PLACE:
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
    # Restart the wave timer, but increment the currentWave
    currentWave += 1
    waveSpawnCountdown(missionData.waveDelay, (currentWave + 1))
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
        self.currentState = state.GAME
        # Add the tower
        selectedTower.position = Vector2((rect.rect_position.x + 16), (rect.rect_position.y + 16))
        selectedTower.connect("shoot", self, "_tower_shoot")
        add_child(selectedTower)

func _tower_shoot(pos, dir, sprite, damage):
    var b = bullet.instance()
    b.start(pos, dir, damage)
    b.scale = Vector2(0.6, 0.6)
    b.get_node("Sprite").texture = sprite
    b.get_node("CollisionShape2D").shape.extents.x = sprite.get_width()
    add_child(b)

func waveSpawnCountdown(time, waveNum):
    var w = waveCountdown.instance()
    w.start(time, waveNum)
    add_child(w)
