extends Area2D

var screen_size
const MOVE_SPEED = -500

signal killed
signal special_killed

signal crusher(body)

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
	if Globals.sfx_on:
		$ShootSound.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	position += Vector2(MOVE_SPEED * delta, 0.0)
	position += Vector2(0.0, MOVE_SPEED * delta)
	if position.y >= screen_size.y + 8:
		queue_free()


func _on_body_entered(body):
	if body is TileMap:
		hide()
		crusher.emit(body)
		queue_free()
#		var bullet_cell_position = body.local_to_map(to_local(position))		# WARNING MAGIC NUMBER: Used to determine position of bullet on grid
#		var data = body.get_cell_tile_data(0, bullet_cell_position)
#		if !data:
#			return
#		var atlas_coords
#		match data:
#			3:
#				data -= 1
#				atlas_coords = Vector2i(1, 0)
#			2:
#				data -= 1
#				atlas_coords = Vector2i(0, 1)
#			1:
#				data -= 1
#				atlas_coords = Vector2i(1, 1)
#			0:
#				atlas_coords = Vector2i(-1, -1)
#		body.set_cell(0, bullet_cell_position, 0, atlas_coords)
#		var tile_pos = body.map_to_local(to_local(position))
##		to_global(tile_pos)
##		tile_pos -= body.normal
#		var tile_id = body.get_cell_source_id(0, tile_pos)
##		var tile_id = 0
##		var tile_atlas = body.get_cell_atlas_coords(0, tile_pos)
##		match tile_atlas:
##			Vector2i(0, 0):
##				tile_atlas = Vector2i(1, 0)
##			Vector2i(1, 0):
##				tile_atlas = Vector2i(0, 1)
##			Vector2i(0, 1):
##				tile_atlas = Vector2i(1, 1)
#		var tile_atlas = Vector2i(1, 1)
#		body.set_cell(0, tile_pos, tile_id, tile_atlas)
#		queue_free()
#		body.collision.collider.set_cellv(tile_pos, (tile_pos + 1))
#		var tile_atlas = body.collision.collider.get_atlas


func _on_area_entered(area):
	if area.is_in_group("enemy"):
		emit_signal("killed")
		queue_free()
	elif area.is_in_group("special_enemy"):
		emit_signal("special_killed")
		queue_free()
