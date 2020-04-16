extends Position2D

signal wave_depleted

var virus = load("res://scenes/Virus.tscn")
var activeViruses = []
var SPAWN_DELAY = 0.75 # Seconds
var spawnAmount
var virusLevel

func _ready():
    $Timer.connect('timeout', self, '_timeout')
    $Timer.wait_time = SPAWN_DELAY    

func _timeout():
    if spawnAmount <= 0:
        return $Timer.stop()
    self.spawnVirus()
    spawnAmount -= 1

func spawnVirus():
    # Spawn a virus
        var v = virus.instance()
        v.position = position
        v.level = virusLevel
        v.connect("died", self, "_v_died")
        v.connect("offscreen", self, "_v_offscreen")
        activeViruses.push_back(v)
        get_parent().add_child(v)

func _spawn_wave(waveData):
    spawnAmount = waveData.amount   
    virusLevel = int(waveData.enemyLevel - 1)
    $Timer.start()

func _v_died(v):
    removeFromActive(v)

func _v_offscreen(v):
    removeFromActive(v)
    # TODO: Inflict damage to the base when the virus crosses offscreen
        
func removeFromActive(v):
    if v in activeViruses:
        activeViruses.remove(activeViruses.find(v))
    if activeViruses.size() <= 0:
        emit_signal("wave_depleted")
