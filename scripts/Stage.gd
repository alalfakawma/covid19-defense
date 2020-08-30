extends TextureButton

export(int, "Vairengte", "Lengpui", "Aizawl") var stageId

func _ready():
    get_parent().connect("ready", self, "_parent_ready")

func _toggle_visible(toggle):
    match toggle:
        "hide":
            self.visible = false
        "show":
            self.visible = true

func _parent_ready():
    if Game.stageData[stageId].locked:
        self.disabled = true
    else:
        self.disabled = false
