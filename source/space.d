import gl3n.linalg;

import body_;
import renderer;

class Space {
    Body[] bodyList;
    void delegate() resetFunction;

    vec3 gravity;
    vec3 positional_drag;
    vec3 angular_drag;
    float step_time;
    float sleep_time;
    // TODO: Could be a list
    Renderer renderer;

    this(vec3 gravity, vec3 positional_drag, vec3 angular_drag, float step_time, float sleep_time, Renderer renderer) {
        this.gravity = gravity;
        this.positional_drag = positional_drag;
        this.angular_drag = angular_drag;
        this.step_time = step_time;
        this.sleep_time = sleep_time;
        this.renderer = renderer;
    }

    void mainLoop(int max_steps = -1, bool loop = false) {
        if (loop) {
            this.resetFunction();
        }

        int counter;

        while (true) {
            // TODO: Proper delta time
            auto delta = 1f;

            foreach (body_; this.bodyList) {
                if (body_.is_awake) {
                    import std.stdio;

                    auto weight = body_.mass * this.gravity * delta;
                    auto density = body_.mass / body_.shapeList[0].volume * delta;

                    body_.force += this.gravity;
                    writeln("Weight: ", weight, " Density: ", density, ", Force: ", body_.force);
                    auto velocity = density * body_.force * delta;
                    writeln("Velocity: ", velocity);

                    auto acceleration = velocity / this.step_time;
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
        foreach (body_; this.bodyList) {
            foreach (shape; body_.shapeList) {
                shape.render(this.renderer);
            }
        }
    }
}
