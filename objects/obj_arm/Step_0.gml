// Set the speedometer position relative to the camera
x = 78;
y = camera_get_view_y(cam) + 665;

// Set visibility and adjust speedometer angle based on game state
var game_state = rocket_ref.game_manager_ref.current_state;
var min_speed = 0;
var max_speed = 8;
var min_angle = 120;
var max_angle = -120;

switch (game_state) {
    case GAME_STATE.COUNTDOWN:
        visible = true;
        image_angle = calculate_angle(rocket_ref.start_boost_current, min_speed, max_speed, min_angle, max_angle);
        break;

    case GAME_STATE.TAKEOFF:
    case GAME_STATE.FALLING:
        visible = true;
        image_angle = calculate_angle(rocket_ref.speed, min_speed, max_speed, min_angle, max_angle);
        break;

    default:
        visible = false;
        break;
}
