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
    // FIXME: This doesn't work with multiple bodies
    for (FishSuck::Body *body : this->bodyList) {
        int limit = 10;

        // FIXME: This isn't how delta time works
        float delta = 1.0f / speed;
        auto last = chrono::high_resolution_clock::now();

        while (body->is_awake) {
            auto current = chrono::high_resolution_clock::now();
            auto dur = current - last;
            auto milliseconds = chrono::duration_cast<chrono::milliseconds>(dur).count();

            delta = milliseconds / speed;

            body->position += (body->positional_velocity * body->gravity) * delta;
            body->positional_velocity += (body->getForce() / body->mass) * delta;

            body->shape->position = body->position;

            cout << &body << " " << "Position Y: " << body->position.y << " Positional Velocity Y: " << body->positional_velocity.y
                 << endl;

            limit--;
            if (limit == 0) break;
        }
    }
}
