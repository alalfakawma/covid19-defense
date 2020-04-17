extends Area2D

signal shoot

export(int, "Tier 1", "Tier 2", "Tier 3") var tier = 0
export(int, "Level 1", "Level 2") var level = 0

var menu = false
var shootSpeed = 1 # Delay in seconds
var canShoot = false
var damage = 10 # Base Damage
var virusesInVision = []
var currentTarget = null

func _ready():
    if not self.menu:
        $ShootTimer.wait_time = shootSpeed
        $ShootTimer.connect("timeout", self, "_shoot")
        $ShootTimer.start()
    
    set_tower(tier, level)

func _process(delta):
    if currentTarget != null:
        # Look at the target
        $Gun.look_at(currentTarget.position)
        canShoot = true
    else:
        canShoot = false

func set_tower(t, l):
    tier = t
    level = l
    $ViewRadius.shape.radius = Game.towerData[t][l].radius
    damage = Game.towerData[t][l].damage
    shootSpeed = Game.towerData[t][l].shootSpeed
    $ShootTimer.wait_time = shootSpeed
    loadSprites()
    
func loadSprites():
    var gun = Game.towerData[tier][level].sprite.gun
    var base = Game.towerData[tier][level].sprite.base
    
    # Set the tower sprites
    $TowerBase.texture = load(base)
    $Gun.texture = load(gun)
    
func _shoot():
    if canShoot:
        var dir = Vector2(1, 0).rotated($Gun.global_rotation)
        var sprite = load(Game.towerData[tier][level].sprite.bullet)
        emit_signal("shoot", $Gun/Muzzle.global_position, dir, sprite, damage)

func _on_Tower_area_entered(area):
    # If not menu towers or bullet (means it is a virus)
    if not menu:
        if not "menu" in area and "health" in area:
            virusesInVision.push_back(area)
            currentTarget = virusesInVision.front()

func _on_Tower_area_exited(area):
     # If not menu towers or bullet (means it is a virus)
     if not menu:
        if not "menu" in area and "health" in area:
            virusesInVision.remove(virusesInVision.find(area))
            currentTarget = virusesInVision.front()
