package com.deflatedpickle.fishsuck.frontend

import com.deflatedpickle.fishsuck.backend.Body
import com.deflatedpickle.fishsuck.api.render.Model
import com.deflatedpickle.fishsuck.api.render.Render
import com.deflatedpickle.fishsuck.backend.util.Colour

object BodyModel : Model<Body> {
    override fun render(obj: Body, re: Render) {
        re.colour(Colour.RED, if (obj.awake) 1.0 else 0.5)

        for (s in obj.shapes) {
            Model.registry[s::class]?.render(s, re)
        }
    }
}