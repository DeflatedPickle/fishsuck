package com.deflatedpickle.fishsuck.backend.util

enum class Colour(
    val r: Double,
    val g: Double,
    val b: Double,
) {
    BLACK(0.0, 0.0, 0.0),
    WHITE(1.0, 1.0, 1.0),

    RED(1.0, 0.0, 0.0),
    GREEN(0.0, 1.0, 0.0),
    BLUE(0.0, 0.0, 1.0),
}