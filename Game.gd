extends Node

const START_COINS = 35

onready var firstTimeScreen = load("res://scenes/FirstTimeScreen.tscn")
var stageData
var musicOn = true setget set_music
var towerData
var currentNode
var currentStageData
var sceneHistory = [2, 3]
var guiTweenDuration = 0.5
var navPath
var currentMission = 0
var playerData
var borderHealth = 10
var coins = 35
enum stages { VAIRENGTE, LENGPUI }
var filenames = {
    stageData = "user://levels.json",
    playerData = "user://playerdata.json"    
}

func _ready():
    # First create users copies of files
    if (!fileExists(filenames.playerData)):
        saveFile(filenames.playerData, JSON.print(loadFile("res://gamedata/playerdata.json")))
        playerData = loadFile(filenames.playerData)
        # Users first time
        saveFile(filenames.stageData, JSON.print(loadFile("res://gamedata/levels.json")))
        stageData = loadFile(filenames.stageData)
        
        # Ask for users name
        var fts = firstTimeScreen.instance()
        self.get_parent().get_node("MainMenu").add_child(fts)
        fts.get_node("LineEdit").connect("text_changed", self, "_name_text_changed", [fts])
        fts.get_node("Button").connect("pressed", self, "_save_name", [fts])
    else:
        # Load the files
        playerData = loadFile(filenames.playerData)
        stageData = loadFile(filenames.stageData)
        musicOn = playerData.soundOn # sound
        if playerData.name == null:
            var fts = firstTimeScreen.instance()
            self.get_parent().get_node("MainMenu").add_child(fts)
            fts.get_node("Button").connect("pressed", self, "_save_name", [fts])    
    # Tower files
    towerData = loadFile("res://gamedata/towers.json")

func change_scene(scene):
    sceneHistory.append(get_tree().current_scene.name)
    get_tree().change_scene(scene)
    
func previous_scene():
    var prevScene = sceneHistory.pop_back()
    var path = "res://scenes/%s.tscn" % prevScene
    get_tree().change_scene(path)
    pass
    
func saveFile(fn, content):
    var file = File.new()
    file.open(fn, File.WRITE)
    file.store_string(content)
    file.close()

func loadFile(fn):
    var file = File.new()
    file.open(fn, File.READ)
    var content = JSON.parse(file.get_as_text()).result
    file.close()
    return content

func fileExists(fn):
    var file = File.new()
    return file.file_exists(fn)
    
func missionComplete(m):
    stageData[stageData.find(currentStageData)].missions[m].completed = true
    saveFile(filenames.stageData, JSON.print(stageData))
    
func missionFailed(m):
    print(stageData[stageData.find(currentStageData)].missions[m])
    change_scene("res://scenes/MissionFailed.tscn")
    
func missionRetry():
    coins = Game.START_COINS
    change_scene("res://scenes/Game.tscn")
    
func stageComplete():
    stageData[stageData.find(currentStageData)].completed = true
    saveFile(filenames.stageData, JSON.print(stageData))
    
func _save_name(fts):
    var name = fts.get_node("LineEdit").get_text()
    if name != "":
        playerData.name = name
        saveFile(filenames.playerData, JSON.print(playerData))
        fts.queue_free()

func set_music(v):
    musicOn = v
    playerData.soundOn = musicOn
    saveFile(filenames.playerData, JSON.print(playerData))
