extends Node2D

var audioFiles = {
	buttonClick = "res://assets/sounds/ButtonSelect.ogg"
}

func playAudio(s: String):
	if Game.musicOn:
		$Player.stream = load(audioFiles[s])
		$Player.play()
