#pragma once

#include <vector>
#include "glm/vec3.hpp"

namespace FishSuck {
    // Defines the body ahead of time, since the file requires Space, but Space requires the Body
    class Body;

    /**
     * A space for physics to be simulated in.
     */
    class Space {
    public:
        /**
         * @param gravity
         * @param positional_drag
         * @param angular_drag
         * @param sleep_time
         */
        explicit Space(glm::vec3 gravity, glm::vec3 positional_drag, glm::vec3 angular_drag, float sleep_time);

        glm::vec3 gravity;
        glm::vec3 positional_drag;
        glm::vec3 angular_drag;
        float sleep_time;

        std::vector<FishSuck::Body *> bodyList;

        /**
         * Starts the simulation.
         *
         * @param speed
         */
        void start(float speed);

    };
}
