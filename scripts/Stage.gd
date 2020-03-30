extends TextureButton

export(int, "Vairengte", "Lengpui") var stageId

func _toggle_visible(toggle):
    match toggle:
        "hide":
            self.visible = false
        "show":
            self.visible = true
