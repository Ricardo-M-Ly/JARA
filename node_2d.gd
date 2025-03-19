extends Node2D
# Called when the node enters the scene tree for the first time.
var ran1
var velocity = Vector2i(1,1)
var rectsx=DisplayServer.screen_get_size().x
var rectsy=DisplayServer.screen_get_size().y
func _ready() -> void:
	get_window().always_on_top=true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("hideortop"):
		if get_window().always_on_top==true:
			get_window().always_on_top=false
		else:get_window().always_on_top=true
	if Input.is_action_pressed("move"):
		var mouse_position =DisplayServer.mouse_get_position()
		get_window().position=Vector2i(mouse_position.x-50,mouse_position.y-65)
		print(mouse_position)
		$AnimatedSprite2D.play("default")
	elif ran1==0:
		$AnimatedSprite2D.play("stand")
	elif ran1==1:
		$AnimatedSprite2D.play("movee")
		get_window().position += velocity
		if get_window().position.x > 1910 or get_window().position.x < 0:
			velocity.x *= -1  # 反转 x 方向速度
		if get_window().position.y > 1070 or get_window().position.y < 0:
			velocity.y *= -1  # 反转 y 方向速度
		print(get_window().position)


func _on_timer_timeout() -> void:
	ran1=randi_range(0,1)
	print(ran1)
