module shape;

import gl3n.linalg;
import gl3n.aabb;

import primitive;
import renderer;

class Shape : Primitive {
    auto is_solid = true;

    AABB bounding_box;

    vec3 position = vec3(0, 0, 0);
    vec3 rotation = vec3(0, 0, 0);
    vec3 scale = vec3(0, 0, 0);

    float volume;

    Primitive primitive;

    vec3[] pointList;

    override void render(Renderer renderer) {
        foreach (point; this.pointList) {
            renderer.vertex(this.primitive.position.x + point.x, this.primitive.position.y + point.y);
        }

        renderer.end();
    }
}
