extends Node2D

@onready var time : float = 0
var spawntime: int = 1
var wavebar: int = 0
var slime = preload("res://Nodes/slime.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if time > spawntime:
# Instance it
		var enemy_instance = slime.instantiate()

# Set its position or other properties
		var random_x = randf_range(-519, 679)
		var random_y = randf_range(-615, 343)
		enemy_instance.position = Vector2(random_x, random_y)

# Add it to the scene tree
		add_child(enemy_instance)
		enemy_instance.wavechanged.connect(get_node("CanvasModulate").changedaytime)
		enemy_instance.wavebarprogress.connect(get_node("Screen/CanvasLayer/ProgressBar").changebar)
		enemy_instance.wavechanged.connect(get_node("Screen/CanvasLayer/Label").updatetext)
		time = 0
	else:
		time += delta
