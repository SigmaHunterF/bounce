extends CharacterBody2D


var player: Node2D
static var SPEED: int = 50
var health: int = 3
@onready var animated_sprite: AnimatedSprite2D = $Animatedslime
@onready var timer: Timer = $Timer
@onready var label = get_node("CanvasLayer/Label")
var alive = true
static var wavebar: int = 0 
signal wavebarprogress(new_wavebar)
static var wave_number: int = 1
signal wavechanged(new_wave_number)
func _ready():
	# Check if the wave increases
	#var game = get_node("/root/Game")
	#if wavebar == 10:
		
	#	SPEED += 2000
		
	#	print("nextwavea")
	#	wave_number += 1
	#	wavechanged.emit(wave_number)
	#	print(wave_number)
	#	wavebar = 0
	# Try to find player node - adjust the path to match your scene
	player = get_node_or_null("../Player")  # if player is sibling
	# OR
	# player = get_tree().root.get_node("MainScene/Player")  # adjust path
	
	if not player:
		print("ERROR: Player not found!")

func _physics_process(_delta: float) -> void:
	if player and alive:
		velocity = position.direction_to(player.global_position) * SPEED
		move_and_slide()
	
func takedamage():
	#print("ouch")
	health -= 1
	if health == 0:
		alive = false
		
	
		if animated_sprite != null:
			animated_sprite.play("Death")
			
		else:
			print("it not working")
		
		timer.timeout.connect(_on_timer_timeout)
		timer.start()



func _on_timer_timeout():
	if animated_sprite.animation == "Death":
		
		wavebar += 1
		wavebarprogress.emit(wavebar)
		
		if wavebar == 10:
			wave_number += 1
			wavechanged.emit(wave_number)
			
			SPEED += 10
			wavebar = 0
			
			
		
		queue_free()


func _on_player_playerdied() -> void:
	SPEED = int(50)
	wavebar = int(0)
	wave_number = int(1)
	print(SPEED)
 # Replace with function body.
