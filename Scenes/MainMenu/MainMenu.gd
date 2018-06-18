extends Control

export(String, FILE, ".tscn") var next_scene

func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_TextureButton_pressed():
	get_tree().change_scene(next_scene)


func _on_Exit_pressed():
	get_tree().quit()
