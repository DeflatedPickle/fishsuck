module shape.rectangle;

import gl3n.linalg;
import gl3n.aabb;

import shape;
import renderer;

class Rectangle : Shape {
    this(vec3 size) {
        this.size = size;
        this.volume = size.z * size.x * size.y;
        this.bounding_box = AABB(this.position, this.size);
    }

    override void render(Renderer renderer) {
        auto x = this.body_.position.x + this.position.x - this.size.x / 2;
        auto y = this.body_.position.y + this.position.y - this.size.y / 2;

        renderer.begin();

        renderer.vertex(x, y);
        renderer.vertex(x + this.size.x, y);
        renderer.vertex(x + this.size.x, y + this.size.y);
        renderer.vertex(x, y + this.size.y);

        renderer.end();
    }
}
