extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Button_Exit.grab_focus()
	text_check()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func text_check():
	match Globals.music_on:
		false:
			$VBoxContainer/Button_MusicToggle.set_text("Music off")
		true:
			$VBoxContainer/Button_MusicToggle.set_text("Music on")
	
	match Globals.sfx_on:
		false:
			$VBoxContainer/Button_SFXToggle.set_text("Sound effects off")
		true:
			$VBoxContainer/Button_SFXToggle.set_text("Sound effects on")
	
	$VBoxContainer/HBoxContainer/SpinBox.value = Globals.level_Num

func _on_button_exit_pressed():
	get_tree().change_scene_to_file("res://Views/Main_Menu.tscn")


func _on_button_info_pressed():
	get_tree().change_scene_to_file("res://Views/CreditsInfo.tscn")


func _on_button_music_toggle_pressed():
	Globals.music_on = !Globals.music_on
	text_check()


func _on_button_sfx_toggle_pressed():
	Globals.sfx_on = !Globals.sfx_on
	text_check()


func _on_spin_box_value_changed(value):
	Globals.level_Num = value
