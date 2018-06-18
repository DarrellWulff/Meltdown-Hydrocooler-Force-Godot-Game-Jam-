extends Spatial

var exhaust = preload("res://Scenes/Player/Water.tscn")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	
	if(Input.is_action_pressed("INPUT_FIRE")):
		
		var exhaustClone = exhaust.instance()
		
		var sceneRoot = get_tree().root.get_children()[0]
		sceneRoot.add_child(exhaustClone)
		
		
		exhaustClone.global_transform = self.global_transform
