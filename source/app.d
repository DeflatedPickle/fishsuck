import core.thread;

import std.stdio;
import std.conv;
import std.concurrency;

import gl3n.linalg;

import bindbc.glfw;
import bindbc.opengl;

import space;
import body_;
import rectangle;
import opengl;

// TODO: Move the example to an `example/` folder
void main() {
	auto world = new Space(vec3(0, 1, 0), vec3(0, 0, 0), vec3(0, 0, 0), -1, new OpenGL());
	auto entity = new Body(vec3(0, 0, 0), vec3(0, 0, 0), new Rectangle(vec3(4, 4, 4)));
	world.bodyList ~= entity;

	new Thread({
		// World Thread
		world.mainLoop(40, true);
	}).start();

	new Thread({
		// GLFW/OpenGL Thread
		auto glfwLib = loadGLFW();
		if (glfwLib != GLFWSupport.glfw33) {
		    if(glfwLib == GLFWSupport.noLibrary) {
				writeln("Failed to load GLFW!");
		    }
		    else if(GLFWSupport.badLibrary) {
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
	    glMatrixMode(GL_MODELVIEW);

	    while (!glfwWindowShouldClose(window)) {
			glClearColor(0.25, 0.25, 0.25, 1);

	        glClear(GL_COLOR_BUFFER_BIT);
        	glMatrixMode(GL_MODELVIEW);

			world.render();

	        glfwSwapBuffers(window);
	        glfwPollEvents();
	    }

	    glfwTerminate();
	}).start();
}