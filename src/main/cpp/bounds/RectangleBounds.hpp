#pragma once

#include <main/cpp/bounds/BaseBounds.hpp>

namespace FishSuck::Bounds {
    class RectangleBounds : public BaseBounds {
    public:
        /**
         * Constructs a new bounding rectangle.
         *
         * @param width
         * @param height
         * @param length
         */
        RectangleBounds(float width, float height, float length);

        float width;
        float height;
        float length;
    };
}
