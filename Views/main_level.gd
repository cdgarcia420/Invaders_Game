extends Node2D
var special_enemy = preload("res://Objects/special_enemy.tscn")
var enemy_Y_Array = []
var Alien_Arr

var score = 0 + Globals.score
var done = false

var stream_win = preload("res://Assets/sound/LEVEL WIN.ogg")
var stream_lose = preload("res://Assets/sound/LEVEL LOSE.ogg")

signal level_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.music_on:
		$MainLevelMusic.play()
	
	$HUD/Score.set_text("Score    %s" % score)
	$HUD/Level.set_text("Level      %s" % (Globals.level_Num + 1))
#	$HUD/Lives.set_text("Lives %s" % lives)
	
	if Globals.level_Num >= 10:
		$Barriers.set_visible(false)
		$Barriers.clear()
	
#	var Alien_A = load("res://Scripts/Enemies/Alien.gd").new()
#	Globals.level_Num += 1
	
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
func _process(_delta):
	if $Army.get_child_count() == 0 and done == false:
		level_finished.emit()
		done = true


func _on_player_destroyed():
	$MainLevelMusic.stop()
	$MainLevelResultSound.set_stream(stream_lose)
	if Globals.music_on:
		$MainLevelResultSound.play()
	$ResultsScreen/HBoxContainer/Restart.grab_focus()
	$ResultsScreen.show()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Views/Main_Menu.tscn")


func _on_restart_pressed():
	get_tree().change_scene_to_file("res://Views/main_level.tscn")

func _on_killed():
	score += 1
	$HUD/Score.set_text("Score    %s" % score)

func _on_special_killed():
	score += 3
	$HUD/Score.set_text("Score    %s" % score)

func _on_special_enemy_timer_timeout():
#	var stage_node = get_parent()
	var special_instance = special_enemy.instantiate()
	special_instance.position = $SpecialEnemySpawn.position
	add_child(special_instance)


func _on_level_finished():
	Globals.level_Num += 1
	Globals.score = score
	$MainLevelMusic.stop()
	$MainLevelResultSound.set_stream(stream_win)
	if Globals.music_on:
		$MainLevelResultSound.play()
	$special_enemy_timer.stop()
	$Player.queue_free()
	$ResultsScreen/GameOver.set_text("Level %s Complete" % Globals.level_Num)
	$ResultsScreen/HBoxContainer/Restart.set_text("Next Level")
	$ResultsScreen/HBoxContainer/Restart.grab_focus()
	$ResultsScreen.show()


func _on_death_box_area_entered(area):
	if area.is_in_group("enemy") and $Player != null and !$Player.is_queued_for_deletion():
		done = true
		$Player.queue_free()
		_on_player_destroyed()
