import core.thread;

import std.stdio;
import std.conv;
import std.concurrency;

import gl3n.linalg;
import nice.curses;

import space;
import body_;
import rectangle;

// TODO: Move the example to an `example/` folder
void main() {
	auto world = new Space(vec3(0, 1, 0), vec3(0, 0, 0), vec3(0, 0, 0), -1);
	auto entity = new Body(vec3(0, 0, 0), vec3(0, 0, 0), new Rectangle(4, 4, 4));
	world.bodyList ~= entity;

	new Thread({
		// World Thread
		world.mainLoop(7, true);
		Thread.sleep(10.msecs);
	}).start();

	new Thread({
		Curses.Config cfg = { cursLevel:0 };
		auto curses = new Curses(cfg);
		// Curses Thread
		auto window = curses.newWindow(10, 40, 0, 0);

		while (true) {
			window.erase();

			window.box('|', '-');
			window.addch(roundTo!int(entity.position.y) + 1, roundTo!int(entity.position.x) + 1, '#');

			window.refresh;
			curses.update;
			curses.nap(10);
		}
	}).start();
}
