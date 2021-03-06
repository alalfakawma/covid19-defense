extends Position2D

signal wave_depleted

var virus = load("res://scenes/Virus.tscn")
var virusDeathParticle = preload("res://scenes/Particle.tscn")

var activeViruses = []
var SPAWN_DELAY = 0.75 # Seconds
var spawnAmount
var spawnedAmount = 0
var virusLevel
var waveAmount

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
    spawnedAmount += 1
    var v = virus.instance()
    v.position = position
    v.level = virusLevel
    v.connect("died", self, "_v_died")
    v.connect("offscreen", self, "_v_offscreen")
    activeViruses.push_back(v)
    get_parent().add_child(v)

func _spawn_wave(waveData):
    self.waveAmount = waveData.amount
    spawnedAmount = 0
    spawnAmount = waveData.amount   
    virusLevel = int(waveData.enemyLevel - 1)
    $Timer.start()

func _v_died(v):
    var virusLastPos = v.position
    var deathParticle = virusDeathParticle.instance()
    deathParticle.position = virusLastPos
    get_parent().add_child(deathParticle)
    
    # do anything
    removeFromActive(v)
    # Add coins
    Game.coins += (v.level + 1) * 5

func _v_offscreen(v):
    # Deal damage to base
    var p = get_parent()
    var dmg = p.missionData.waves[p.currentWave].dmgMultiplier * v.damage
    Game.borderHealth -= dmg
    # Check if the base still has health
    if Game.borderHealth <= 0:
        Game.missionFailed(p.mission)
    removeFromActive(v)
        
func removeFromActive(v):
    if v in activeViruses:
        activeViruses.remove(activeViruses.find(v))
    if (activeViruses.size() <= 0) && (spawnedAmount >= waveAmount):
        emit_signal("wave_depleted")
