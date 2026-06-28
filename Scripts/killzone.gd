extends Area2D

@onready var player = preload("res://Nodes/player.tscn")


func _ready():
	# Connect to the body_entered signal
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if body.name == "Player": 
	  # Optional: check if it's your specific character
		print("Character entered the area!")
		# Do something when character enters
		body.damage()


		# Do something when character exits
