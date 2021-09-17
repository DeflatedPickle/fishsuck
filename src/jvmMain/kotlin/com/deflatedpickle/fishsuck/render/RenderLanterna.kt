package com.deflatedpickle.fishsuck.render

import com.deflatedpickle.bellatrix.Vec3d
import com.deflatedpickle.fishsuck.backend.Space
import com.deflatedpickle.fishsuck.api.render.Model
import com.deflatedpickle.fishsuck.api.render.Render
import com.googlecode.lanterna.input.KeyStroke
import com.googlecode.lanterna.input.KeyType
import com.googlecode.lanterna.terminal.DefaultTerminalFactory
import kotlin.math.roundToInt
import kotlin.properties.Delegates

class RenderLanterna(
    val space: Space
) : Render {
    private val terminal = DefaultTerminalFactory().createTerminal()

    private var width by Delegates.notNull<Int>()
    private var height by Delegates.notNull<Int>()

    override fun open(width: Int, height: Int) {
        terminal.enterPrivateMode()

        terminal.terminalSize.let {
            this.width = it.columns
            this.height = it.rows
        }
    }

    override fun render() {
        while (terminal.pollInput() != KeyStroke(KeyType.EOF)) {
            // terminal.clearScreen()

            for (i in space.children) {
                Model.registry[i::class]?.render(i, this)
            }

            terminal.flush()
        }
    }

    override fun destroy() {
        terminal.exitPrivateMode()
    }

    override fun vertex(vec3d: Vec3d) {
        terminal.setCursorPosition(
            width / 2 + (vec3d.x - vec3d.x).roundToInt() / 2,
            height / 2 + (vec3d.y - vec3d.y).roundToInt() / 2,
        )
        terminal.putCharacter('#')
    }
}