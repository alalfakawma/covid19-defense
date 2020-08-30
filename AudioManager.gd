extends Node2D

func _ready():
    # Play in-game music
    $GameMusic.play()
    pass

var audioFiles = {
    buttonClick = "res://assets/sounds/ButtonSelect.ogg"
}

func playAudio(s: String):
    if Game.soundOn:
        $Player.stream = load(audioFiles[s])
        $Player.play()
