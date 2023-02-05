extends Control


onready var time_used: Label = $"%TimeUsed"
onready var secret: Label = $"%Secret"
onready var Coins: Label = $"%Coins"
onready var Timer: Timer = $Timer


var num_coin:=0
var num_secrets:=0
var num_time:=0.0
var num_coin_up:=0
var num_secrets_up:=0
var num_time_up:=0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameData.connect("Level_complete",self,"Level_complete")


func Level_complete():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	num_coin = GameData.Total_gold
	num_secrets = GameData.Total_key
	num_time = (GameData.LevelEndTimer - GameData.LevelTimer)/100
	num_coin_up=0
	num_secrets_up=0
	num_time_up=0

func start_counting():
	Timer.start(0.3)
	

func _on_NextButton_pressed() -> void:
	GameData.load_next_level()


func _on_MainMenu_pressed() -> void:
	GameData.MainMenu()


func _on_Timer_timeout() -> void:
	var numComple = 0
	if num_coin_up<num_coin:
		num_coin_up+=1
	else:
		num_coin_up=num_coin
		numComple+=1
		
	if num_secrets_up<num_secrets:
		num_secrets_up+=1
	else:
		num_secrets_up=num_secrets
		numComple+=1
		
	if num_time_up<num_time:
		num_time_up+=100
	else:
		num_time_up = num_time
		numComple+=1
	
	var mint = int(num_time_up / 60)
	var sec = num_time_up- ( mint * 60  )
	time_used.text = "%02d:%02d  " %[mint,sec]
	
	Coins.text = "%d" % num_coin_up
	secret.text = "%d" % num_secrets_up
	if numComple>=3:
		Timer.stop()
