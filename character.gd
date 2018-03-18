extends RigidBody2D

# Default Character Properties (Should be overwritten)
var acceleration = 10000
var top_move_speed = 200
var top_jump_speed = 400
var dead = false
var dead_animation = false

# Movement Vars
var directional_force = Vector2()
const DIRECTION = {
	ZERO = Vector2(0, 0),
	LEFT = Vector2(-1, 0),
	RIGHT = Vector2(1, 0),
	UP = Vector2(0, -1),
	DOWN = Vector2(0, 1)
}

func _integrate_forces(state):
	# Final force
	var final_force = Vector2()
	
	# We are not moving when you are not changing the direction
	directional_force = DIRECTION.ZERO
	
	# Apply force on character
	apply_force(state)
	
	# Get movement velocity
	final_force = state.get_linear_velocity() + (directional_force * acceleration)
	
	# Prevent ourselves from exceeding top speeds
	if(final_force.x > top_move_speed):
		final_force.x = top_move_speed
	elif(final_force.x < -top_move_speed):
		final_force.x = -top_move_speed
	# Prevent jumping too fast / falling too fast
	if(final_force.y > top_jump_speed):
		final_force.y = top_jump_speed
	elif(final_force.y < -top_jump_speed):
		final_force.y = -top_jump_speed
	
	# Add force
	state.set_linear_velocity(final_force)
	apply_death_animation(state)
	
func apply_death_animation(state):
	if dead && not dead_animation:
		dead_animation = true

		var rand = [randi() % 2, randi()%2, randi()%2]
		var dead_angular_velocity
		var dead_linear_velocity
		
		dead_angular_velocity = randi() % 15 + 5
		dead_linear_velocity = Vector2(randi()%400+200, randi()%500+500)

		if rand[0] == 1: dead_angular_velocity *= -1
		if rand[1] == 1: dead_linear_velocity.x *= -1
		dead_linear_velocity.y *= -1

			
		state.set_angular_velocity(dead_angular_velocity);
		state.set_linear_velocity(dead_linear_velocity);
	pass

# This func is overwritten by the character
func apply_force(state):
	pass