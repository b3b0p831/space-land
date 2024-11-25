extends Node2D

var platform_node
var player_node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	platform_node = $platform as StaticBody2D
	player_node = $player as RigidBody2D
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(player_node.transform.x.angle_to_point(platform_node.transform.x) * 180/PI)
	
