extends KinematicBody2D

const LEFT = 0
const RIGHT = 1

var screensize
var direction
var w
var h
var half_w
var half_h
var speed_y = 200
var speed_x = 300

func _ready():
	randomize()
	screensize = get_viewport_rect().size
	w = $Sprite.texture.get_width()
	h = $Sprite.texture.get_height()
	half_w = w / 2
	half_h = h / 2
	position.x = (randi() % int(screensize.x - w)) + half_w
	position.y = -100
	direction = randi() % 2
	
func _process(delta):
	var vec = Vector2()
	vec.y += speed_y
	if direction == RIGHT:
		vec.x += speed_x
		if position.x + half_w > screensize.x:
			direction = LEFT
	elif direction == LEFT:
		vec.x -= speed_x
		if position.x - half_w < 0:
			direction = RIGHT
	var info = move_and_collide(vec * delta)
	if info:
		var obj = info.get_collider()
		if 'Ship' in obj.name:
			kill()
			obj.kill()
	if position.y - half_h > screensize.y:
		get_parent().change_score(-1)
		queue_free()
	if get_parent().is_game_over:
		queue_free()

func kill():
	queue_free()
	get_parent().new_explosion(position)
