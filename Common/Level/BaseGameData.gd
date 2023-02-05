extends Spatial


signal EnemyCountChange(Enemy,Gohst)
signal Level_complete
signal Level_start
signal Level_show
signal player_dead
signal loadLevel(index)
signal MainMenu

signal reload_start
signal reload_end
signal reload_uiUpdate(TimeToGo)

export var current_level:=0
export(Resource) var AllLevels:Resource=null
var LevelTimer:float
var LevelEndTimer:float

func _isAllLevelVailed()->bool:
	if AllLevels == null:
		print("No Levels")
		assert(true)
		return false
	if AllLevels.allLevels.size()==0:
		print("No Levels")
		assert(true)
		return false
	return true

func get_level_name(index:int)->String:
	_isAllLevelVailed()
	if AllLevels.allLevels.size()>index:
		return AllLevels.allLevels[index].Name
	return ""

func get_all_Levels()->Array:
	_isAllLevelVailed()
	return AllLevels.allLevels

func MainMenu():
	emit_signal("MainMenu") 

func load_next_level():
	current_level+=1
	if current_level>=AllLevels.allLevels.size():
		current_level=0
	load_levele(current_level)

func reload_level():
	emit_signal("loadLevel",current_level)
	
func load_levele(index:int):
	current_level = index
	emit_signal("loadLevel",index)

func get_levelPacked(index:int)->PackedScene:
	_isAllLevelVailed()
	
	return AllLevels.allLevels[index].Level

func is_next_level()->bool:
	_isAllLevelVailed()
	return current_level<AllLevels.allLevels.size()-1



func set_last_checkpoint(GlobalPOs:Vector3):
	last_checkPoint = GlobalPOs

func set_player(newPlayer:Spatial):
	_currentPlayer = newPlayer

func ShowLevel():
	emit_signal("Level_show")
	


var _currentPlayer:Spatial=null
var last_checkPoint:Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func player_dide():
	pass

func level_complete_next():
	pass

func level_complete():
	if _currentPlayer!=null:
		_currentPlayer.call_deferred("camera_decative")
	call_deferred("level_complete_next")
	
	LevelEndTimer = OS.get_ticks_msec()
	emit_signal("Level_complete")
	
func Level_start_int():
	pass
	
func Level_start():
	Level_start_int()
	emit_signal("Level_start") 
	_start_Level_timer()
	last_checkPoint = Vector3.ZERO

func _start_Level_timer():
	LevelTimer = OS.get_ticks_msec()
