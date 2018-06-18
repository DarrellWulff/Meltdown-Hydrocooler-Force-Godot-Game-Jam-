extends Spatial

const GRAVITY = -.003
var HEAVYGRAVITY = -.01

export(float) var waterSpeed
export(float) var forceOfBlast

var moveVelocity = Vector3(0,0,-1)


var killTimer = 0
var killTime = 3

var fowardDirection
var contactHit = false

func _ready():
	
	HEAVYGRAVITY += rand_range(-.001, .005)
	
	pass

func _physics_process(delta):
	
	killTimer += delta
	
	moveVelocity.y += GRAVITY
	
	if(killTimer >= killTime):
		queue_free()
		
	if(killTimer >= .1 && killTimer < killTime):
		moveVelocity.y += HEAVYGRAVITY
		
	
	fowardDirection = global_transform.basis.xform(moveVelocity)

	
	global_translate(fowardDirection * waterSpeed * delta)
	
	
	
	
	
	
	
	
	
