extends Control

@export var max_health: int = 3
@onready var all : HBoxContainer = $HBoxContainer
@onready var heart_container = get_node("CanvasLayer/TextureRect/HBoxContainer")
var hearts = []


func _ready():
#hearts[i].visible = true   # Show heart
	add_to_group("screen")
	hearts = heart_container.get_children()
	
	get_node("../Player").health_changed.connect(update_hearts)
#dd	print(hearts.size())
func update_hearts(health):
	

	

	hearts[health].visible = false
	#hearts[health].visible = false
