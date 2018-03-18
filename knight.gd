extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var current_animation = "idle"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$AnimationPlayer.animation_set_next("raise_shield", "idle") 
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	if Input.is_action_just_pressed("ui_select"):
		$AnimationPlayer.play("raise_shield")
		
func play_idle():
	
	pass
	
