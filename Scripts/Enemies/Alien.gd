extends Node2D
class_name Alien

#Status Variables
var shoot = false
var isDead = true

# Movement variables
var SPEED = 1.5
var Move_Right = true
var Move_Down = false

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

func _start():
	#If NOT DEAD, place the Alien at its starting position
	if(!isDead):
		StartPosX = position.x
		StartPosY = position.y

func _ready():
	#_animation_alien.play("default")
	pass

func _process(delta):
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
	pass
# Detects if the Alien has a shooting boolean enabled, and if so, shoots the bullet.
func _bulletTime(shoot): 
	if(shoot):
		pass
	else:
		pass
