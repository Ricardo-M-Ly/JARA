extends Node2D
# Called when the node enters the scene tree for the first time.
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
		$AnimatedSprite2D.play("default")
	else:
		$AnimatedSprite2D.stop()
