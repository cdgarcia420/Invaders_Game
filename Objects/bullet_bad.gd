extends Area2D

var screen_size
const MOVE_SPEED = 250

signal crusher(body)

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$ShootSound.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	position += Vector2(MOVE_SPEED * delta, 0.0)
	position += Vector2(0.0, MOVE_SPEED * delta)
	if position.y >= screen_size.y + 8:
		self.queue_free()


func _on_body_entered(body):
	if body is TileMap:
		hide()
		crusher.emit(body)
		queue_free()
