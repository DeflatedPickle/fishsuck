module shape.polygon;

import std.math;

import gl3n.linalg;

import shape;
import renderer;

class Polygon : Shape {
    int edges;

    this(vec3 scale, int edges) {
        this.scale = scale;
        this.edges = edges;

        foreach (i; 0..this.edges) {
            auto theta = 2f * PI * i / this.edges;

            auto x = this.scale.x * cos(theta);
            auto y = this.scale.y * sin(theta);
            // TODO: Z-axis

            this.pointList ~= vec3(x, y, 0);
        }
    }
}
