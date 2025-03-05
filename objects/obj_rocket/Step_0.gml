// Update height based on room dimensions
height = -(y - room_height);

switch (game_manager_ref.current_state) {
    case GAME_STATE.UPGRADE:
        // Handle upgrade logic if any
        break;

    case GAME_STATE.COUNTDOWN:
        show_debug_message("start boost: " + string(start_boost_current));

        // Decrease start boost with a clamp to prevent negative values
        start_boost_current -= dt_sec * speed_max / 3;
        start_boost_current = clamp(start_boost_current, 0, speed_max);
        break;

    case GAME_STATE.TAKEOFF:
        direction = 90;

        // Adjust speed and consume fuel
        adjust_speed();
        consume_fuel();
		
        break;

    case GAME_STATE.FALLING:
        // Decrease speed due to gravity when falling
        speed -= dt_sec * 9.81;
        break;

    case GAME_STATE.VICTORY:
        // Victory state logic can be handled here
        break;

    default:
        // Placeholder for unhandled states
        break;
}

// Handle ship rotation if no keys are pressed
if (!keyboard_check(vk_left) && !keyboard_check(vk_right)) {
    reset_rotation();
}

// Update the ship's image angle based on its rotation
image_angle = lerp(-turn_rotation_max, turn_rotation_max, current_rotation);