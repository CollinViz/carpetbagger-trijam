extends Node

class_name StatsSystem

#export(global.AffinityTypes) var Affinity = global.AffinityTypes.EARTH
export var HP:=1
export var MaxHP:=1
export var Base_speed:=150
export var Run_speed:=150
export var Type_of_Entity:=0
export var NumCoins:=10
export var Armor:=0
export var TimeMod:=0.0 # big numb go fast
export var UpdateBaseAI:=0.8
export var Base_damage:=1
export var Agro:=5  #lower number more angry
export var jump_force:float = 30.0
export var gravity:float = 50.0
export var rotation_speed:float = 10
export var Momentum_TweenTime:float = 1
export(float) var ArriveDistance = 1
export var StandAttackoffset:float = 1.5 #used for postion data 
export var StandDefenceOffset:float = 1.5 #used for postion data 
export var is_player_Target:=false 
export var is_blocking:=false 
export var steering_factor:=1.0
export var reload_time:=1.0 
signal Death
signal Hit(Damage)

var ResetDamage ={}
var max_Affinity_last_hit:=-1
var Damage=0
func reset_resetance():
	ResetDamage ={}

func add_resetance(type:int,Value):
	if ResetDamage.has(type):
		ResetDamage[type]+=Value
	else:
		ResetDamage[type]=Value

func get_resetance(type:int):
	if ResetDamage.has(type):
		return ResetDamage[type]
	return 0

func add_Armor(NumArmor:int):
	Armor+=NumArmor

func take_damage(Damage:int,Affects:Array,_DamageBy:Node):
	#HP-=Damage
	var d = 0.0
	var max_dmg = Damage 
	print( "Got Damage ")
#	for x in Affects.size():
#		if Affects[x].has_method("apply_affect"):
#			Affects[x].apply_affect(self)
#		if Affects[x].has_method("get_damage"):			
#			var Mutiplier = LevelHand.get_Affinity(Affinity,Affects[x].Affinity)
#			var newDamageOfType = (Affects[x].get_damage() * Mutiplier)
#			if ResetDamage.has(Affects[x].Affinity):
#				newDamageOfType = newDamageOfType - (newDamageOfType * ResetDamage[Affects[x].Affinity])
#				if newDamageOfType>=0.25 and newDamageOfType<=0.4:
#					newDamageOfType = 1
#				if newDamageOfType<=0:
#					newDamageOfType = 0
#			d+=newDamageOfType
#		if max_dmg<d:
#			max_dmg = d
#			max_Affinity_last_hit=Affects[x].Affinity
	
	d = max_dmg - Armor
	if d<0:
		d=0

	HP-= int(d)
	if HP <=0:
		emit_signal("Death")
	else:
		emit_signal("Hit",int(d))


func get_Base_speed()->int:
	var b = Base_speed

	if TimeMod >0: #move faster
		b+=b*TimeMod
	if TimeMod<0:
		b-=b*TimeMod
	
	if b<0:
		b=0

	return b


func get_time_value(InputTime:float)->float:
	var t = InputTime
	if TimeMod >0: #move faster
		t-=t*TimeMod
	if TimeMod<0:
		t+=t*TimeMod
	
	if t<0.2:
		t=0.2

	return t


func current_most_Affinity_damage()->int:
	return max_Affinity_last_hit

func get_damage()->int:
	Damage = Base_damage
	return Damage
