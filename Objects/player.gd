# Resources
#	Helpful for starting off making something move while being blocked by the screen: https://docs.godotengine.org/en/stable/getting_started/first_2d_game/03.coding_the_player.html


extends Area2D

@export var speed = 400
var screen_size
var health
var player_size
var min_x
var max_x

var shot = preload("res://Objects/bullet.tscn")
var can_shoot = true
var dead = false
var stage_node

var explosion = load("res://Assets/sound/destroy.ogg")
var level_lose = load("res://Assets/sound/LEVEL LOSE.ogg")

signal destroyed



# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	player_size = $Sprite2D.get_rect().size * scale
#	print(player_size)
	min_x = player_size.x / 2
	max_x = screen_size.x - player_size.x / 2
	
	stage_node = get_parent()
	
	$Timer.wait_time -= (0.8)*float(Globals.level_Num)
	speed += (0.8)*float(Globals.level_Num)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	
	if !$PlayerSounds.is_playing() and dead:
		queue_free()
	
	if Input.is_action_pressed("move_right") and !dead:
		velocity.x += 1
	if Input.is_action_pressed("move_left") and !dead:
		velocity.x -= 1
	if Input.is_action_pressed("shoot") and can_shoot and !dead:
#		var stage_node = get_parent()
		var shot_instance = shot.instantiate()
		shot_instance.position = position
		stage_node.add_child(shot_instance)
		
		shot_instance.killed.connect(stage_node._on_killed)
		shot_instance.special_killed.connect(stage_node._on_special_killed)
		shot_instance.crusher.connect(_on_crushed.bind(shot_instance))
		
		can_shoot = false
		$Timer.start()
	

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position.x = clamp(position.x, min_x, max_x)
	position.y = clamp(position.y, 0, screen_size.y)

func _on_crushed(body, bullet):
	var bullet_cell_position = body.local_to_map(bullet.position)/2
#	var bullet_cell_position = Vector2i(18, 14)
#	var bullet_cell_position = floor(shot.position/16)
	var data = body.get_cell_tile_data(0, bullet_cell_position)
	if !data:
		return
	var crush = data.get_custom_data("Breakage")
	var atlas_coords
	match crush:
		3:
			atlas_coords = Vector2i(1, 0)
		2:
			atlas_coords = Vector2i(0, 1)
		1:
			atlas_coords = Vector2i(1, 1)
		0:
			atlas_coords = Vector2i(-1, -1)
	body.set_cell(0, bullet_cell_position, 0, atlas_coords)

func _on_timer_timeout():
	can_shoot = true


func _on_area_entered(area):
	if area.is_in_group("projectile_bad"):
		dead = true
		emit_signal("destroyed")
		hide()
#		$PlayerSounds.set_stream(explosion)
		if Globals.sfx_on:
			$PlayerSounds.play()
