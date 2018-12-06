#pragma once

#include "glm/vec3.hpp"

namespace FishSuck::Bounds {
    class BaseBounds {
    public:
        bool is_trigger;

        glm::vec3 position;
        glm::vec3 rotation;
    };
}
