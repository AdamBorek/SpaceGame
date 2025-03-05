if (game_manager_ref.current_state == GAME_STATE.TAKEOFF) {
    // Boost speed and replenish fuel
    speed = speed_max * boost;
    fuel_current = min(fuel_current + fuel_max * 0.05, fuel_max);

    // Destroy the other instance (star)
    instance_destroy(other);
}