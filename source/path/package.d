module path;

import gl3n.linalg;
import gl3n.interpolate;

import shape;
import primitive;
import body_;
import renderer;

class Path : Primitive {
    Body[] bodyList;

    int currentPoint;
    int nextPoint;

    float speed;

    Shape shape;

    this(vec3 position, float speed, Shape shape) {
        this.position = position;
        this.speed = speed;
        this.shape = shape;

        this.nextPoint = 1;

        this.shape.primitive = this;
    }

    override void update(float delta) {
        foreach (body_; this.bodyList) {
            body_.position = interp(this.position + this.shape.pointList[this.currentPoint], this.position + this.shape.pointList[this.nextPoint], this.speed * delta);
        }

        if (this.nextPoint < this.shape.pointList.length - 1) {
            this.currentPoint++;
            this.nextPoint++;
        }
        else {
            this.currentPoint = 0;
            this.nextPoint = 1;
        }
    }

    override void render(Renderer renderer) {
        renderer.begin(false);
        this.shape.render(renderer);
    }
}
