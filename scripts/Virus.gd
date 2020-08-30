extends Area2D

signal died
signal offscreen

var path = []
var health = 20
var speed = 80
var damage = 10
export(int, "Level 1", "Level 2", "Level 3") var level = 0 setget set_level

func _ready():
    path = Game.navPath
    path.remove(0)
    
func _process(delta):
    var walk_distance = speed * delta
    move_along_path(walk_distance)
    
    # Emit died signal when the Virus dies from a shootout
    if health <= 0:
        queue_free()
        emit_signal("died", self)
    
    # Remove the virus if it leaves the game screen
    # TODO: Apply damage to the player's base here
    if position.x >= get_viewport_rect().size.x:
        queue_free()
        emit_signal("offscreen", self)

func move_along_path(distance):
    var last_point = position
    while path.size():
        var distance_between_points = last_point.distance_to(path[0])
        # The position to move to falls between two points.
        if distance <= distance_between_points:
            position = last_point.linear_interpolate(path[0], distance / distance_between_points)
            return
        # The position is past the end of the segment.
        distance -= distance_between_points
        last_point = path[0]
        path.remove(0)
    # The character reached the end of the path.
    position = last_point
    set_process(false)

func set_level(l):
    level = l
    match level:
        0:
            $AnimatedSprite.animation = "Level 1"
            speed = 100
            health = 30
            damage = 10
        1:
            $AnimatedSprite.animation = "Level 2"
            speed = 125
            health = 50
            damage = 12
        2:
            $AnimatedSprite.animation = "Level 3"
            speed = 145
            health = 90
            damage = 15

func take_damage(dmg):
    health -= dmg
