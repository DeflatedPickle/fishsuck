package com.deflatedpickle.fishsuck.api.render

import com.deflatedpickle.bellatrix.Vec3d
import com.deflatedpickle.fishsuck.backend.util.Colour

interface Render {
    // Window
    fun open(width: Int, height: Int)
    fun render()
    fun destroy()

    // Model
    fun begin(fill: Boolean) {}
    fun end() {}

    fun vertex(x: Double, y: Double, z: Double) {}
    fun vertex(vec3d: Vec3d) = vertex(vec3d.x, vec3d.y, vec3d.z)

    fun colour(colour: Colour, alpha: Double = 1.0) {}
}