package com.deflatedpickle.fishsuck.frontend

import com.deflatedpickle.bellatrix.Vec3d
import com.deflatedpickle.fishsuck.api.render.Model
import com.deflatedpickle.fishsuck.api.render.Render
import com.deflatedpickle.fishsuck.backend.shape.Shape

object ShapeModel : Model<Shape> {
    override fun render(obj: Shape, re: Render) {
        re.begin(fill = true)

        for (p in obj.points) {
            re.vertex((obj.owner.position.plus<Double, Double>(p)) as Vec3d)
        }

        re.end()
    }
}