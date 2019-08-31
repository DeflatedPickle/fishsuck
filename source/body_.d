import std.uuid;

import gl3n.linalg;

import primitive;
import shape;
import path;
import renderer;

class Body : Primitive {
    Shape[] shapeList;

    auto is_awake = true;

    float mass = 1f;
    vec3 moment_of_inertia = vec3(0, 0, 0);
    vec3 centre_of_gravity = vec3(0, 0, 0);

    vec3 force = vec3(0, 0, 0);
    vec3 torque = vec3(0, 0, 0);

    vec3 initial_position;
    vec3 initial_rotation;

    UUID uuid;

    this(vec3 position, vec3 rotation, Shape[] shapeList...) {
        this.initial_position = position;
        this.initial_rotation = rotation;
        this.reset();

        foreach (shape; shapeList) {
            shape.primitive = this;
            this.shapeList ~= shape;
        }

        this.uuid = randomUUID();
    }

    override void reset() {
        this.position = this.initial_position;
        this.rotation = this.initial_rotation;

        this.force = vec3(0, 0, 0);
        this.torque = vec3(0, 0, 0);
    }

    override void render(Renderer renderer) {
        foreach (shape; this.shapeList) {
            renderer.begin();
            shape.render(renderer);
        }
    }
}
