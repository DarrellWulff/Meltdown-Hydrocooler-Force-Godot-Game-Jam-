extends KinematicBody


export(float) var moveSpeed
var movementVector = Vector3(0,0,0)
var angledMovement = 0
export(float) var moveWidth
export(Vector3) var direction

func _ready():
	
	pass

func _physics_process(delta):
	
	angledMovement += deg2rad(moveWidth + delta)
	
	movementVector = direction * moveSpeed * cos(angledMovement)
	
	translate(movementVector/100)
	
