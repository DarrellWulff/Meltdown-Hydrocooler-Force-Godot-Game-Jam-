extends TextureProgress

export(NodePath) var mainPath
onready var mainReactor = get_node(mainPath)

var levelIsEnded = false


func _ready():

	value = 0
	max_value = mainReactor.LevelTemperatureGauge
	

func _process(delta):
	
	value = mainReactor.incomingHeat
	if(mainReactor.levelEnded && levelIsEnded == false):
		levelIsEnded = true
		hide()
