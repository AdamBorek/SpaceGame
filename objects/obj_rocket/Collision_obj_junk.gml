if (game_manager_ref.current_state == GAME_STATE.TAKEOFF || game_manager_ref.current_state == GAME_STATE.FALLING) {
	
	// Give money
	game_manager_ref.money++;

	// Destroy the junk
	instance_destroy(other);	
	
}