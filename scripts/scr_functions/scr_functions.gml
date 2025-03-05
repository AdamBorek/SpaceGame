
// Function to generate multiple instances of an object at random positions
function generate_instance_random(object, min_height, max_height, density) {
    for (var i = 0; i < density; i++) {
        var randX = random_range(20, 340);
        var randY = random_range(min_height, max_height);
        instance_create_layer(randX, randY, "Instances", object);
    }
}

// Function to spawn an asteroid near the rocket
function spawn_asteroid(rocket_y) {
    var randX = irandom_range(-20, 380);
    var randY = rocket_y - 800;
    
    // Create asteroid and assign random sprite and direction
    var asteroid = instance_create_layer(randX, randY, "Instances", obj_asteroid);
    asteroid.sprite_index = choose(spr_asteroid1, spr_asteroid2);
    asteroid.direction = irandom_range(200, 340);
    asteroid.speed = irandom_range(1, 3);
}

// Spawns objects (e.g. junk, stars) in a range
function spawn_objects(starting, ending, amount, obj1, obj2) {
    var increment = (starting - ending) / amount;
    for (var i = 0; i < amount; i++) {
        var current = starting - i * increment;
        generate_instance_random(obj1, current, current - increment, 1);
        generate_instance_random(obj2, current, current - increment, 1);
    }
}

function destroy_all_of_type(obj_type) {
    // Get the first instance of the specified object type
    var inst = instance_find(obj_type, 0);
    
    // While there is an instance of the object type
    while (inst != noone) {
        // Destroy the instance
        instance_destroy(inst);
        
        // Get the next instance of the object type
        inst = instance_find(obj_type, 0);
    }
}

// Checks if the mouse is over an object
function is_mouse_over(obj) {
    return mouse_x > obj.bbox_left && mouse_x < obj.bbox_right &&
           mouse_y > obj.bbox_top && mouse_y < obj.bbox_bottom;
}

// Setup common drawing settings
function setup_draw(font, color, valign, halign, alpha) {
    draw_set_font(font);
    draw_set_color(color);
    draw_set_valign(valign);
    draw_set_halign(halign);
    draw_set_alpha(alpha);
}

// Draw text with automatic alignment
function draw_centered_text(x, y, text) {
    draw_text(x, y, text);
}