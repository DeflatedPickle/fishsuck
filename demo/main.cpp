#include <main/cpp/Space.hpp>
#include <main/cpp/Body.hpp>
#include <main/cpp/bounds/RectangleBounds.hpp>
#include "glm/vec3.hpp"

int main() {
    // Create a space for the physics to be simulated in
    auto space = new FishSuck::Space(glm::vec3(0.0f, -10.0f, 0.0f), glm::vec3(2.0f), glm::vec3(2.0f), std::numeric_limits<float>::infinity());
    // Create a shape
    auto shape = new FishSuck::Bounds::RectangleBounds(10.0f, 10.0f, 10.0f);
    // Create a body to use the shape
    auto body = new FishSuck::Body(shape, space);
    body->position = glm::vec3(0.0f, 0.0f, 0.0f);
    body->mass = 1.0f;
    body->addForce(0.0f, 10.0f, 0.0f);

    space->start(60.0f);

    return 0;
}