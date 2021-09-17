package com.deflatedpickle.fishsuck.render

import com.deflatedpickle.fishsuck.backend.Space
import com.deflatedpickle.fishsuck.api.render.Model
import com.deflatedpickle.fishsuck.api.render.Render
import com.deflatedpickle.fishsuck.backend.util.Colour
import org.lwjgl.glfw.Callbacks.glfwFreeCallbacks
import org.lwjgl.glfw.GLFW.GLFW_FALSE
import org.lwjgl.glfw.GLFW.GLFW_RESIZABLE
import org.lwjgl.glfw.GLFW.glfwCreateWindow
import org.lwjgl.glfw.GLFW.glfwDefaultWindowHints
import org.lwjgl.glfw.GLFW.glfwDestroyWindow
import org.lwjgl.glfw.GLFW.glfwInit
import org.lwjgl.glfw.GLFW.glfwMakeContextCurrent
import org.lwjgl.glfw.GLFW.glfwPollEvents
import org.lwjgl.glfw.GLFW.glfwSetErrorCallback
import org.lwjgl.glfw.GLFW.glfwSetWindowSize
import org.lwjgl.glfw.GLFW.glfwSwapBuffers
import org.lwjgl.glfw.GLFW.glfwSwapInterval
import org.lwjgl.glfw.GLFW.glfwTerminate
import org.lwjgl.glfw.GLFW.glfwWindowHint
import org.lwjgl.glfw.GLFW.glfwWindowShouldClose
import org.lwjgl.glfw.GLFWErrorCallback
import org.lwjgl.opengl.GL.createCapabilities
import org.lwjgl.opengl.GL11.GL_COLOR_BUFFER_BIT
import org.lwjgl.opengl.GL11.GL_DEPTH_BUFFER_BIT
import org.lwjgl.opengl.GL11.GL_LINE_LOOP
import org.lwjgl.opengl.GL11.GL_MODELVIEW
import org.lwjgl.opengl.GL11.GL_POLYGON
import org.lwjgl.opengl.GL11.GL_PROJECTION
import org.lwjgl.opengl.GL11.GL_SMOOTH
import org.lwjgl.opengl.GL11.glBegin
import org.lwjgl.opengl.GL11.glClear
import org.lwjgl.opengl.GL11.glClearColor
import org.lwjgl.opengl.GL11.glColor4d
import org.lwjgl.opengl.GL11.glEnd
import org.lwjgl.opengl.GL11.glLoadIdentity
import org.lwjgl.opengl.GL11.glMatrixMode
import org.lwjgl.opengl.GL11.glOrtho
import org.lwjgl.opengl.GL11.glShadeModel
import org.lwjgl.opengl.GL11.glVertex3d
import org.lwjgl.opengl.GL11.glViewport
import org.lwjgl.system.MemoryUtil.NULL
import kotlin.properties.Delegates


class RenderGLFW(
    val space: Space
) : Render {
    private var handle by Delegates.notNull<Long>()
    private var scale = 0.1

    override fun open(width: Int, height: Int) {
        GLFWErrorCallback.createPrint(System.err).set()

        if (!glfwInit())
            throw IllegalStateException("Unable to initialize GLFW")

        glfwDefaultWindowHints()
        // glfwWindowHint(GLFW_VISIBLE, GLFW_FALSE)

        glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE)

        handle = glfwCreateWindow(100, 100, "", NULL, NULL)
        if ( handle == NULL )
            throw RuntimeException("Failed to create the GLFW window")

        glfwSetWindowSize(handle, width, height)
        glfwMakeContextCurrent(handle)
        glfwSwapInterval(1)
        // glfwShowWindow(handle)

        createCapabilities()

        glViewport(0, 0, width, height)
        glShadeModel(GL_SMOOTH)
        glMatrixMode(GL_PROJECTION)
        glLoadIdentity()
        glOrtho(
            -1.0, 1.0,
            -1.0, 1.0,
            -1.0, 1.0
        )
        glMatrixMode(GL_MODELVIEW)
        glLoadIdentity()
    }

    override fun render() {
        while (!glfwWindowShouldClose(handle)) {
            glClearColor(0.25f, 0.25f, 0.25f, 1f)

            glClear(GL_COLOR_BUFFER_BIT or  GL_DEPTH_BUFFER_BIT)
            glMatrixMode(GL_MODELVIEW)
            glLoadIdentity()

            for (i in space.children) {
                Model.registry[i::class]?.render(i, this)
            }

            glfwSwapBuffers(handle)
            glfwPollEvents()
        }
    }

    override fun destroy() {
        glfwFreeCallbacks(handle)
        glfwDestroyWindow(handle)

        glfwTerminate()
        glfwSetErrorCallback(null)?.free()
    }

    override fun begin(fill: Boolean) {
        if (fill) {
            glBegin(GL_POLYGON)
        } else {
            glBegin(GL_LINE_LOOP)
        }
    }

    override fun end() {
        glEnd()
    }

    override fun vertex(x: Double, y: Double, z: Double) {
        glVertex3d(x * scale, y * scale, z * scale)
    }

    override fun colour(colour: Colour, alpha: Double) {
        glColor4d(
            colour.r,
            colour.g,
            colour.b,
            alpha
        )
    }
}