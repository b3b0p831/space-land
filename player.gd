extends RigidBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -750.0



	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	linear_velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("ui_accept"):
		var local_top = Vector2(0, -1)  # Top direction in local space
		var global_top = global_transform.basis_xform(local_top)  # Convert to global direction
		var impulse_strength = 450_000_000  # Adjust the strength of the impulse
		apply_central_force(global_top * impulse_strength)
		print(global_top * impulse_strength)
	
	if Input.is_action_pressed("ui_left"):
		apply_torque(-500_000_000)


	if Input.is_action_pressed("ui_right"):
		apply_torque(500_000_000)

		
