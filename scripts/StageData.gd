extends VBoxContainer

func _set_data(data):
    self.visible = true
    $Name.text = data.name
    $Description.text = data.description

func _destroy_data():
    self.visible = false
    $Name.text = ""
    $Description.text = ""
