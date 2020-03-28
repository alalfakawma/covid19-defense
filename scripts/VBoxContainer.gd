extends VBoxContainer

func _ready():
    var bg = self.get_parent().get_node("Background").rect_size
    var center = (bg / 2)

    # Offset the position with the container height
    var vboxVec = self.rect_size - (self.rect_size / 2)
    vboxVec.y -= 50
    self.set_position(center - vboxVec)
    pass
