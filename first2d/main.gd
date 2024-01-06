extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene
	var mob = mob_scene.instantiate()
	
	#Choose a random location on Path2D
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	#Set the mobs direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2
	
	#Add some randomness to the direction
	direction += randf_range(-PI / 4 , PI / 4)
	mob.rotation = direction
	
	#Choose the velocity of the mob
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	
	#Spawn the mob by adding it as a child to the Main scene.
	add_child(mob)


func _on_score_timer_timeout():
	score += 1


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
