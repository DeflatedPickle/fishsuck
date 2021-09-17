package com.deflatedpickle.fishsuck.api.render

import com.deflatedpickle.fishsuck.api.obj.Primitive
import com.deflatedpickle.fishsuck.backend.util.Registry
import kotlin.reflect.KClass

interface Model<out T : Primitive> {
    companion object {
        val registry = Registry<KClass<out Primitive>, Model<Primitive>>()
    }

    fun render(obj: @UnsafeVariance T, re: Render)
}