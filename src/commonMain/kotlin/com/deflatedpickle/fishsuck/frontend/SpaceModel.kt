package com.deflatedpickle.fishsuck.frontend

import com.deflatedpickle.fishsuck.backend.Space
import com.deflatedpickle.fishsuck.api.render.Model
import com.deflatedpickle.fishsuck.api.render.Render
import com.deflatedpickle.fishsuck.backend.util.Colour

object SpaceModel : Model<Space> {
    override fun render(obj: Space, re: Render) {
        re.begin(fill = false)

        re.colour(Colour.WHITE)

        for (p in obj.mask.points) {
            re.vertex(p)
        }

        re.end()
    }
}