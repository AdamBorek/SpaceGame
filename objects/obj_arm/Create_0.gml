rocket_ref = instance_find(obj_rocket, 0);
cam = view_camera[0];

// Helper function to calculate the angle based on speed
function calculate_angle(speed, min_speed, max_speed, min_angle, max_angle) {
    return ((speed - min_speed) / (max_speed - min_speed)) * (max_angle - min_angle) + min_angle;
}