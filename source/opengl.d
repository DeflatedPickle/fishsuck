import bindbc.opengl;

import renderer;

class OpenGL : Renderer {
    float scale = 0.1f;

    override void begin() {
        glBegin(GL_POLYGON);
    }

    override void end() {
        glEnd();
    }

    override void vertex(float x, float y) {
        glVertex2f(x * this.scale, y * this.scale);
    }
}
