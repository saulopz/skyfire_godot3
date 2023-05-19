extends KinematicBody2D

var speed = 500
var screensize
var h
var half_w
var half_h

func _ready():
	screensize = get_viewport_rect().size
	h = $Sprite.texture.get_height()
	half_w = $Sprite.texture.get_width() / 2
	half_h = h / 2

func _process(delta):
	var vec = Vector2()
	if Input.is_action_pressed("ui_left"):
		vec.x -= speed
	elif Input.is_action_pressed("ui_right"):
		vec.x += speed
	if Input.is_action_just_pressed("ui_select"):
		get_parent().new_bomb(Vector2(position.x, position.y - half_h - 20))
	var _info = move_and_collide(vec * delta)
	position.x = clamp(position.x, half_w, screensize.x - half_w)
	if get_parent().score < 0:
		kill()

func kill():
	queue_free()
	get_parent().new_explosion(position)
	get_parent().game_over()
