extends "res://character.gd"

# Grounded?
var grounded = false 

# Jumping
var can_jump = false
var can_double_jump = false
var double_jump_time = 0.08
var jump_time = 0
var time_bash = 0;
var is_bashing = true;
var in_air_time = 0;
const TOP_JUMP_TIME = 0.1 # in seconds
signal bash




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

# Start
func _ready():
	# Set player properties
	acceleration = 200
	top_move_speed = 200
	top_jump_speed = 600

# Apply force
func apply_force(state):
	# Move Left
	if(Input.is_action_pressed("ui_left")):
		directional_force += DIRECTION.LEFT
	
	# Move Right
	if(Input.is_action_pressed("ui_right")):
		directional_force += DIRECTION.RIGHT
	
	# Jump
	if(Input.is_action_pressed("ui_up") && jump_time < TOP_JUMP_TIME && can_jump):
		directional_force += DIRECTION.UP
		jump_time += state.get_step()
	elif(Input.is_action_just_released("ui_up")):
		can_jump = false # Prevents the player from jumping more than once while in air
	
	
	#Double Jump
	if in_air_time > 0.5:
		if(Input.is_action_pressed("ui_up") && double_jump_time < TOP_JUMP_TIME && can_double_jump):
			directional_force += DIRECTION.UP
			double_jump_time += state.get_step()
		elif(Input.is_action_just_released("ui_up")):
			can_double_jump = false # Prevents the player from jumping more than once while in air
			
	
	# While on the ground
	if(grounded):
		can_jump = true
		jump_time = 0
		double_jump_time = 0
		can_double_jump = true
		in_air_time = 0
	else:
		in_air_time += state.get_step()


# Enter Ground
func _on_ground_check_body_enter( body ):
	# Get groups
	var groups = body.get_groups()

	# If we are on a solid ground
	if(groups.has("solid")):
		grounded = true


# Exit Ground
func _on_ground_check_body_exit( body ):
	# Get groups
	var groups = body.get_groups()

	# If we are on a solid ground
	if(groups.has("solid")):
		grounded = false


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
