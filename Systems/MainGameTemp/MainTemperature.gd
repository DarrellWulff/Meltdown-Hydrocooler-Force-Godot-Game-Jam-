extends Area

#Its gam jam code so everything is smashed into this main class, 
#but normally I would try to split the work load on different nodes

export(float) var LevelTemperatureGauge
export(int) var numOfReactors
var currentReactors = 0.0
var reactorHeatFactor = 0.0
var incomingHeat = 0


var heatUpTime = 2
var heatUpTimer = 0
var isCooling = false
var objectCooled = false

onready var smoke = $CollisionShape/Smoke

#Secondary Reactors In Level, set scene to scene
var reactorsArray

var reactorWallArray 
signal wallsAreUp
var mainReactorReady = false
var levelStarted = false

signal level_won
signal level_lost
var levelEnded = false


func _ready():
	
	#Connect the signals of the reactor group on the start of level
	reactorsArray = get_tree().get_nodes_in_group("Heatable")
	for item in reactorsArray:
		item.connect("object_is_cooled", self, "_on_level_cooled")
	
	reactorWallArray = get_tree().get_nodes_in_group("Wall")

	
func _physics_process(delta):
 	
	reactorHeatFactor = numOfReactors - currentReactors
	
	if(reactorHeatFactor == 0 && mainReactorReady == false):
		mainReactorReady = true
		emit_signal("wallsAreUp")
		_reactor_wall_open()
	
		
	#if(isCooling && objectCooled == false && mainReactorReady):
		#incomingHeat -= 1
		#heatUpTimer = 0
	if(!isCooling && objectCooled == false && incomingHeat>=0 && reactorHeatFactor != 0 && levelStarted):
		incomingHeat += ((delta / reactorHeatFactor) + .025) 
	elif(isCooling && objectCooled == false && !incomingHeat<=0 && reactorHeatFactor != 0 && levelStarted):
		incomingHeat += (delta + .062) 
	else:
		heatUpTimer += 1
	
	if(incomingHeat < LevelTemperatureGauge && objectCooled == false && levelStarted):
		incomingHeat += ((delta * reactorHeatFactor) + .062) 
		
	
	
	if(incomingHeat<=0 && objectCooled == false && levelStarted):
		smoke.hide()
		objectCooled = true
		levelEnded = true
		print("REACTOR COOLED")
		emit_signal("level_won")
	
	if(incomingHeat >= LevelTemperatureGauge):
		levelEnded = true
		emit_signal("level_lost")
	
	
	


func _on_level_cooled():
	
	currentReactors += 1
	

func _reactor_wall_open():
	
	for item in reactorWallArray:
		item.collisionArea.disabled = true
		item.hide()
		


func _on_Area_area_entered(area):
	isCooling = true
	if(mainReactorReady):
		incomingHeat -= 1
		heatUpTimer = 0
	
	
	area.queue_free()



func _on_Area_area_exited(area):
	isCooling = false
