package com.deflatedpickle.fishsuck.backend.shape

import com.deflatedpickle.bellatrix.Vec3d
import com.deflatedpickle.fishsuck.backend.Body
import com.deflatedpickle.fishsuck.api.obj.Primitive

abstract class Shape(
    var position: Vec3d = Vec3d(0.0, 0.0, 0.0),
    var rotation: Vec3d = Vec3d(0.0, 0.0, 0.0),
    var scale: Vec3d = Vec3d(1.0, 1.0, 1.0),
    var volume: Double = 1.0,
    var solid: Boolean = true,
    val points: MutableCollection<Vec3d> = mutableListOf(),
) : Primitive {
    lateinit var owner: Body

    override fun reset() {
    }

    override fun update(delta: Double) {
    }
}