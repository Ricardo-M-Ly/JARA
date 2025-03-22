extends AnimatedSprite2D

var skinswicth=true
signal followmousemove
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("move"):
		if get_parent().iscontroling==false:
			followmousemove.emit()


func _on_node_2d_default(value):
	if skinswicth==true:
		if value=="default":
			play("default")
			print("真跳了？")# Replace with function body.
		if value=="stand":
			play("stand")
		if value=="movee":
			play("movee")
		
	else:
		if value=="default":
			play("swim-default")# Replace with function body.
		if value=="stand":
			play("swim-default")
		if value=="movee":
			play("swim-default")


func _on_cejianone() -> void:
	if skinswicth==true:
		skinswicth=false
		play("swim-default")
	else :
		skinswicth=true
		play("stand")
