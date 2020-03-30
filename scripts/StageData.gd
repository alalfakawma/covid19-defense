extends VBoxContainer

onready var tween = get_parent().get_node("Tween")

func _set_data(data):
    tween.interpolate_property(self, "modulate:a", self.modulate.a, 1, 1, Tween.TRANS_BACK)
    tween.start()
    $Name.text = data.name
    $Description.text = data.description

func _destroy_data():
    tween.interpolate_property(self, "modulate:a", self.modulate.a, 0, 1, Tween.TRANS_BACK)
    tween.start()
    $Name.text = ""
    $Description.text = ""
