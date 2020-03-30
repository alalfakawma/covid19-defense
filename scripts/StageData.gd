extends VBoxContainer

onready var tween = get_parent().get_node("Tween")
onready var buttons = [$HBoxContainer/Back, $HBoxContainer/Start]

func _set_data(data):
    tween.interpolate_property(self, "modulate:a", self.modulate.a, 1, 1, Tween.TRANS_BACK)
    tween.interpolate_callback(self, 0.75, "_tween_done", false, false)
    tween.start()
    $Name.text = data.name
    $Description.text = data.description

func _destroy_data():
    tween.interpolate_property(self, "modulate:a", self.modulate.a, 0, 1, Tween.TRANS_BACK)
    tween.interpolate_callback(self, 0.75, "_tween_done", true, true)
    tween.start()
    pass

func _tween_done(disable, clearText):
    if clearText:
        $Name.text = ""
        $Description.text = ""
    for b in buttons:
        if disable:
            b.disabled = true
        else:
            b.disabled = false
