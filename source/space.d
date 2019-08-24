import gl3n.linalg;

import body_;

class Space {
    Body[] bodyList;

    vec3 gravity;
    vec3 positional_drag;
    vec3 angular_drag;
    float sleep_time;

    this(vec3 gravity, vec3 positional_drag, vec3 angular_drag, float sleep_time) {
        this.gravity = gravity;
        this.positional_drag = positional_drag;
        this.angular_drag = angular_drag;
        this.sleep_time = sleep_time;
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
}
