import std.uuid;

import std.algorithm;

import gl3n.linalg;

import sat;

import primitive;
import shape;
import path;
import renderer;

class Body : Primitive {
    Shape[] shapeList;
    sat.Polygon collision_mask;

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

        vec2[] vertices;
        foreach (shape; shapeList) {
            shape.primitive = this;
            this.shapeList ~= shape;

            foreach (vertex; shape.pointList) {
                vertices ~= vec2(vertex.x, vertex.y);
            }
        }

        this.collision_mask = Polygon(vertices);

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
