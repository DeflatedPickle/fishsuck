import gl3n.linalg;

import body_;
import renderer;

class Space {
    Body[] bodyList;

    vec3 gravity;
    vec3 positional_drag;
    vec3 angular_drag;
    float sleep_time;
    // TODO: Could be a list
    Renderer renderer;

    this(vec3 gravity, vec3 positional_drag, vec3 angular_drag, float sleep_time, Renderer renderer) {
        this.gravity = gravity;
        this.positional_drag = positional_drag;
        this.angular_drag = angular_drag;
        this.sleep_time = sleep_time;
        this.renderer = renderer;
    }

    void mainLoop(int max_steps = -1, bool loop = false) {
        int counter;

        while (true) {
            // TODO: Proper delta time
            auto delta = 1f;

            foreach (body_; this.bodyList) {
                if (body_.is_awake) {
                    auto acceleration = body_.force / body_.mass;

                    auto velocity = vec3(
                        (acceleration.x * this.gravity.x) * delta,
                        (acceleration.y * this.gravity.y) * delta,
                        (acceleration.z * this.gravity.z) * delta
                    );
                    body_.position += velocity;
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
