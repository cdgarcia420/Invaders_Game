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

signal destroyed


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	player_size = $Sprite2D.get_rect().size * scale
	min_x = player_size.x / 2
	max_x = screen_size.x - player_size.x / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("shoot") and can_shoot:
		var stage_node = get_parent()
		var shot_instance = shot.instantiate()
		shot_instance.position = position
		stage_node.add_child(shot_instance)
		
		can_shoot = false
		$Timer.start()
	

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position.x = clamp(position.x, min_x, max_x)
	position.y = clamp(position.y, 0, screen_size.y)


func _on_timer_timeout():
	can_shoot = true
