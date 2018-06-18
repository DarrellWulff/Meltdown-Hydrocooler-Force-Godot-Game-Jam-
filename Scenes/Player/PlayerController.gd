extends KinematicBody

#CONTROL VARIABLES
export(float)var moveSpeed
export(float)var mouseSensitivity
export(float)var jumpHeight
const GRAVITY = -3
const FLOOR = Vector3(0,1,0)

export(NodePath) var playerHeadPath
var playerHead
var playerHeadRotation
var playerHeadRotationClamp

var moveVelocity = Vector3(0,0,0)
var mouseInput = Vector2()
export(bool) var UsingController
var inputDirection = Vector3()

var lookAngle = 0

#if player falls
var respawnPoint

#WHEN MISSION IS OVER AND START OF MISSION
#TAKE THE WHEEL
var movementEnhabled

func _ready():
	
	movementEnhabled = false
	
	respawnPoint = get_translation()
	
	playerHead = get_node(playerHeadPath)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	pass


func _input(event):
	if(movementEnhabled):
		if event is InputEventMouseMotion:
		
			mouseInput = event.relative
		

func _turn_player():
	
	if(mouseInput.length() > 0):
		
		
		playerHeadRotation = mouseInput.y * mouseSensitivity
		
		
		rotate_y(deg2rad( -mouseInput.x * mouseSensitivity))
		
		
		
		playerHead.rotate_x(deg2rad(-playerHeadRotation))
		
		playerHeadRotationClamp = playerHead.rotation_degrees
		playerHeadRotationClamp.x = clamp(playerHeadRotationClamp.x, -70,70)
		playerHead.rotation_degrees = playerHeadRotationClamp
		
		
		
		
	
	mouseInput = Vector2()



func _physics_process(delta):
	
	inputDirection = Vector3()
	
	moveVelocity.y += GRAVITY
	
	
	if(!UsingController):
	
		if(Input.is_action_pressed("INPUT_LEFT")):
		
			inputDirection -= playerHead.get_global_transform().basis.x
	
		if(Input.is_action_pressed("INPUT_RIGHT")):
		
			inputDirection += playerHead.get_global_transform().basis.x
		
		if(Input.is_action_pressed("INPUT_UP")):
		
			inputDirection -= playerHead.get_global_transform().basis.z
		
		if(Input.is_action_pressed("INPUT_DOWN")):
		
			inputDirection += playerHead.get_global_transform().basis.z
	else:
		inputDirection.z = Input.get_joy_axis(0,1) 
		inputDirection.x = Input.get_joy_axis(0,0)
	
	if(UsingController):
		
		#JOYSTICK DEADZONE
		if(inputDirection.length() <= .15):

			inputDirection = Vector3(0,0,0)
	
		inputDirection	= playerHead.get_global_transform().basis.xform(inputDirection)
		
	moveVelocity.x = moveSpeed * inputDirection.x
	moveVelocity.z = moveSpeed * inputDirection.z
	
	_turn_player()
	
	if(is_on_floor()):
		
		
		if(Input.is_action_just_pressed("INPUT_JUMP")):
		
			moveVelocity.y = jumpHeight	
		
		
	
	if(get_translation().y <= -100):
		set_translation(respawnPoint)
	
	
	if(movementEnhabled):
		moveVelocity = move_and_slide(moveVelocity, FLOOR)
