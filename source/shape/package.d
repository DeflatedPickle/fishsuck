module shape;

import gl3n.linalg;
import gl3n.aabb;

import body_;
import render;

class Shape {
    auto is_solid = true;

    AABB bounding_box;

    vec3 position = vec3(0, 0, 0);
    vec3 rotation = vec3(0, 0, 0);

    float volume;

    Body body_;

    vec3 size;

    void render(Renderer renderer) {
    }
}
