#pragma once

#include <glm/vec3.hpp>
#include <main/cpp/bounds/BaseBounds.hpp>
#include "Space.hpp"

namespace FishSuck {
    class Body {
    public:
        Body(FishSuck::Bounds::BaseBounds *shape, FishSuck::Space *space);

        FishSuck::Bounds::BaseBounds *shape;
        FishSuck::Space *space;

        glm::vec3 gravity;
        glm::vec3 positional_drag;
        glm::vec3 angular_drag;
        float sleep_time;

        bool is_awake;

        /**
         * The mass of the body.
         */
        float mass;
        /**
         * The moment of inertia.
         */
        float moment_of_inertia;

        /**
         * The center of gravity of the body.
         */
        float center_of_gravity;

        /**
         * The position of the body.
         */
        glm::vec3 position;
        /**
         * The positional velocity of the body.
         */
        glm::vec3 positional_velocity;

        /**
         * The rotation of the body.
         */
        glm::vec3 rotation;
        /**
         * The rotational velocity of the body.
         */
        glm::vec3 rotatational_velocity;

        /**
         * Add given amounts of force to the body on each axis.
         *
         * @param x
         * @param y
         * @param z
         */
        void addForce(float x, float y, float z);

        glm::vec3 getForce();

        /**
         * Add given amounts of torque to the body on each axis.
         *
         * @param x
         * @param y
         * @param z
         */
        void addTorque(float x, float y, float z);

    private:
        glm::vec3 force;
        glm::vec3 torque;
    };
}
