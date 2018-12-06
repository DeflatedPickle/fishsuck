#include <algorithm>
#include <iostream>
#include <chrono>
#include "Space.hpp"

#include "glm/vec3.hpp"
#include "Body.hpp"

using namespace std;

FishSuck::Space::Space(glm::vec3 gravity, glm::vec3 positional_drag, glm::vec3 angular_drag, float sleep_time) {
    this->gravity = gravity;
    this->positional_drag = positional_drag;
    this->angular_drag = angular_drag;
    this->sleep_time = sleep_time;
}

void FishSuck::Space::start(float speed) {
    int limit = 10;

    while (true) {
        for (FishSuck::Body *body : this->bodyList) {

            // FIXME: This isn't how delta time works
            float delta = 1.0f / speed;
            // auto last = chrono::high_resolution_clock::now();

            if (body->is_awake) {
                // auto current = chrono::high_resolution_clock::now();
                // auto dur = current - last;
                // auto milliseconds = chrono::duration_cast<chrono::milliseconds>(dur).count();

                // delta = milliseconds / speed;

                auto acceleration = body->getForce() / body->mass;

                body->positional_velocity += (acceleration * body->gravity) * delta;
                body->position += body->positional_velocity * delta;

                body->shape->position = body->position;

                cout << &body << " " << "Position Y: " << body->position.y << " Positional Velocity Y: "
                     << body->positional_velocity.y
                     << endl;
            }
        }

        limit--;
        if (limit == 0) break;
    }
}
