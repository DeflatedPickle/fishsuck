#include <main/cpp/Space.hpp>
#include <main/cpp/Body.hpp>
#include "glm/vec3.hpp"

int main() {
    auto space = new FishSuck::Space(glm::vec3(0.0f, 10.0f, 0.0f), glm::vec3(10.0f, 10.0f, 10.0f), std::numeric_limits<float>::infinity());
    auto shape = new FishSuck::Shape::BaseShape();
    auto body = new FishSuck::Body(shape, space);

    return 0;
}