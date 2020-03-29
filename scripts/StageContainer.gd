extends HBoxContainer

func _ready():
    var file = File.new()
    file.open("res://gamedata/levels.json", File.READ)
    var json = JSON.parse(file.get_as_text()).result
    print(json)
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
