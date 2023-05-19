extends Node2D

var speed = 100
var screensize
var h
var half_h

func _ready():
	screensize = get_viewport_rect().size
	h = $A.texture.get_height()
	half_h = h / 2 

func _process(delta):
	$A.position.y += speed * delta
	$B.position.y += speed * delta
	if $A.position.y - half_h > screensize.y:
		$A.position.y -= h * 2
	if $B.position.y - half_h > screensize.y:
		$B.position.y -= h * 2
