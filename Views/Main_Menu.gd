extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("settings"):
		get_tree().change_scene_to_file("res://Views/main_level.tscn")


func _on_button_start_game_pressed():
	get_tree().change_scene_to_file("res://Views/main_level.tscn")


func _on_button_options_pressed():
	get_tree().change_scene_to_file("res://Views/Options_Menu.tscn")


func _on_button_exit_pressed():
	get_tree().quit()
