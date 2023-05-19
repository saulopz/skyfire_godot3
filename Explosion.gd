extends StaticBody2D

func _ready():
	$AnimatedSprite.play()
	$SoundExplosion.play()

func _on_AnimatedSprite_animation_finished():
	queue_free()
