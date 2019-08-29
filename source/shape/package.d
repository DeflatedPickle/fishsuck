module shape;

import gl3n.linalg;
import gl3n.aabb;

import primitive;
import body_;
import renderer;

class Shape : Primitive {
    auto is_solid = true;

    AABB bounding_box;

    vec3 position = vec3(0, 0, 0);
    vec3 rotation = vec3(0, 0, 0);

    float volume;

    Body body_;

    vec3 size;
}
