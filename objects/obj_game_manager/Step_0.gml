switch (current_state) {
    case GAME_STATE.START:
        if (keyboard_check_pressed(vk_space)) {
            randomize();
            spawn_objects(13800, 2000, 9, obj_junk, obj_star);
            set_state(GAME_STATE.COUNTDOWN);
        }
        break;
    
    case GAME_STATE.UPGRADE:
        handle_upgrades();
		
        break;

    case GAME_STATE.COUNTDOWN:
        countdown_timer_current -= dt_sec;
        if (countdown_timer_current <= 0) {
            set_state(GAME_STATE.TAKEOFF);
            rocket_ref.speed = 0;
            rocket_ref.sprite_index = spr_rocket_takeoff;
        }
        show_debug_message("countdown timer: " + string(countdown_timer_current));
        break;

    case GAME_STATE.TAKEOFF:
        if (rocket_ref.fuel_current <= 0) {
            rocket_ref.sprite_index = spr_rocket;
            set_state(GAME_STATE.FALLING);
        } else if (rocket_ref.height > 7500) {
            handle_asteroid_spawning();
            if (rocket_ref.height >= victory_height) {
                set_state(GAME_STATE.VICTORY);
            }
        }
        break;
    
    case GAME_STATE.FALLING:
        if (rocket_ref.speed <= -15) {
            reset_after_fall();
        }
        break;

    case GAME_STATE.VICTORY:
        break;

    default:
        break;
}

// Camera behavior
update_camera();