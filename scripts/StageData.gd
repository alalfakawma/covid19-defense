extends VBoxContainer

onready var tween = get_parent().get_node("Tween")
onready var buttons = [$Content/HBoxContainer/Back, $Content/HBoxContainer/Start]

func _set_data(data):
	tween.interpolate_property(self, "modulate:a", self.modulate.a, 1, Game.guiTweenDuration, Tween.TRANS_BACK)
	tween.interpolate_callback(self, 0.25, "_tween_done", false, false)
	tween.start()
	$Content/Name.text = data.name
	$Content/Description.text = data.description

func _destroy_data():
	tween.interpolate_property(self, "modulate:a", self.modulate.a, 0, Game.guiTweenDuration, Tween.TRANS_BACK)
	tween.interpolate_callback(self, 0.25, "_tween_done", true, true)
	tween.start()
	pass

func _tween_done(disable, clearText):
	if clearText:
		$Content/Name.text = ""
		$Content/Description.text = ""
	for b in buttons:
		if disable:
			b.disabled = true
		else:
			b.disabled = false
