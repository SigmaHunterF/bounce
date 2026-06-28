extends CharacterBody2D

const max_age : int = 10
const speed : int = 400

var direction : Vector2
var age : float = 0

# timer to despawn bullets

	
func shoot(pos : Vector2, dir : Vector2) -> void:
	#print("pew pew")
	
	# Initialize the position, direction and speed
	global_position = pos
	direction = dir
	look_at(pos+dir)
	
	
func _physics_process(delta: float) -> void:
	if age > max_age/10:
		queue_free()
		 
	# the timer to indicate when to despawn the bullet
	age += delta
	
	#update position based on direction and speed.aw

	# move the bullet
	var collide = move_and_collide(direction*speed*delta)
	
	# bounce after collision
	if collide:
		# get collision normal
		var normal = collide.get_normal()

		# update direction for bounce
		#direction = direction+direction*collide.get_normal()
		direction = direction - 2*(direction.dot(normal))*normal
		
	
		


	
