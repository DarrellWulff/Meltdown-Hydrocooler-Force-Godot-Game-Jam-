extends Area

var reactorTemp =200
var heatUpTime = 2
var heatUpTimer = 0
var isCooling = false
var objectCooled = false

onready var smoke = $CollisionShape/Smoke

signal object_is_cooled

func _ready():
	
	pass

func _process(delta):
	
	if(isCooling && objectCooled == false && !reactorTemp<0 ):
		reactorTemp -=1
		heatUpTimer = 0
	else:
		heatUpTimer += 1
	
	if(heatUpTimer>= heatUpTime && reactorTemp < 200 && objectCooled == false):
		reactorTemp +=.25
	
	
		
	if(reactorTemp==0 && objectCooled == false):
		smoke.hide()
		objectCooled = true
		print("REACTOR COOLED")
		emit_signal("object_is_cooled")

func _on_Area_area_entered(area):
	
	isCooling = true
		
	area.queue_free()



func _on_Area_area_exited(area):
	isCooling = false
