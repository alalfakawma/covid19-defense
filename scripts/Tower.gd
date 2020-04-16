extends Area2D

export(int, "Tier 1", "Tier 2", "Tier 3") var tier = 0
export(int, "Level 1", "Level 2") var level = 0

var menu = false
var shootSpeed = 1 # Delay in seconds
var canShoot = false
var virusesInVision = []
var currentTarget = null

func _ready():
    $ShootTimer.wait_time = shootSpeed
    
    set_tower(tier, level)

func _process(delta):
    if currentTarget != null:
        # Look at the target
        $Gun.look_at(currentTarget.position)

func set_tower(t, l):
    tier = t
    level = l
    $ViewRadius.shape.radius = Game.towerData[t][l].radius
    loadSprites()
    
func loadSprites():
    var gun = Game.towerData[tier][level].sprite.gun
    var base = Game.towerData[tier][level].sprite.base
    var bullet = Game.towerData[tier][level].sprite.bullet
    
    # Set the tower sprites
    $TowerBase.texture = load(base)
    $Gun.texture = load(gun)

func _on_Tower_area_entered(area):
    if not menu:
        if not "menu" in area:
            virusesInVision.push_back(area)
            currentTarget = virusesInVision.front()
            canShoot = true


func _on_Tower_area_exited(area):
     if not menu:
        if not "menu" in area:
            virusesInVision.remove(virusesInVision.find(area))
            currentTarget = virusesInVision.front()
            if currentTarget == null:
                canShoot = false
