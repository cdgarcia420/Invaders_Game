extends Node2D
class_name Alien

#Status Variables

var shoot = false
var isDead = true
var init_shot = true

# Movement variables
var SPEED = 0.5
var Move_Right = true
var Move_Down = false

# Random Variables
var timer_wait

# Movement Functions
var First_Move = true
var Max_X_Dist = 600
var Dist_Moved = 0
var Dist_Move_Down = 10
var Start = false

# Reset Invader(s)
var StartPosX = 0
var StartPosY = 0

# Scene preloads
var shot = preload("res://Objects/bullet_bad.tscn")
#Create Timers For the Aliens
func init_Timer():
	randomize()
	timer_wait = randf_range(1, randf_range(2,50))


func _start():
	#If NOT DEAD, place the Alien at its starting position
	if(!isDead):
		StartPosX = position.x
		StartPosY = position.y

func _ready():
	init_Timer()
	SPEED += (3.0/8.0)*float(Globals.level_Num)
	#_animation_alien.play("default")
	$AnimatedSprite2D.play()		# Easy way to play the animation. Changed from 5fps to 2fps to match special enemy
	$Timer.set_wait_time(timer_wait)

func _process(_delta):
	_bulletTime()
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
	if init_shot:
		init_shot = false
		pass
	else:
		shoot = true

# Detects if the Alien has a shooting boolean enabled, and if so, shoots the bullet.
func _bulletTime():
	if shoot:
		var stage_node = get_parent()
		var shot_instance = shot.instantiate()
		shot_instance.position = position
		stage_node.add_child(shot_instance)
		
		shoot = false
		$Timer.start()


func _on_area_entered(area):
	if area.is_in_group("projectile"):
		$EnemySounds.play()
		shoot = false
		$Timer.stop()
		hide()
		
