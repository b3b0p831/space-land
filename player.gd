extends RigidBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -750.0

var goal_node
var speed_label
var dist

func reset_player():
	self.global_position = Vector2(575, 175)
	self.linear_velocity = Vector2.ZERO
	self.rotation = 0

func _ready() -> void:
	goal_node = get_node("/root/Node2D/platform") as StaticBody2D
	speed_label = get_node("/root/Node2D/ui_layer/speed_label") as Label

	reset_player()

	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not self.get_contact_count():
		linear_velocity += get_gravity() * delta
		
	# Handle jump.
	if Input.is_action_pressed("ui_accept"):
		var local_top = Vector2(0, -1)  # Top direction in local space
		var global_top = global_transform.basis_xform(local_top)  # Convert to global direction
		var impulse_strength = 375_000_000  # Adjust the strength of the impulse
		apply_central_force(global_top * impulse_strength)
		#print(global_top * impulse_strength)
		print(get_gravity())
	
	if Input.is_action_pressed("ui_left"):
		apply_torque(-600_000_000)


	if Input.is_action_pressed("ui_right"):
		apply_torque(600_000_000)
		
		
	if goal_node:
		var platform_pos = goal_node.global_position
		var dir_angle = self.global_position.direction_to(platform_pos).angle()

		# Account for player's rotation
		var player_rotation = rotation  # Rotation of the player (RigidBody2D)

		# Adjust the direction to account for the player's rotation
		var adjusted_angle = (dir_angle - player_rotation) + 1.57
		
		dist = self.global_position.distance_to(platform_pos)
		

		if dist > 2_000:
			reset_player()
		# Apply the adjusted angle to the arrow's rotation
		$arrow.rotation = adjusted_angle
		#print($arrow.rotation)
		
		
	if speed_label:
		speed_label.text = "Velocity: " + str(self.linear_velocity) + "\nAngle: " + str(self.rotation) + "\nDistatnce: " + str(dist)
		print(speed_label.text)
		
