extends KinematicBody2D

signal bash

const UPVECTOR = Vector2(0, -1)
const GRAVITY = 20
const MAXSPEED = 250
const JUMP_HEIGHT = -550
const DOUBLE_JUMP_HEIGHT = -650
const TIME_PRE_DOUBLE_JUMP = 0.01
const ACCELERATION = 25
const FRICTION_GROUND = 0.2
const FRICTION_AIR = 0.05

var motion = Vector2()
var double_jump = false
var jumped = false
var jump_time = 0
var time_bash = 0;
var is_bashing = true;

 
func _ready(): 
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _process(delta):
	
	if Input.is_action_just_pressed("ui_select"):
		is_bashing = true
		
	
		
	if is_bashing:
		emit_signal("bash")
		time_bash += delta
		if time_bash > 0.45:
			time_bash = 0
			is_bashing = false
	pass
	

func _physics_process(delta):
	var friction = false

	###### handle X axis Movement #######
	if Input.is_action_pressed("ui_right"):
		motion.x =  min (motion.x + ACCELERATION, MAXSPEED) 
	elif Input.is_action_pressed("ui_left"):
		motion.x =  max (motion.x - ACCELERATION, -MAXSPEED)
	else: 
		motion.x = 0
		friction = true
	
	
	###### handle Y axis Movement #######
	motion.y += GRAVITY
	
	if is_on_floor():
		jump_time = 0
		jumped = false
		double_jump = false
		if Input.is_action_just_pressed("ui_up"):
			jumped = true 
			motion.y = JUMP_HEIGHT
		if friction: 
			motion.x = lerp(motion.x, 0, FRICTION_GROUND)
	else:
		if friction: 
			motion.x = lerp(motion.x, 0, FRICTION_AIR)
		
		jumped = true
		if motion.y > 0:
			jump_time += delta
			
		if not double_jump && jumped && jump_time > TIME_PRE_DOUBLE_JUMP && Input.is_action_just_pressed("ui_up"):
			motion.y = DOUBLE_JUMP_HEIGHT
			double_jump = true  
			
	motion = move_and_slide(motion, UPVECTOR)



func _on_Area2D_area_entered(area):
	pass # replace with function body
	
var raised_shield = false

func _on_StunArea_body_entered(body):
#	if raised_shield:
	var groups = body.get_groups()
	if not $".".is_connected("bash", body, "get_bash"):
		if(groups.has("abomination")):
			$".".connect("bash", body, "get_bash")
		
	pass # replace with function body


func _on_Player_body_entered(body):
	
	pass # replace with function body
