module path;

import gl3n.linalg;
import gl3n.interpolate;

import primitive;
import body_;

class Path : Primitive {
    Body[] bodyList;

    vec3[] pointList;

    int currentPoint;
    int nextPoint;

    float speed;

    this(float speed) {
        this.speed = speed;

        this.nextPoint = 1;
    }

    override void update(float delta) {
        foreach (body_; this.bodyList) {
            body_.position = interp(this.pointList[this.currentPoint], this.pointList[this.nextPoint], this.speed * delta);
        }

        if (this.nextPoint < this.pointList.length - 1) {
            this.currentPoint++;
            this.nextPoint++;
        }
        else {
            this.currentPoint = 0;
            this.nextPoint = 1;
        }
    }
}
