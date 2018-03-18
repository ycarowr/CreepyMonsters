extends "res://character.gd"


var position_last_second = Vector2()
var stopped_time = 0
const TIME_CHANGE_DIRECTION = 0.05
var current_direction = DIRECTION.LEFT


func _ready():
	# Set player properties
	acceleration = 60
	top_move_speed = randi()%80+40 + OS.get_unix_time() % 30
	var random = randi()%2
	if random == 1: 
		current_direction = DIRECTION.RIGHT
		
	


func get_bash():
	dead = true
	current_direction = Vector2()
	$CollisionShape2D.disabled = true
	pass
	

		
	
# Apply force
func apply_force(state):
	# Move Left
	if not dead:
		directional_force += current_direction
		stopped_time += state.get_step()
		if stopped_time > TIME_CHANGE_DIRECTION:
			stopped_time = 0
			if position_last_second == position:
				current_direction *= -1
			
		position_last_second = position

	
	
	# Move Right
	#directional_force += DIRECTION.RIGHTs