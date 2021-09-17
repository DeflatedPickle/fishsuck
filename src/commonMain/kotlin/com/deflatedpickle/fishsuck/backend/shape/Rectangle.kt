package com.deflatedpickle.fishsuck.backend.shape

import com.deflatedpickle.bellatrix.Vec3d
import com.deflatedpickle.fishsuck.api.render.Model
import com.deflatedpickle.fishsuck.frontend.ShapeModel

class Rectangle(
    scale: Vec3d = Vec3d(1.0, 1.0, 1.0)
) : Shape(scale = scale) {
    companion object {
        init {
            Model.registry[Rectangle::class] = ShapeModel
        }
    }

    init {
        volume = scale.z * scale.x * scale.y

        val x = position.x - scale.x / 2
        val y = position.y - scale.y / 2

        points.addAll(listOf(
            Vec3d(x, y, 0.0),
            Vec3d(x + scale.x, y, 0.0),
            Vec3d(x + scale.x, y + scale.y, 0.0),
            Vec3d(x, y + scale.y, 0.0)
        ))
    }
}