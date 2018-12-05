#pragma once

#include "glm/vec3.hpp"
#include "main/cpp/shapes/BaseShape.hpp"

namespace FishSuck {
    /**
     * A space for physics to be simulated in.
     */
    class Space {
    public:
        /**
         * @param gravity
         * @param drag
         * @param sleep_time
         */
        explicit Space(glm::vec3 gravity, glm::vec3 drag, float sleep_time);

        /**
         * Starts the simulation.
         *
         * @param speed
         */
        void start(float speed);

    private:
        FishSuck::Shape::BaseShape* shapeList;
    };
}
