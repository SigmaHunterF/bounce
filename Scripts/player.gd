extends CharacterBody2D

const cool_down = .1

@onready var reload : float = 0

# scene instantiation variables
@onready var bullet = preload("res://Nodes/Bullet.tscn")
@onready var screen = preload("res://Nodes/screen.tscn")
@onready var slime = preload("uid://cfkuy28luyru2")

var is_alive = true
var health: int = 3
	
	
signal health_changed(new_health)
signal playerdied




const SPEED = 100.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# get direction of mouse
	var mouse_pos : Vector2 = get_global_mouse_position()
	# Add the gravity.
	
	# Fire a projectile if we met cool down
	if (Input.is_action_pressed("fire") and reload >= cool_down):
		# create bullet
		var projectile = bullet.instantiate()
		get_parent().add_child(projectile)
		
		# calculate direction of bullet
		var bullet_dir = (mouse_pos - global_position).normalized()
		
		# shoot bullet
		projectile.shoot(global_position, bullet_dir)
		#shoot.emit(position, mouse_pos)
		
		# initialize cool down timer
		reload = 0
	else:
		reload += delta
		
	

# Or load it at runtime



	# Get the input direction and handleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	var up_or_down := Input.get_axis("up", "down")
	if up_or_down:
		velocity.y = up_or_down * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	look_at(get_global_mouse_position())
	move_and_slide()


#take damage
func damage():
	health -= 1
	
	health_changed.emit(health)
#	get_tree().get_first_node_in_group("screen").update_hearts(health)
	#screen.update_hearts(health)
	if health <= 0:
		emit_signal("playerdied")
		
		print("you died")
		get_tree().reload_current_scene()
