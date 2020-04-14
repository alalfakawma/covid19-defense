extends Area2D

var path = []

func _ready():
    path = Game.navPath
    path.remove(0)
    
func _process(delta):
    var walk_distance = 100 * delta
    move_along_path(walk_distance)
    
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
