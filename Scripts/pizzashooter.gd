extends CharacterBody2D


@onready var pizza = preload("uid://dvdk84w7vgsji")
var player: Node2D
const SPEED: int = 50
const cooldown: float = 1
var health: int = 3
@onready var reload : float = 0
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	#get_node_or_null("../Player")
func _physics_process(delta: float) -> void:
	if reload >= cooldown:
		var projectile = pizza.instantiate()
		get_parent().add_child(projectile)
		
		# calculate direction of bullet
		var bullet_dir = (player.global_position - global_position).normalized()
		
		# shoot bullet
		projectile.shoot(global_position, bullet_dir)
		#shoot.emit(position, mouse_pos)
		
		# initialize cool down timer
	
		reload = 0
	else:
		reload += delta
		

	
	if player:
		velocity = position.direction_to(player.global_position) * SPEED
		
		

		move_and_slide()
func takeshooterdamage():
	health -= 1 
	
	if health <= 0:
		queue_free()
	
