extends "res://Common/Level/BaseGameData.gd"


onready var key: AudioStreamPlayer = $key
onready var gold: AudioStreamPlayer = $Coin
onready var gem: AudioStreamPlayer = $gem 
onready var win: AudioStreamPlayer = $win 





signal gold_add(total)
signal gem_add(total)
signal key_add(total)


var Total_gold:int=0
var Total_gem:int=0
var Total_key:int=0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func player_dide():
	 
	_currentPlayer.global_translation = last_checkPoint
	print("Player Dead")
	emit_signal("player_dead")
	
	#restartleve
	
func level_complete_next():
	win.play()
	
func Level_start_int():
	Total_gold =0
	Total_gem =0
	Total_key =0 

func add_gold(num:int):
	Total_gold+=num
	emit_signal("gold_add",Total_gold)
	gold.play()	
	
func add_gem(num:int):
	Total_gem+=num
	emit_signal("gem_add",Total_gem)
	gem.play()
	
func add_key(num:int):
	Total_key+=num
	emit_signal("key_add",Total_key)
	key.play()
