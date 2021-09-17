package com.deflatedpickle.fishsuck.backend

import com.deflatedpickle.bellatrix.Vec3d
import com.deflatedpickle.bellatrix.times
import com.deflatedpickle.fishsuck.api.obj.Primitive
import com.deflatedpickle.fishsuck.api.render.HasModel
import com.deflatedpickle.fishsuck.api.render.Model
import com.deflatedpickle.fishsuck.backend.shape.Rectangle
import com.deflatedpickle.fishsuck.backend.shape.Shape
import com.deflatedpickle.fishsuck.frontend.BodyModel

class Body(
    var position: Vec3d = Vec3d(0.0, 0.0, 0.0),
    var mass: Double = 1.0,
    var force: Vec3d = Vec3d(0.0, 0.0, 0.0),
    var torque: Vec3d = Vec3d(0.0, 0.0, 0.0),
    var momentOfInertia: Vec3d = Vec3d(0.0, 0.0, 0.0),
    var centreOfGravity: Vec3d = Vec3d(0.0, 0.0, 0.0),
    var awake: Boolean = true,
    internal val shapes: MutableCollection<Shape> = mutableListOf(),
) : Primitive, HasModel(Rectangle()) {
    companion object {
        init {
            Model.registry[Body::class] = BodyModel
        }
    }

    lateinit var space: Space

    init {
        for (i in shapes) {
            i.owner = this
        }
    }

    override fun reset() {
    }

    override fun update(delta: Double) {
        if (awake) {
            val weight = mass * space.gravity * delta
            val density = mass / shapes.sumOf { it.volume }

            force += space.gravity
            println("Weight: $weight, Density: $density, Force: $force")

            val velocity = (density * force * delta) as Vec3d
            println("Velocity: $velocity")

            val drag = Vec3d(
                density * (velocity.x * velocity.x) * delta,
                density * (velocity.y * velocity.y) * delta,
                density * (velocity.z * velocity.z) * delta,
            ) / 2.0
            force -= drag
            println("Drag: $drag")

            position -= velocity
            println("Position: $position")
        }
    }
}