include <../basic_forms/math_forms.scad>

module br_name(size = 10, height = 2, split_line = false) {
    linear_extrude(height = height) {
        if(split_line) {
            ci_text("B   LTIC", size);
            letter_a(0.9 * size, size);
            translate([-size/10, -size * 1.3, 0]) {
                ci_text("ROCKS", size);
            }
        } else {
            ci_text("B   LTIC ROCKS", size);
            letter_a(3.24 * size, size);
        }
    }
}

module br_logo(size = 10, height = 2, name = true, slogan = true) {
    width = size * 0.15;
    width_bias = 0.56;
    size_bias = 0.049;
    union() {
        difference() {
            equal_triangle(length = size, height = height);
            // cut away next to trianlge
            translate([-size/1.5,0,0]) {
                difference() {
                    equal_triangle(length = size*2, height = height);
                    equal_triangle(length = size*2 - size/3, height = height);
                }
            }
            // cut away the top
            bigger_width = width * 10;
            translate([-size*(16.94 * size_bias),size*size_bias,0]) {
                parallelogram(width = bigger_width, length = bigger_width, height = height, distortion = bigger_width * width_bias);
            }
            // cut away the inside
            translate([size*size_bias,-size*(3.5 * size_bias),0]) {
                parallelogram(width = width, length = width, height = height, distortion = width * width_bias);
            }
        }
        // print text
        logo_text(size,height,name,slogan);
    }
}

module logo_text(size, height, name, slogan) {
    if(name || slogan) {
        linear_extrude(height = height) {
            y_translate = - size / 3;
            font_size = size / 10;
            if (name) {
                translate([0, y_translate, 0]) {
                    ci_text("B   LTIC ROCKS", font_size);
                    letter_a(3.24 * font_size, font_size);
                }
            }
            if (slogan) {
                slogan_size = font_size * 0.6;
                translate([0, name ? y_translate - font_size : y_translate, 0]) {
                    ci_text("  UGMENTED CLIMBING", slogan_size);
                    letter_a(6.88 * slogan_size, slogan_size);
                }
            }
        }
    }
}

module letter_a(left_correction, font_size) {
    upper_correction_bias = 40;
    rotate(180) {
        translate([left_correction, -font_size / upper_correction_bias, 0]) {
            ci_text("V", font_size);
        }
    }
}

module ci_text(content, font_size, font_detail = 50) {
    text(content, font="Roboto:style=Black Italic", size=font_size, halign = "center", valign="center", $fn=font_detail);
}
