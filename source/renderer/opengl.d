module renderer.opengl;

import bindbc.opengl;

import renderer;

class OpenGL : Renderer {
    float scale = 0.1f;

    override void begin(bool filled = true) {
        if (filled) {
            glBegin(GL_POLYGON);
        }
        else {
            glBegin(GL_LINE_LOOP);
        }
    }

    override void end() {
        glEnd();
    }

    override void vertex(float x, float y) {
        glVertex2f(x * this.scale, y * this.scale);
    }
}
