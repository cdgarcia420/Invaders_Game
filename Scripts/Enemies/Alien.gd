extends Node2D
class_name Alien

#Status Variables
var shoot = false
var isDead = false

# Movement variables
var SPEED = 1.5
var Move_Right = true
var Move_Down = false

# Random Variables
var timer_wait

# Movement Functions
var First_Move = true
var Max_X_Dist = 1100
var Dist_Moved = 0
var Dist_Move_Down = 10
var Start = false

# Reset Invader(s)
var StartPosX = 0
var StartPosY = 0
@onready var _animation_alien = $AnimatedSprite2D

# Scene preloads
var shot = preload("res://Objects/bullet_bad.tscn")

# Signals
signal killed

func _start():
	#If NOT DEAD, place the Alien at its starting position
	if(isDead):
		StartPosX = position.x
		StartPosY = position.y

func _ready():
	randomize()
	timer_wait = randf_range(1, 5)
	
	#_animation_alien.play("default")
	$AnimatedSprite2D.play()		# Easy way to play the animation. Changed from 5fps to 2fps to matech special enemy
	$Timer.set_wait_time(timer_wait)

func _process(delta):
	_bulletTime()
	
	if !$EnemySounds.is_playing() and isDead:
		queue_free()
	
	if(Start):
		return
	if(Move_Down):
		position.y += Dist_Move_Down
		Move_Down = false
	elif(Move_Right):
		position.x += SPEED
		Dist_Moved += SPEED
	else:
		position.x -= SPEED
		Dist_Moved += SPEED
	
	if(Dist_Moved >= Max_X_Dist):
		Move_Down = true
		Dist_Moved = 0
		Move_Right = !Move_Right
	

# Tells the Alien when to shoot; passes a boolean upon timeout
func _on_timer_timeout():
	shoot = true

# Detects if the Alien has a shooting boolean enabled, and if so, shoots the bullet.
func _bulletTime(): 
	if shoot:
		var stage_node = get_parent()
		var shot_instance = shot.instantiate()
		shot_instance.position = position
		stage_node.add_child(shot_instance)
		
		shot_instance.crusher.connect(_on_crushed.bind(shot_instance))
		
		shoot = false
		$Timer.start()

func _on_crushed(body, shot):
	var bullet_cell_position = body.local_to_map(shot.position)/2
	bullet_cell_position.y += 1
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

func _on_area_entered(area):
	if area.is_in_group("projectile"):
		emit_signal("killed")
		$EnemySounds.play()
		shoot = false
		isDead = true
		$Timer.stop()
		hide()
		
