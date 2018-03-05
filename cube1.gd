extends MeshInstance

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var max_height = 2
var height = max_height

var time = 0

var loop_time = 1
var tween_time = 0.61803398874989 * loop_time

export(int, 0, 10) var interpolation = 0
export(int, 0, 3) var easing = 0

func _ready():
	run_tween(interpolation, easing)
	

func _process(delta):
	# count total time by adding up time between frames
	time += delta
	
	if time > loop_time:
		# if we pass the timer maximum
		
		time = 0
		# reset the timer
		
		height = 0 if height != 0 else max_height
		# flip the height between 0 and max height

func on_tween_done(obj, path, i_type, e_type):
	run_tween(i_type, e_type)

func run_tween(interpolate_type, easing_type):
	$Tween.interpolate_property(self, "translation", translation, Vector3(translation.x,height,translation.z),tween_time,interpolate_type, easing_type, loop_time - tween_time)
	
	$Tween.start()
	
	#Looping function
	if not $Tween.is_connected("tween_completed", self, "on_tween_done"):
		$Tween.connect("tween_completed", self, "on_tween_done", [interpolate_type, easing_type])