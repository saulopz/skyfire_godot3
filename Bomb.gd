extends KinematicBody2D

var speed = 200

func _ready():
	$SoundBomb.play()

func _process(delta):
	var info = move_and_collide(Vector2(0, -speed) * delta)
	if info:
		var obj = info.get_collider()
		if 'Enemy' in obj.name:
			obj.kill()
			queue_free()
			get_parent().change_score(1)
	if position.y < 0:
		queue_free()
