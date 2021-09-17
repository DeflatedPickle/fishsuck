package com.deflatedpickle.fishsuck.render

import com.deflatedpickle.bellatrix.Vec3d
import com.deflatedpickle.fishsuck.backend.Space
import com.deflatedpickle.fishsuck.api.render.Render
import io.webfolder.curses4j.Curses.KEY_EOL
import io.webfolder.curses4j.Curses.endwin
import io.webfolder.curses4j.Curses.getch
import io.webfolder.curses4j.Curses.initscr
import io.webfolder.curses4j.Curses.newwin
import io.webfolder.curses4j.Curses.refresh
import io.webfolder.curses4j.Window
import kotlin.math.roundToInt
import kotlin.properties.Delegates


class RenderCurses(
    val space: Space
) : Render {
    private lateinit var window: Window

    private var width by Delegates.notNull<Int>()
    private var height by Delegates.notNull<Int>()

    override fun open(width: Int, height: Int) {
        this.width = width
        this.height = height

        initscr()
        window = newwin(width, height, 0, 0)
    }

    override fun render() {
        while (getch() != KEY_EOL) {
            refresh()
        }
    }

    override fun destroy() {
        endwin()
    }

    override fun vertex(vec3d: Vec3d) {
        window.mvaddch(
            height / 2 + (vec3d.y - vec3d.y).roundToInt() / 2,
            width / 2 + (vec3d.x - vec3d.x).roundToInt() / 2,
            '#'
        )
    }
}