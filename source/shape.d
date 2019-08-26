import gl3n.linalg;

import body_;
import renderer;

class Shape {
    auto is_solid = true;

    vec3 position = vec3(0, 0, 0);
    vec3 rotation = vec3(0, 0, 0);

    Body body_;

    void render(Renderer renderer) {
    }
}
