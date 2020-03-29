extends TextureButton

export(int, "Vairengte", "Lengpui") var stageId

func _ready():
    pass

func _pressed():
    var p = get_parent()
    var sd = p.stageData[stageId]
    var name = sd.name
    var desc = sd.description
    $StageData/Name.text = name
    $StageData/Description.text = desc
    $StageData.visible = true
