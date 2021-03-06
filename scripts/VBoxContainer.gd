extends VBoxContainer

func _ready():
    # Center the VBoxContainer with some Y offset
    var bg = self.get_parent().get_node("Background").rect_size
    var center = (bg / 2)

    # Offset the position with the container height
    var vboxVec = self.rect_size - (self.rect_size / 2)
    vboxVec.y -= 50
    self.set_position(center - vboxVec)
    
    # Connect signals for button
    $StartButton.connect("pressed", self, "_start_button_pressed")
    $SettingsButton.connect("pressed", self, "_settings_button_pressed")
    $AboutButton.connect("pressed", self, "_about_button_pressed")
    $ExitButton.connect("pressed", self, "_exit_button_pressed")

func _start_button_pressed():
    AudioManager.playAudio("buttonClick")
    Game.change_scene("res://scenes/StageSelect.tscn")

func _settings_button_pressed():
    AudioManager.playAudio("buttonClick")
    Game.change_scene("res://scenes/Settings.tscn")

func _about_button_pressed():
    AudioManager.playAudio("buttonClick")
    Game.change_scene("res://scenes/About.tscn")
    
func _exit_button_pressed():
    get_tree().quit() # Quit the game
