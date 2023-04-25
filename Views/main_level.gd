extends Node2D
var special_enemy = preload("res://Objects/special_enemy.tscn")
var enemy_Y_Array = []
var Alien_Arr

var score = 0
var lives = 3

enum win_condition {WIN, LOSE}
var result = win_condition.LOSE

var stream_win = preload("res://Assets/sound/LEVEL WIN.ogg")
var stream_lose = preload("res://Assets/sound/LEVEL LOSE.ogg")

# Called when the node enters the scene tree for the first time.
func _ready():
	$MainLevelMusic.play()
	$HUD/Score.set_text("Score %s" % score)
#	$HUD/Lives.set_text("Lives %s" % lives)
	
	
	var Alien_A = load("res://Scripts/Enemies/Alien.gd").new()
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
	match result:
		win_condition.LOSE:
			$MainLevelResultSound.set_stream(stream_lose)
		win_condition.WIN:
			$MainLevelResultSound.set_stream(stream_win)
		_:
			$MainLevelResultSound.set_stream(stream_lose)
	$MainLevelResultSound.play()
	$ResultsScreen.show()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Views/Main_Menu.tscn")


func _on_restart_pressed():
	get_tree().change_scene_to_file("res://Views/main_level.tscn")

func _on_killed():
	score += 1
	$HUD/Score.set_text("Score %s" % score)

func _on_special_killed():
	score += 3
	$HUD/Score.set_text("Score %s" % score)

func _on_special_enemy_timer_timeout():
#	var stage_node = get_parent()
	var special_instance = special_enemy.instantiate()
	special_instance.position = $SpecialEnemySpawn.position
	add_child(special_instance)
