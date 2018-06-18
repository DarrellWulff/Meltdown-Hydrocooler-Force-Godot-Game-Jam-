extends Control

export(String, FILE, ".tscn") var next_scene

export(String, FILE, ".tscn") var menu_scene

var levelWon = false
var levelLost = false

onready var winScreen = $MissionComplete
onready var loseScreen = $MissionFailed

#get the textures for countdown
#theres probably a better way to do this
#but I don't got time for that!

onready var text3 = $CenterContainer/text3
onready var text2 = $CenterContainer/text2
onready var text1 = $CenterContainer/text1
onready var textGo= $CenterContainer/goText
onready var gateOpen = $CenterContainer/gateText



var theMainReactor

var thePlayer



func _ready():
	
	thePlayer = get_tree().get_nodes_in_group("ThePlayer").front()
	
	
	theMainReactor = get_tree().get_nodes_in_group("MainReactor").front()
	theMainReactor.connect("level_won", self, "_on_level_won")
	theMainReactor.connect("level_lost", self, "_on_level_lost")
	theMainReactor.connect("wallsAreUp", self, "_gate_message")
	
	#Start of mission
	yield(get_tree().create_timer(1.0), "timeout")
	text3.show()
	yield(get_tree().create_timer(1.0), "timeout")
	text3.hide()
	text2.show()
	yield(get_tree().create_timer(1.0), "timeout")
	text2.hide()
	text1.show()
	yield(get_tree().create_timer(1.0), "timeout")
	text1.hide()
	textGo.show()
	thePlayer.movementEnhabled = true
	
	yield(get_tree().create_timer(0.5), "timeout")
	textGo.hide()
	theMainReactor.levelStarted = true
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_level_won():
	winScreen.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	thePlayer.movementEnhabled = false

func _on_level_lost():
	loseScreen.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	thePlayer.movementEnhabled = false

func _gate_message():
	var containerArea = $CenterContainer
	
	gateOpen.show()
	yield(get_tree().create_timer(5), "timeout")
	gateOpen.hide()
	containerArea.hide()

func _on_Next_pressed():
	print("DO IT")
	get_tree().change_scene(next_scene)


func _on_Exit_pressed():
	print("DO IT")
	get_tree().change_scene(menu_scene)


func _on_ExitF_pressed():
	print("DO IT")
	get_tree().change_scene(menu_scene)
	

func _on_TryAgain_pressed():
	print("DO IT")
	get_tree().reload_current_scene()
