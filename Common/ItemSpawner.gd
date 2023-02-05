extends Node2D
 
const MIN_X =  10.0
const MAX_X = 25
const MIN_Y = -10.0
const MAX_Y =  40.0

func _ready():
	randomize()
	#WorldSytem.FrezTime()
#(PackedScene)
func createItems(ItemsList:Array): 
	var coins = []

	for i in ItemsList:
		var itm = i.instance()
		itm.position = Vector2.ZERO
		add_child(itm)
		coins.append(itm)

	var tween = Tween.new()
	add_child(tween)

	for coin in coins:
		var direction = 1 if randi() % 2 == 0 else -1
		var goal = coin.position + Vector2(rand_range(MIN_X, MAX_X), rand_range(MIN_Y, MAX_Y)) * direction

		tween.interpolate_property(coin, "position:x", null, goal.x, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.interpolate_property(coin, "position:y", null, goal.y - 50, 0.2, Tween.TRANS_QUAD, Tween.EASE_OUT)
		tween.interpolate_property(coin, "position:y", goal.y - 50, goal.y, 0.1, Tween.TRANS_QUAD, Tween.EASE_IN, 0.1)
		tween.interpolate_property(coin, "position:y", goal.y, goal.y - 10, 0.1, Tween.TRANS_QUAD, Tween.EASE_IN, 0.2)
		tween.interpolate_property(coin, "position:y", goal.y - 10, goal.y, 0.1, Tween.TRANS_QUAD, Tween.EASE_IN, 0.3)
		tween.interpolate_property(coin, "position:y", goal.y, 0, 0.3, Tween.TRANS_QUAD, Tween.EASE_IN,0.2)
		tween.interpolate_property(coin, "position:x", goal.x, 0, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN,0.2)
	
	tween.connect("tween_all_completed",self,"TweenDone")
	
	tween.start()

func _process(delta):
	pass

func TweenDone():
	#print("Unfrezz")
	#WorldSytem.unFrezTime()
	queue_free()

func _on_Timer_timeout():
	queue_free()
