extends Node2D
# Called when the node enters the scene tree for the first time.
var ran1
var whethermovee=true
var iscontroling=false
var switchtwice=true
var gpps:Vector2i
var gppe:Vector2i
var camerazoom
var positionstart
var imagepath
var imagee
var imagge
var velocity = Vector2i(1,1)
var rectsx=DisplayServer.screen_get_size().x
var rectsy=DisplayServer.screen_get_size().y
var normalsize
signal default
signal stand 
signal movee
signal cejianone
func _ready() -> void:
	get_window().always_on_top=true
	$Control.visible=false
	$Control/AudioStreamPlayer.play()
	normalsize=get_window().get_viewport().size
	camerazoom=$AnimatedSprite2D/Camera2D.zoom
	imagepath=OS.get_executable_path().get_base_dir()+'//jietu.png'
	imagee=Image.load_from_file(imagepath)
	$Sprite2D.visible=false
	#$Sprite2D.visible=false
	
	#$Control/AudioStreamPlayer.playing=true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move"):
		if iscontroling==false:
			positionstart=get_window().position
	if get_window().position.x<960:
		$AnimatedSprite2D.scale.x=1
	if get_window().position.x>960:
		$AnimatedSprite2D.scale.x=-1
	elif Input.is_action_just_pressed("visbutton"):
		Dontfollowmouse()
	elif Input.is_action_just_pressed("huanzhuang"):
		huanzhuang()
	elif whethermovee==true:
		luanpao()
	if Input.is_action_just_pressed("rightmouse"):
		rightmouse()
	if Input.is_action_just_released("move"):
		if $AnimatedSprite2D.is_playing():
			$AnimatedSprite2D.stop()
	if Input.is_action_just_pressed("jietu"):
		jietu()

func followmouse():
	var mouse_position =DisplayServer.mouse_get_position()
	get_window().position=Vector2i(mouse_position.x-get_viewport_rect().size.x/2,mouse_position.y-get_viewport_rect().size.y/2)
	default.emit("default")
	
func Dontfollowmouse():
	if whethermovee==true:
		whethermovee=false
		$AnimatedSprite2D.stop()
	else:whethermovee=true
	
func huanzhuang():
	cejianone.emit()
	
func luanpao():
	if ran1==0:
		stand.emit("stand")
	if ran1==1:
		movee.emit("movee")
		get_window().position += velocity
		if get_window().position.x > (rectsx-80) or get_window().position.x < 80:
			velocity.x *= -1  # 反转 x 方向速度
		if get_window().position.y > (rectsy-80) or get_window().position.y < 80:
			velocity.y *= -1  # 反转 y 方向速度
func rightmouse():
	if $Control.visible==false:
		iscontroling=true
		$Control.visible=true
		if whethermovee==true:
			whethermovee=false
			switchtwice=true
		elif whethermovee==false:
			switchtwice=false
	elif $Control.visible==true:
		iscontroling=false
		$Control.visible=false
		if switchtwice==true:
			whethermovee=true
	#if get_window().always_on_top==true:
		#get_window().always_on_top=false
	#else:get_window().always_on_top=true


	

















func _on_timer_timeout() -> void:
	ran1=randi_range(0,1)


func jietu():
	if $Sprite2D.visible==false:
		gpps=positionstart
		gppe=get_window().position
		var gpp=Vector2i(abs(gpps.x-gppe.x),abs(gpps.y-gppe.y))
		var rectt=Rect2i(gpps,gpp)
		var jietuimage=Image.create(100, 100, false, Image.FORMAT_RGBA8)
		DisplayServer.screen_get_image_rect(rectt).save_png("res://image//jietu.png")
		DisplayServer.screen_get_image_rect(rectt).save_png(imagepath)
		if rectt.size.x>1152 and rectt.size.y>648:
			$Sprite2D.scale=Vector2(0.5,0.5)
			get_window().get_viewport().size=Vector2i(1152,648)
		else:
			get_window().get_viewport().size=rectt.size
		get_window().position=Vector2i(200,200)
		$Sprite2D.texture=ImageTexture.new().create_from_image(Image.load_from_file(imagepath))
		$Sprite2D.visible=true
	else:
		get_window().get_viewport().size=Vector2i(200,260)
		$Sprite2D.visible=false 
