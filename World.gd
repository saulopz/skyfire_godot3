extends Node2D

var Ship = preload("res://Ship.tscn")
var Bomb = preload("res://Bomb.tscn")
var Enemy = preload("res://Enemy.tscn")
var Explosion = preload("res://Explosion.tscn")
var score = 0
var is_game_over = false
var screensize

func _ready():
	screensize = get_viewport_rect().size

func _process(_delta):
	if is_game_over:
		if Input.is_action_just_pressed("ui_accept"):
			_reset()

func _reset():
	is_game_over = false
	score = 0
	$Score.text = str(score)
	var ship = Ship.instance()
	ship.position = Vector2(screensize.y - 10, screensize.x / 2)
	add_child(ship)
	$GameOver.visible = false
	$Music.play()
	$EnemyTimer.start()

func change_score(pts):
	score += pts
	$Score.text = str(score)

func game_over():
	is_game_over = true
	$GameOver.visible = true
	$Music.stop()
	$EnemyTimer.stop()

func new_explosion(pos):
	var explosion = Explosion.instance()
	explosion.position = pos
	add_child(explosion)

func new_bomb(pos):
	var bomb = Bomb.instance()
	bomb.position = pos
	add_child(bomb)

func _on_EnemyTimer_timeout():
	if is_game_over:
		return
	var enemy = Enemy.instance()
	add_child(enemy)
	$EnemyTimer.wait_time = (randi() % 2) + 1
	$EnemyTimer.start()
