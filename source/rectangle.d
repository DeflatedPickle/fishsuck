import gl3n.linalg;

import shape;

class Rectangle : Shape {
    vec3 size;

    this(vec3 size) {
        this.size = size;
    }
}
