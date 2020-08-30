extends Node2D

func _ready():
    # Play in-game music
#    $GameMusic.stream = load(audioFiles["gameMusic"])
    $GameMusic.play()
    pass

var audioFiles = {
    buttonClick = "res://assets/sounds/ButtonSelect.ogg",
    gameMusic = "res://assets/sounds/GameMusic.wav",
    towerAttack = "res://assets/sounds/TowerAttack.wav"
}

func playAudio(s: String):
    if Game.soundOn:
        $Player.stream = load(audioFiles[s])
        $Player.play()
