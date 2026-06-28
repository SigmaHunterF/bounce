extends CanvasModulate
@export var gradient:GradientTexture1D
var time:float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body
	
func changedaytime(wavebar):
	print(wavebar)
	#if wavebar % 2 == 0:
	#	$CanvasModulate.visible = false
	#else:
	#	$CanvasModulate.visible = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	var value = (sin(time/4 - PI / 2) + 1.0) / 2.0
	self.color = gradient.gradient.sample(value)
