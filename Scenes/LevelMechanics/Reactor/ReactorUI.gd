extends Control

#was having UI problems and I was tired so I just slapped this together
#NOT the best practice at all
onready var progressNode = $HBoxContainer/TextureProgress



func _process(delta):
	if(progressNode.levelIsEnded):
		hide()
