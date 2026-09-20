extends CharacterBody2D

@onready var pizza = preload("uid://dvdk84w7vgsji")
const SPEED = 300.0
const max_age : int = 10
const nocollision : int = 1
const speed : int = 400

var direction : Vector2
var age : float = 0

func shoot(pos : Vector2, dir : Vector2) -> void:

	
	# Initialize the position, direction and speed
	global_position = pos
	direction = dir
	look_at(pos+dir)
	collision_mask = 3
func _physics_process(delta: float) -> void:
	#var collide = move_and_slide()
	#var collide = move_and_collide(direction*speed*delta)
	if age > max_age/10:
		queue_free()
		
		
		
	if age > nocollision:
		#gives the Bullet its collision back once away from the pizza
		$CollisionShape2D.disabled = false
	# the timer to indicate when to despawn the bullet
	age += delta
	# Add the gravity.
	
	
	# bounce after collision
	var collide = move_and_collide(direction * speed * delta)
	
	if collide:
		var collider = collide.get_collider()
		queue_free()
		print("Hit: ", collider.name)
		 		
		

		# update direction for bounce
	
# timer to despawn bullets

	
#func shoot(pos : Vector2, dir : Vector2) -> void:

	
	# Initialize the position, direction and speed
##	direction = dir
	#look_at(pos+dir)
	
	


		# update direction for bounce

	

	move_and_slide()
