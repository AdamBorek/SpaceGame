// Get reference to game manager
game_manager_ref = instance_find(obj_game_manager, 0);

// Initialize fuel parameters
fuel_low = 8;
fuel_high = 15;
fuel_increment = (fuel_high - fuel_low) / 5;
fuel_max = fuel_low;
fuel_current = fuel_max;
fuel_consumption = 0.3;

// Initialize speed parameters
speed_low = 3;
speed_high = 5;
speed_increment = (speed_high - speed_low) / 5;
speed_max = speed_low;
acceleration = speed_max / 5;

// Initialize boost parameters
boost_low = 1.75;
boost_high = 3;
boost_increment = (boost_high - boost_low) / 5;
boost = boost_low;
boost_acceleration = acceleration * 10;
start_boost_increment = speed_max * 0.1;
start_boost_current = 0;

// Movement properties
speed_side = 150;
speed_slowdown = 3;
turn_rotation_max = 25;
turn_rotation_speed = 15;
current_rotation = 0.5;

// Status flags
boost_speed_reached = false;
height = -(y - room_height);
max_height = 0;

// Upgrade levels
speed_upgrade = 0;
boost_upgrade = 0;
fuel_upgrade = 0;

// Function to reset the rocket's position and state
function reset() {
    speed = 0;
    start_boost_current = 0;
    fuel_current = fuel_max;
    x = 180;
    y = 15960;
}

// Function to adjust the speed of the rocket
function adjust_speed() {
    if (speed < start_boost_current) {
        speed += boost_acceleration * dt_sec;
    } else {
        speed += acceleration * dt_sec;
    }

    // Cap the speed at maximum
    if (speed > speed_max) {
        speed -= dt_sec * speed_slowdown;
    }
}

// Function to handle fuel consumption
function consume_fuel() {
    if (fuel_current >= 0) {
        fuel_current -= dt_sec * fuel_consumption;
    }
}

// Function to reset rotation when no keys are pressed
function reset_rotation() {
	
	// If underrotated, rotate ship in positive direction
	if (current_rotation < 0.5) { 
		var diff = 0.5 - current_rotation;
		current_rotation += turn_rotation_speed * diff * dt_sec; 
		if (current_rotation > 0.5) { current_rotation = 0.5; }
	}
	
	// If overrotated, rotate ship in negative direction
	if (current_rotation > 0.5) { 
		var diff = current_rotation - 0.5;
		current_rotation -= turn_rotation_speed * diff * dt_sec; 
		if (current_rotation < 0.5) { current_rotation = 0.5; }
	}
}