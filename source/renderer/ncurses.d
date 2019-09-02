module renderer.ncurses;

import std.conv;

import nice.curses;

import renderer;
import util.colour;

class NCurses : Renderer {
    float scale = 1f;
    Window window;
    int width;
    int height;

    this(Window window, int width, int height) {
        this.window = window;
        this.width = width;
        this.height = height;
    }

    override void begin(bool filled = true) {
    }

    override void end() {
    }

    override void vertex(float x, float y) {
        this.window.addch(this.height / 2 + roundTo!int(y) - roundTo!int(y) / 2, this.width / 2 + roundTo!int(x) - roundTo!int(x) / 2, '#');
    }

    override void colour(Colour colour) {
    }
}
