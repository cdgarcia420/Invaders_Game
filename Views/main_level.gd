extends Node2D
var special_enemy = preload("res://Objects/special_enemy.tscn")
var enemy_Y_Array = []
var Alien_Arr



# Called when the node enters the scene tree for the first time.
func _ready():
	$MainLevelMusic.play()
	Globals.level_Num += 1
	
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
	if Input.is_action_pressed("settings"):
		get_tree().change_scene_to_file("res://Views/Main_Menu.tscn")


func _on_player_destroyed():
	$MainLevelMusic.stop()
	$DeathScreen.show()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Views/Main_Menu.tscn")


func _on_restart_pressed():
	get_tree().change_scene_to_file("res://Views/main_level.tscn")
