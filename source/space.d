import std.algorithm.iteration;
import std.datetime;
import std.stdio;

import gl3n.linalg;

import primitive;
import body_;
import renderer;

class Space : Primitive {
    Primitive[] primitiveList;

    Body[] bodyList;
    void delegate() resetFunction;

    vec3 gravity;
    vec3 positional_drag;
    vec3 angular_drag;
    float sleep_time;

    bool run = true;

    long last_time;

    this(vec3 gravity, vec3 positional_drag, vec3 angular_drag, float sleep_time) {
        this.resetFunction = {};

        this.gravity = gravity;
        this.positional_drag = positional_drag;
        this.angular_drag = angular_drag;
        this.sleep_time = sleep_time;

        this.last_time = Clock.currStdTime();
    }

    override void update(float delta) {
        foreach (i; this.primitiveList) {
            i.update(delta);
        }

        foreach (body_; this.bodyList) {
            if (body_.is_awake) {
                auto weight = body_.mass * this.gravity * delta;
                auto density = body_.mass / sum(map!(shape => shape.volume)(body_.shapeList));

                body_.force += this.gravity;
                writeln("Weight: ", weight, " Density: ", density, ", Force: ", body_.force);
                auto velocity = density * body_.force * delta;
                writeln("Velocity: ", velocity);

                auto drag = vec3(
                    density * (velocity.x * velocity.x) * delta,
                    density * (velocity.y * velocity.y) * delta,
                    density * (velocity.z * velocity.z) * delta,
                ) / 2;
                body_.force -= drag;
                writeln("Drag: ", drag);

                body_.position += velocity;
            }
        }
    }

    override void render(Renderer renderer) {
        foreach (i; this.primitiveList) {
            i.render(renderer);
        }

        foreach (body_; this.bodyList) {
            foreach (shape; body_.shapeList) {
                shape.render(renderer);
            }
        }
    }
}
