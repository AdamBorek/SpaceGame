randomize();

// Define Game States as an Enum
enum GAME_STATE {
    START,
    UPGRADE,
    COUNTDOWN,
    TAKEOFF,
    FALLING,
    VICTORY
}

// Initialize game state
current_state = GAME_STATE.START;

// Function to set game state
function set_state(new_state) {
    current_state = new_state;
}

// Get reference to the rocket instance
rocket_ref = instance_find(obj_rocket, 0);

// Countdown timer
countdown_timer_max = 5;
countdown_timer_current = countdown_timer_max;

// Initialize money
money = 0;

// Set up the camera
cam = view_camera[0];
camera_set_view_pos(cam, 0, rocket_ref.y - 675);
cam_speed = rocket_ref.speed_max * 1.2;

// Set victory height
victory_height = 15000;

// Hide the upgrade screen initially
upgrade_screen = layer_get_id("UpgradeScreen");
layer_set_visible(upgrade_screen, false);

// Set up the upgrade UI elements and hide them
upgrade_ui = [
    instance_find(obj_takeoff, 0), 
    instance_find(obj_upgrade_big_bg, 0), 
    instance_find(obj_upgrade_boost, 0), 
    instance_find(obj_upgrade_fuel, 0), 
    instance_find(obj_upgrade_speed, 0),
    instance_find(obj_max, 0),
    instance_find(obj_max, 1),
    instance_find(obj_max, 2)
];

// Toggles upgrade UI visibility
function set_upgrade_ui_visibility(visibility) {
    for (var i = 0; i < array_length(upgrade_ui); i++) {
        upgrade_ui[i].visible = visibility;
    }
}

// Set all upgrade UI elements to invisible
set_upgrade_ui_visibility(false);

// Initialize asteroid spawn timer
asteroid_spawn_timer = 1;

// Handles all upgrade logic
function handle_upgrades() {
    rocket_ref.speed_max = handle_upgrade(obj_upgrade_speed, rocket_ref.speed_upgrade, rocket_ref.speed_max, rocket_ref.speed_increment, "speed");
    rocket_ref.boost = handle_upgrade(obj_upgrade_boost, rocket_ref.boost_upgrade, rocket_ref.boost, rocket_ref.boost_increment, "boost");
    rocket_ref.fuel_max = handle_upgrade(obj_upgrade_fuel, rocket_ref.fuel_upgrade, rocket_ref.fuel_max, rocket_ref.fuel_increment, "fuel");
    
    var clicked = mouse_check_button_released(mb_left);
    var takeoff = instance_find(obj_takeoff, 0);
    var on_takeoff = is_mouse_over(obj_takeoff);
    
    if (on_takeoff && clicked) {
        randomize();
        spawn_objects(13500, 2000, 9, obj_junk, obj_star);
        set_state(GAME_STATE.COUNTDOWN);
        rocket_ref.reset();
        set_upgrade_ui_visibility(false);
    }
}

// Handles a specific upgrade
function handle_upgrade(upgrade_obj, upgrade_level, max_stat, increment, upgrade_type) {
    var on_upgrade = is_mouse_over(upgrade_obj);
    
    if (upgrade_level == 5) {
        upgrade_obj.visible = false;
    }
    
    var clicked = mouse_check_button_released(mb_left);
    if (on_upgrade && clicked && money >= upgrade_obj.cost && upgrade_level < 5) {
        money -= upgrade_obj.cost;
        upgrade_level++;
        
        max_stat += increment; // Modify local copy
        
        upgrade_obj.cost++;
		
    }
    
    return max_stat; // Return the modified value
}

// Handles asteroid spawning
function handle_asteroid_spawning() {
    asteroid_spawn_timer -= dt_sec;
    if (asteroid_spawn_timer <= 0) {
        asteroid_spawn_timer = 1;
        if (random(1) < 0.5) {
            spawn_asteroid(rocket_ref.y);
        }
    }
}

// Resets game state after falling
function reset_after_fall() {
    set_state(GAME_STATE.UPGRADE);
    countdown_timer_current = countdown_timer_max;
    rocket_ref.reset();
    destroy_all_of_type(obj_star);
    destroy_all_of_type(obj_junk);
    destroy_all_of_type(obj_asteroid);
    camera_set_view_pos(cam, 0, rocket_ref.y - 675);
    cam_speed = rocket_ref.speed_max * 1.5;
    set_upgrade_ui_visibility(true);
}

// Updates the camera position
function update_camera() {
    var desiredY = rocket_ref.y - 675;
    var currentY = camera_get_view_y(cam);
    var ypsilon = lerp(currentY, desiredY, cam_speed * dt_sec);
    
    if (rocket_ref.speed >= 0 && current_state != GAME_STATE.VICTORY) {
        camera_set_view_pos(cam, 0, ypsilon);
    } else {
        if (cam_speed > 0) {
            cam_speed -= dt_sec * 10;
            cam_speed = max(cam_speed, 0);
        }
        camera_set_view_pos(cam, 0, ypsilon);
    }
}

// Draw upgrade options for a specific upgrade
function draw_upgrade_option(upgrade_obj, label, cost, upgrade_level) {
    if (upgrade_level < 5) {
        draw_text(upgrade_obj.x, upgrade_obj.y - 10, label);
        draw_text(upgrade_obj.x, upgrade_obj.y + 10, "$" + string(cost));
    }
}

// Draw the countdown timer
function draw_countdown() {
    for (var i = 5; i > 0; i--) {
        if (countdown_timer_current < i) {
            draw_centered_text((360 - (20 + i * 50)), 15850, string(i) + "...");
        }
    }
}

// Draw the fuel meter based on current fuel levels
function draw_fuel_meter() {
    var meter_height = sprite_get_height(spr_fuel_meter);
    var fuel_ratio = rocket_ref.fuel_current / rocket_ref.fuel_max;
    var draw_height = meter_height * fuel_ratio;
    var missing_y = meter_height - draw_height;
    var draw_y = sprite_get_yoffset(spr_fuel_meter) + (meter_height - draw_height);

    draw_sprite_part(spr_fuel_meter, 0, 0, meter_height - draw_height, sprite_get_width(spr_fuel_meter), draw_y, 10, camera_get_view_y(cam) + 485 + missing_y);
}

// Draw progress with mini rocket
function draw_progress() {
    draw_sprite(spr_progress, 0, room_width - 30, camera_get_view_y(cam) + 685);
    var ypos = (camera_get_view_y(cam) + 685) - (rocket_ref.height / 110);
    draw_sprite(spr_mini_rocket, 0, room_width - 30, ypos);
}

// Draw speedometer
function draw_speedometer() {
	
	var min_speed = 0;
	var max_speed = 8;
	var min_angle = 120;
	var max_angle = -120;
	
	var current_angle = 0;
	
	if (current_state == GAME_STATE.COUNTDOWN) {
		current_angle = calculate_angle(rocket_ref.start_boost_current, min_speed, max_speed, min_angle, max_angle);	
	}
	else if (current_state == GAME_STATE.TAKEOFF) {
		current_angle = calculate_angle(rocket_ref.speed, min_speed, max_speed, min_angle, max_angle);
	}
	
	// Draw speedometer background
	draw_sprite(spr_spedometer_bg, 0, 78, camera_get_view_y(cam) + 665);
	// Draw arm
	draw_sprite_ext(spr_spedometer_arm, 0, 78, camera_get_view_y(cam) + 665, 1, 1, current_angle, c_white, 1);
}

// Helper function to calculate the angle based on speed
function calculate_angle(speed, min_speed, max_speed, min_angle, max_angle) {
    return ((speed - min_speed) / (max_speed - min_speed)) * (max_angle - min_angle) + min_angle;
}