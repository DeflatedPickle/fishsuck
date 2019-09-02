module renderer.opengl;

import bindbc.opengl;

import renderer;
import util.colour;

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

    override void colour(Colour colour) {
        switch (colour) {
            case Colour.WHITE:
                glColor3f(1f, 1f, 1f);
                break;
            case Colour.RED:
                glColor3f(1f, 0f, 0f);
                break;
            default:
                break;
        }
    }
}
