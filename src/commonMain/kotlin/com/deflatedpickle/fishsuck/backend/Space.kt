package com.deflatedpickle.fishsuck.backend

import com.deflatedpickle.bellatrix.Vec3d
import com.deflatedpickle.fishsuck.api.obj.Primitive
import com.deflatedpickle.fishsuck.api.render.HasModel
import com.deflatedpickle.fishsuck.backend.shape.Rectangle

class Space(
    val main: Boolean = false,
    var gravity: Vec3d = Vec3d(0.0, 1.0, 0.0),
    var positionalDrag: Vec3d = Vec3d(1.0, 1.0, 1.0),
    var angularDrag: Vec3d = Vec3d(1.0, 1.0, 1.0),
    var run: Boolean = true,
    internal val children: MutableCollection<Primitive> = mutableListOf(),
) : Primitive, HasModel(Rectangle()) {
    companion object {
        init {
            // Model.registry[Space::class] = SpaceModel
        }
    }

    init {
        for (i in children) {
            if (i is Body) {
                i.space = this
            }
        }
    }

    fun add(primitive: Primitive) {
        children.add(primitive)

        if (primitive is Body) {
            primitive.space = this
        }
    }

    override fun reset() {
        for (i in children) {
            i.reset()
        }
    }

    override fun update(delta: Double) {
        for (i in children) {
            i.update(delta)
        }
    }
}