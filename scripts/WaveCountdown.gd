extends Node2D

export(int) var countdown = 10
export(int) var waveNum = 1
export(String) var text = "Wave in %d"

func _ready():
    $Tween.interpolate_property(self, "modulate:a", self.modulate.a, 1, 3, Tween.TRANS_BACK, Tween.EASE_OUT)
    $Tween.start()

func start(cd_time, wave_num, text = null):
    waveNum = wave_num
    countdown = cd_time
    $Timer.wait_time = 1
    $Timer.connect("timeout", self, "_timeout")
    $Label.text = self.text % [countdown]

func _timeout():
    countdown -= 1
    if countdown <= 0:
        $Label.text = "Wave %d start!" % waveNum
        $Timer.stop()
        removeSelf()
    else:
        $Label.text = text % [countdown]
        
func removeSelf():
    $Tween.interpolate_property(self, "modulate:a", self.modulate.a, 0, 2.5, Tween.TRANS_BACK, Tween.EASE_OUT)
    $Tween.start()
    $Tween.interpolate_callback(self, 2, "queue_free")
