extends Node2D
var special_enemy = preload("res://Objects/special_enemy.tscn")
var enemy_Y_Array = []
var Alien_Arr



# Called when the node enters the scene tree for the first time.
func _ready():
	var Alien_A = load("res://Scripts/Enemies/Alien.gd").new()
	
	#Creates the array of enemies
#	for j in range(0,4):
#		for i in range (0,9):
#			Alien_Arr[i][j] = load("res://Scripts/Enemies/Enemy_A.tscn").instance()
#			Alien_Arr[i][j].StartPosX += i
#			Alien_Arr[i][j].StartPosY += j
#	#Instances the array of enemies
#	for k in range(0,4):
#		for l in range (0,9):
#			Alien_Arr[k][l].isDead = false
#			Alien_Arr[k][l].start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var Alien_B = load("res://Scripts/Enemies/Alien.gd").new()
	pass
