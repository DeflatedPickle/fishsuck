import gl3n.linalg;

import shape;

class Body {
    Shape[] shapeList;

    auto is_awake = true;

    float mass = 1f;
    vec3 moment_of_inertia = vec3(0, 0, 0);
    vec3 centre_of_gravity = vec3(0, 0, 0);

    vec3 position;
    vec3 rotation;

    vec3 force = vec3(0, 1, 0);
    vec3 torque = vec3(0, 0, 0);

    vec3 initial_position;
    vec3 initial_rotation;

    this(vec3 position, vec3 rotation, Shape[] shapeList...) {
        this.initial_position = position;
        this.initial_rotation = rotation;
        this.reset();

        foreach (shape; shapeList) {
            shape.body_ = this;
            this.shapeList ~= shape;
        }
    }

    void reset() {
        this.position = this.initial_position;
        this.rotation = this.initial_rotation;
    }
}