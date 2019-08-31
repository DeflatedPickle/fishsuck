module shape.rectangle;

import gl3n.linalg;
import gl3n.aabb;

import shape;
import renderer;

class Rectangle : Shape {
    this(vec3 scale) {
        this.scale = scale;
        this.volume = this.scale.z * this.scale.x * this.scale.y;

        auto x = this.position.x - this.scale.x / 2;
        auto y = this.position.y - this.scale.y / 2;

        this.pointList ~= vec3(x, y, 0);
        this.pointList ~= vec3(x + this.scale.x, y, 0);
        this.pointList ~= vec3(x + this.scale.x, y + this.scale.y, 0);
        this.pointList ~= vec3(x, y + this.scale.y, 0);
    }
}
