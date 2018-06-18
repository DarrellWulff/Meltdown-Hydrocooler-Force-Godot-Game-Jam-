extends Node

onready var thePlayer = $Player
export(String, FILE, ".tscn") var menu_scene

func _ready():
	
	thePlayer.movementEnhabled = true
	
	yield(get_tree().create_timer(10.0), "timeout")
	get_tree().change_scene(menu_scene)
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
