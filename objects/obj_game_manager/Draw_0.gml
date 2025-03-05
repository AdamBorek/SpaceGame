
// Main draw logic
setup_draw(fnt_bitfont_small, c_black, fa_middle, fa_center, 1);

switch (current_state) {
    case GAME_STATE.START:
        draw_centered_text(180, 15750, "Tap space to take off...");
        draw_centered_text(180, 15800, "(and keep tapping to earn some boost!)");
        break;

    case GAME_STATE.UPGRADE:
        setup_draw(fnt_bitfont_big, c_black, fa_middle, fa_center, 1);
        var upgrade_speed = instance_find(obj_upgrade_speed, 0);
        var upgrade_boost = instance_find(obj_upgrade_boost, 0);
        var upgrade_fuel = instance_find(obj_upgrade_fuel, 0);
        var upgrade_bg = instance_find(obj_upgrade_big_bg, 0);

        draw_upgrade_option(upgrade_speed, "Speed", upgrade_speed.cost, rocket_ref.speed_upgrade);
        draw_upgrade_option(upgrade_boost, "Boost", upgrade_boost.cost, rocket_ref.boost_upgrade);
        draw_upgrade_option(upgrade_fuel, "Fuel", upgrade_fuel.cost, rocket_ref.fuel_upgrade);

        draw_centered_text(upgrade_bg.x, upgrade_bg.y - 80, "Upgrades");
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_text(upgrade_bg.x - upgrade_bg.sprite_width / 2, upgrade_bg.y + upgrade_bg.sprite_height / 2, "$" + string(money));
        break;

    case GAME_STATE.COUNTDOWN:
        draw_countdown();
		draw_speedometer();
        break;

    case GAME_STATE.TAKEOFF:
        draw_fuel_meter();
        draw_progress();
		draw_speedometer();
        break;
}
