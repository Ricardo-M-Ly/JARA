extends Control
var jietuimage
var gpps:Vector2i
var gppe:Vector2i
# 选择框的起点和终点

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/hideortop.toggle_mode=true # Replace with function body.
	$VBoxContainer/yifu.toggle_mode=true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $AudioStreamPlayer.playing==false and $AudioStreamPlayer.stream_paused==false:
		$AudioStreamPlayer.play()


func _on_hideortop_toggled(toggled_on: bool) -> void:
	if toggled_on==true:
		get_parent().get_window().always_on_top=false
	else:
		get_parent().get_window().always_on_top=true # Replace with function body.


func _on_yifu_toggled(toggled_on: bool) -> void:
	if toggled_on==true:
		get_parent().huanzhuang()
	if toggled_on==false:
		get_parent().huanzhuang() # Replace with function body.

func _on_music_pressed() -> void:
	if $AudioStreamPlayer.playing:
		$AudioStreamPlayer.stream_paused=true
	else:
		$AudioStreamPlayer.stream_paused=false

func on_jietu_press():
	if $Sprite2D.visible==false:
		$Sprite2D.visible=true
		gpps=get_parent().positionstart
		gppe=get_window().position
		var gpp=Vector2i(abs(gpps.x-gppe.x),abs(gpps.y-gppe.y))
		var rectt=Rect2i(gpps,gpp)
		var jietuimage=Image.create(100, 100, false, Image.FORMAT_RGBA8)
		get_parent().get_window().get_viewport().size=Vector2i(800,1020)
		DisplayServer.screen_get_image_rect(rectt).save_png("res://jietu.png")
	else:
		get_parent().get_window().get_viewport().size=Vector2i(200,260)
		$Sprite2D.visible=false
