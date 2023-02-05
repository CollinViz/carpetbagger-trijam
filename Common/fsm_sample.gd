extends Node


onready var fsm:=$StateMachinePlayer 

var StateExecManager = {}
var current_target:Node=null
var current_state:String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_fsm()

func setup_fsm():
	for st in get_node("FSM").get_children():
		StateExecManager[st.name] = st
		st.PARENT = self
		st.FSM=fsm
	fsm.connect("updated", self, "on_sm_update")
	fsm.connect("transited", self, "on_sm_enter")
	fsm.set_param(Global.FS_IS_ENABLED,true)

func on_sm_update(state, delta):
	StateExecManager[Global.get_StateHead(state)].update_state(Global.get_StateLast(state),delta)
	
func on_sm_enter(from, to):
#	var lab = $"%LabStats"
#	lab.text = to
	current_state = Global.get_StateHead(to)
	if StateExecManager.has(Global.get_StateHead(from)):
		StateExecManager[Global.get_StateHead(from)].exit_state(Global.get_StateLast(from))
	else:
		print("No mapping for %s " % from)
	if StateExecManager.has(Global.get_StateHead(to)):
		StateExecManager[Global.get_StateHead(to)].enter_state(Global.get_StateLast(to))
	else:
		print("No mapping for %s " % to)

