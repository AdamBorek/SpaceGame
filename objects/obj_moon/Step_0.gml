// Rocket height
var rocket_height = rocket_ref.height;

// Define minimum and maximum heights for the rocket
var min_height = 0;
var max_height = 15000;

// Define minimum and maximum Y positions for the moon
var min_y = 10000;
var max_y = 200;

// Clamp the rocket height to ensure it's within the expected range
rocket_height = clamp(rocket_height, min_height, max_height);

// Calculate the interpolation factor
var t = (rocket_height - min_height) / (max_height - min_height);

// Interpolate the Y position of the moon
var moon_y = lerp(min_y, max_y, t);

// Set the Y position of the moon
if (rocket_ref.game_manager_ref.current_state == GAME_STATE.TAKEOFF) {
	y = moon_y;
}