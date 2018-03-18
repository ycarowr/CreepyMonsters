extends Node2D


signal create_creature (Abomination)

export (PackedScene) var Abomination
export (float) var timer
# class member variables go here, for example:
# var a = 2
# var b = "textvar"



func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func spawn_enemy():

	var enemy = Abomination.instance() 
	add_child(enemy)
	enemy.position = $PositionSpawn.position
	emit_signal("create_creature", enemy)
	if timer != null:
		$Timer.wait_time = timer

	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_Timer_timeout():
	spawn_enemy()
	pass # replace with function body
