if (game_manager_ref.current_state == GAME_STATE.TAKEOFF) {
    // Move the ship to the right, but clamp x to a maximum of 330
    x = clamp(x + speed_side * dt_sec, 0, 330);
    
    // Adjust rotation towards 0 with clamping
    var diff = current_rotation;
    current_rotation -= turn_rotation_speed * diff * dt_sec;
    current_rotation = clamp(current_rotation, 0, 1);
}