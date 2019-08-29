module path.polygon;

import std.math;

import gl3n.linalg;

import path;
import renderer;

class Polygon : Path {
    int edges;

    this(float speed, vec3 position, vec3 scale, int edges) {
        this.position = position;
        this.scale = scale;
        this.edges = edges;

        foreach (i; 0..this.edges) {
            auto theta = 2f * PI * i / this.edges;

            auto x = this.scale.x * cos(theta);
            auto y = this.scale.y * sin(theta);
            // TODO: Z-axis

            pointList ~= vec3(x, y, 0);
        }

        super(speed);
    }

    override void render(Renderer renderer) {
        renderer.begin(false);

        foreach (point; this.pointList) {
            renderer.vertex(point.x, point.y);
        }

        renderer.end();
    }
}
