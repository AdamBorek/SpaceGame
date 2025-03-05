if (game_manager_ref.current_state == GAME_STATE.TAKEOFF) {
	
	// Change the sprite to the one without flames and change the state
	sprite_index = spr_rocket;
	game_manager_ref.set_state(GAME_STATE.FALLING);
	
}