@file:Suppress("UNUSED_VARIABLE")

import com.deflatedpickle.bellatrix.Vec3d
import com.deflatedpickle.fishsuck.backend.Body
import com.deflatedpickle.fishsuck.backend.Space
import com.deflatedpickle.fishsuck.render.RenderGLFW
import com.deflatedpickle.fishsuck.backend.shape.Rectangle
import kotlinx.coroutines.DelicateCoroutinesApi
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

@OptIn(DelicateCoroutinesApi::class)
fun main() {
    val world = Space(
        gravity = Vec3d(0.0, 2.0, 0.0),
        positionalDrag = Vec3d(0.0, 0.0, 0.0),
        angularDrag = Vec3d(0.0, 0.0, 0.0),
    )

    val entity = Body(
        force = Vec3d(1.0, 0.0, 0.0),
        shapes = mutableListOf(Rectangle())
    ).also {
        world.add(it)
    }

    val run = true

    GlobalScope.launch {
        while (run) {
            world.update(1.0)
            delay(1000L)
        }
    }

    Thread {
        RenderGLFW(world).apply {
            open(640, 640)
            render()
            destroy()
        }
    }.start()
}