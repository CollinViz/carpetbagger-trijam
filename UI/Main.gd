extends Spatial


onready var loadLevel:Spatial = $loadLevel
onready var UILayer:Control= $UI/MainUI
onready var WinScreen:Control= $UI/WinScreen
onready var AnimTrans:AnimationPlayer = $UI/ColorRect/AnimationPlayer

var _levelIdxToLoad:=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameData.connect("loadLevel",self,"loadLevel")
	GameData.connect("MainMenu",self,"MainMenu")
	GameData.connect("Level_show",self,"Level_show")
	GameData.connect("Level_complete",self,"Level_complete")
	GameData.MainMenu()


func Level_complete():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	AnimTrans.play("StartLevelScore")

func _clearLastLevel():
	for x in loadLevel.get_children():
		x.queue_free() 
		
		
func Level_show():
	AnimTrans.play("End")
		
func MainMenu():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	WinScreen.visible = false
	AnimTrans.play("End")
	_clearLastLevel()
	UILayer.visible = true
	get_tree().paused=false

func loadLevel(indx):
	AnimTrans.play("Start") 
	_levelIdxToLoad = indx
	
func _loadLevel():
	var level:PackedScene = GameData.get_levelPacked(_levelIdxToLoad)
	_clearLastLevel()
	loadLevel.add_child(level.instance())
	UILayer.visible = false
	WinScreen.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused=false

func _ShowScore():
	AnimTrans.play("End")
	WinScreen.visible = true
	UILayer.visible = false
	WinScreen.start_counting()
	
