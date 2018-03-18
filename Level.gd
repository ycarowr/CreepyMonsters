extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	randomize()
	pass

func _on_PositionSpawn_create_creature(enemy):
#	if not get_node("Player").is_connected("bash", enemy, "get_bash"):
#		get_node("Player").connect("bash", enemy, "get_bash")
	pass # replace with function body
