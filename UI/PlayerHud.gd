extends CanvasLayer

export var numToCheck:=0

onready var _num_box: Label = $Control/GameStats/HBoxContainer/NumBox
onready var _game_stats: Panel = $Control/GameStats
onready var _won: CenterContainer = $Control/Won
onready var _faild: CenterContainer = $Control/Faild
onready var _next_stange: Timer = $Control/Won/NextStange
onready var _next_leaver_loading: ProgressBar = $Control/Won/Restart/VBoxContainer/nextLeaverLoading


func _process(delta: float) -> void:
	if _won.visible && !_next_stange.is_stopped():
		_next_leaver_loading.value = _next_stange.wait_time-_next_stange.time_left
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_won.visible = false
	_faild.visible = false
	_game_stats.visible = true


func set_box_count(NumBox:int):
	_num_box.text = "%03d" % NumBox
	
func show_faild():
	GameManger.los()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	_won.visible = false
	_faild.visible = true
	_game_stats.visible = true

func show_won():
	GameManger.wone()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	_next_leaver_loading.max_value = _next_stange.wait_time
	_next_stange.start()
	_won.visible = true
	_faild.visible = false
	_game_stats.visible = true


func _on_NextStange_timeout() -> void:
	if GameData.is_next_level():
		GameData.load_next_level()
	else:
		GameData.MainMenu()


func _on_MainMenu_pressed() -> void:
	GameData.MainMenu()


func _on_Faild_gui_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.scancode == KEY_R:
			GameData.reload_level()
