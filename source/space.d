import std.algorithm.iteration;
import std.datetime;

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
            body_.update(delta);
        }
    }

    override void render(Renderer renderer) {
        foreach (i; this.primitiveList) {
            i.render(renderer);
        }

        foreach (body_; this.bodyList) {
            body_.render(renderer);
        }
    }
}
