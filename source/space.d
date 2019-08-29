import std.algorithm.iteration;
import std.datetime;
import std.stdio;

import gl3n.linalg;

import primitive;
import body_;
import renderer;

class Space {
    Primitive[] primitiveList;

    Body[] bodyList;
    void delegate() resetFunction;

    vec3 gravity;
    vec3 positional_drag;
    vec3 angular_drag;
    float sleep_time;
    // TODO: Could be a list
    Renderer renderer;

    bool run = true;

    long last_time;

    this(vec3 gravity, vec3 positional_drag, vec3 angular_drag, float sleep_time, Renderer renderer) {
        this.resetFunction = {};

        this.gravity = gravity;
        this.positional_drag = positional_drag;
        this.angular_drag = angular_drag;
        this.sleep_time = sleep_time;
        this.renderer = renderer;

        this.last_time = Clock.currStdTime();
    }

    void mainLoop(float step_time = 1f, int max_steps = -1, bool loop = false) {
        if (loop) {
            this.resetFunction();
        }

        int counter;
        float time_tick = 0f;

        while (this.run) {
            auto this_time = Clock.currStdTime();

            auto delta = 1f; // (this_time - last_time);
            time_tick += delta;

            if (time_tick >= step_time) {
                time_tick = 0;

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

                        auto acceleration = velocity / step_time;
                        writeln("Acceleration: ", acceleration);

                        auto drag = vec3(
                            density * (velocity.x * velocity.x) * delta,
                            density * (velocity.y * velocity.y) * delta,
                            density * (velocity.z * velocity.z) * delta,
                        ) / 2;
                        body_.force -= drag;
                        writeln("Drag: ", drag);

                        body_.position += acceleration;
                    }
                }
                last_time = Clock.currStdTime();
            }

            if (max_steps > -1) {
                counter++;

                if (counter >= max_steps) {
                    if (loop == false) {
                        break;
                    }
                    else {
                        counter = 0;
                        foreach (body_; this.bodyList) {
                            body_.reset();
                        }
                        this.resetFunction();
                    }
                }
            }
        }
    }

    void render() {
        foreach (i; this.primitiveList) {
            i.render(this.renderer);
        }

        foreach (body_; this.bodyList) {
            foreach (shape; body_.shapeList) {
                shape.render(this.renderer);
            }
        }
    }
}
