import gl3n.linalg;

import shape;
import renderer;

class Rectangle : Shape {
    vec3 size;

    this(vec3 size) {
        this.size = size;
        this.volume = size.z * size.x * size.y;
    }

    override void render(Renderer renderer) {
        auto x = this.body_.position.x + this.position.x;
        auto y = this.body_.position.y + this.position.y;

        renderer.begin();

        renderer.vertex(x, y);
        renderer.vertex(x + this.size.x, y);
        renderer.vertex(x + this.size.x, y + this.size.y);
        renderer.vertex(x, y + this.size.y);

        renderer.end();
    }
}
