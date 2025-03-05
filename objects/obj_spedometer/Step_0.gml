// Set the speedometer position relative to the camera
x = 78;
y = camera_get_view_y(cam) + 665;

// Set visibility based on the current game state
var game_state = rocket_ref.game_manager_ref.current_state;
visible = (game_state == GAME_STATE.COUNTDOWN || game_state == GAME_STATE.TAKEOFF || game_state == GAME_STATE.FALLING);