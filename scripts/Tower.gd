extends Area2D

export(int, "Tier 1", "Tier 2", "Tier 3") var tier = 0
export(int, "Level 1", "Level 2") var level = 0

func _ready():
    set_tower(tier, level)
    pass

func _process(delta):
    pass

func set_tower(t, l):
    tier = t
    level = l
    loadSprites()
    
func loadSprites():
    var gun = Game.towerData[tier][level].sprite.gun
    var base = Game.towerData[tier][level].sprite.base
    var bullet = Game.towerData[tier][level].sprite.bullet
    
    # Set the tower sprites
    $TowerBase.texture = load(base)
    $Gun.texture = load(gun)
