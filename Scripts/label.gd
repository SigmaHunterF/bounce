extends Label
@onready var wavebarnumber = preload("uid://cfkuy28luyru2")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#text = (wavebar)
	# Replace with function body.
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame
	
func updatetext(wave_number):
	text = ("Wavenumber:" + str(wave_number))
	print(wave_number)
	
