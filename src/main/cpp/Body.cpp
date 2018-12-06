#include "Body.hpp"

FishSuck::Body::Body(FishSuck::Bounds::BaseBounds *shape, FishSuck::Space *space) {
    this->shape = shape;
    this->space = space;

    this->gravity = this->space->gravity;
    this->positional_drag = this->space->positional_drag;
    this->angular_drag = this->space->angular_drag;
    this->sleep_time = this->space->sleep_time;

    this->is_awake = true;

    this->space->bodyList.push_back(this);
}

void FishSuck::Body::addForce(float x, float y, float z) {
    glm::vec3 force(x, y, z);
    this->force += force;
}

void FishSuck::Body::addTorque(float x, float y, float z) {

}

glm::vec3 FishSuck::Body::getForce() {
    return this->force;
}
