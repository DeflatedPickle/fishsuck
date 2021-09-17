package com.deflatedpickle.fishsuck.backend.shape

import com.deflatedpickle.bellatrix.Vec3d
import com.deflatedpickle.fishsuck.api.render.Model
import com.deflatedpickle.fishsuck.frontend.ShapeModel
import kotlin.math.PI
import kotlin.math.cos
import kotlin.math.sin

class Polygon(
    edges: Int,
    scale: Vec3d = Vec3d(1.0, 1.0, 1.0),
) : Shape(scale = scale) {
    companion object {
        init {
            Model.registry[Polygon::class] = ShapeModel
        }
    }

    init {
        for (i in 0 until edges) {
            val theta = 2.0 * PI * i / edges

            val x = scale.x * cos(theta)
            val y = scale.y * sin(theta)

            points += Vec3d(x, y, 0.0)
        }
    }
}