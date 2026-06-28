extends Area2D


func _ready():
	# Connect to the body_entered signal
	body_entered.connect(_on_body_entered)
#	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	
	#Check to make sure that it is the slime.
		
	if body.has_method("takedamage"):
		body.takedamage()
