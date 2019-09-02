import core.thread;

import std.stdio;
import std.conv;
import std.concurrency;

import gl3n.linalg;

import bindbc.glfw;
import bindbc.opengl;

import nice.curses;

import space;
import body_;
import shape.rectangle;
import shape.polygon;
import renderer.opengl;
import renderer.ncurses;
import path;

// TODO: Move the example to an `example/` folder
void main() {
	auto world = new Space(vec3(0, 0, 0), vec3(0, 0, 0), vec3(0, 0, 0), -1);

	// auto path = new Path(vec3(0, 0, 0), 0.02f, new Polygon(vec3(4, 8, 6), 64));
	// world.primitiveList ~= path;

	auto entity = new Body(vec3(0, 0, 0), vec3(0, 0, 0), new Rectangle(vec3(4, 4, 4)));
	entity.space = world;
	// world.resetFunction = { entity.force = vec3(0, 0, 0); };
	world.bodyList ~= entity;
	// path.bodyList ~= entity;

	auto ground = new Body(vec3(0, 10, 0), vec3(0, 0, 0), new Rectangle(vec3(12, 1, 1)));
	ground.space = world;
	ground.mass = 0;
	world.bodyList ~= ground;

	auto run = true;

	new Thread({
		// World Thread
		while (run) {
			world.update(1f);
			Thread.sleep(40.msecs);
		}
	}).start();

	new Thread({
		// GLFW/OpenGL Thread
		auto glfwLib = loadGLFW();
		if (glfwLib != GLFWSupport.glfw33) {
			if (glfwLib == GLFWSupport.noLibrary) {
				writeln("Failed to load GLFW!");
			}
			else if (GLFWSupport.badLibrary) {
				writeln("Failed to load all symbols in GLFW!");
			}
		}

		if (!glfwInit()) {
			writeln("GLFW was not initialized!");
		}

		auto window = glfwCreateWindow(640, 480, "FishSuck Demo", null, null);
		if (!window) {
			const(char)* description;
			int code = glfwGetError(&description);
			printf("Error: %s", description);
			glfwTerminate();
		}

	    glfwMakeContextCurrent(window);

		auto openGLLib = loadOpenGL();

	    glViewport(0, 0, 640, 480);
	    glShadeModel(GL_SMOOTH);
	    glMatrixMode(GL_PROJECTION);
	    glLoadIdentity();
		glOrtho(-1, 1, 1, -1, -1, 1);
	    glMatrixMode(GL_MODELVIEW);

		auto renderOpenGL = new renderer.opengl.OpenGL();

	    while (!glfwWindowShouldClose(window)) {
			glClearColor(0.25, 0.25, 0.25, 1);

	        glClear(GL_COLOR_BUFFER_BIT);
        	glMatrixMode(GL_MODELVIEW);

			world.render(renderOpenGL);

	        glfwSwapBuffers(window);
	        glfwPollEvents();
	    }

		run = false;
	    glfwTerminate();
	}).start();

	new Thread({
		// Curses Thread
		Curses.Config cfg = { cursLevel: 0 };
		auto curses = new Curses(cfg);
		auto window = curses.newWindow(20, 40, 0, 0);

		auto renderNCurses = new renderer.ncurses.NCurses(window, 40, 20);

		while (run) {
			window.erase();

			window.box('|', '-');
			world.render(renderNCurses);

			window.refresh;
			curses.update;
		}
	}).start();
}
