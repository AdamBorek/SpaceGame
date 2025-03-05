if (game_manager_ref.current_state == GAME_STATE.TAKEOFF) {
    // Move the ship to the left, but clamp x to a minimum of 30
    x = clamp(x - speed_side * dt_sec, 30, 330);
    
    // Adjust rotation towards 1 with clamping
    var diff = 1 - current_rotation;
    current_rotation += turn_rotation_speed * diff * dt_sec;
    current_rotation = clamp(current_rotation, 0, 1);
}