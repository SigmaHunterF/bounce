extends Control

@export var max_health: int = 3

@onready var heart_container = get_node("CanvasLayer")
var hearts = []


func _ready():
  # Show heart
	add_to_group("screen")
	hearts = heart_container.get_children()
	
	get_node("../Player").health_changed.connect(update_hearts)

func update_hearts(health):
	hearts[health].visible = false
