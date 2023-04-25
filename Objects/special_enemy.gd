extends Area2D

var screen_size
const MOVE_SPEED = 150

var destroyed

signal special_killed

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	position += Vector2(MOVE_SPEED * delta, 0.0)
	position += Vector2(MOVE_SPEED * delta, 0.0)
	if position.x >= screen_size.x + 16:
		queue_free()
		
	if !$EnemySounds.is_playing() and destroyed:
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("projectile"):
		emit_signal("special_killed")
		$EnemySounds.play()
		hide()
		destroyed = true
