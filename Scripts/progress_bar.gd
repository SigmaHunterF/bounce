extends ProgressBar
@onready var slime = preload("uid://cfkuy28luyru2")

#ssignal wavenumber(newwavenumber)
# Called when the node enters the scene tree for the first time.
func _ready():
	#var percent = slime.instantiate()
	#print(percent.wavebar)
#	get_node("../Slime").wavebarprogress.connect(changebar)
	#value = slime.wavebar
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.

	
func changebar(wavebar):
	
	#print(wavebar)
#	get_node("CanvasLayer/Label")
#	$Label.text = wavebar
	value = wavebar
	#wavenumber.emit(wavebar)
