package com.deflatedpickle.fishsuck.backend.util

import com.deflatedpickle.fishsuck.api.obj.Resetable

class Cached<T>(
    v: T
) : Resetable {
    var value: T = v
    private var original: T = value

    override fun reset() {
        value = original
    }
}