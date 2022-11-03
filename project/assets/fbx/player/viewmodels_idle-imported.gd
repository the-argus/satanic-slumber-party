extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_node("AnimationPlayer").play("Animation")
	var test = Example.new()
	test.simple_func()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
