extends Control


onready var AllLeveles:VBoxContainer=$"%allLevels"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_levels()


func load_levels():
	for idx in GameData.get_all_Levels().size():
		var but:Button = Button.new()
		but.text = GameData.get_level_name(idx)
		but.connect("pressed",self,"_on_Button_pressed",[idx])
		AllLeveles.add_child(but)

func _on_Button_pressed(idex) -> void:
	GameData.load_levele(idex)
