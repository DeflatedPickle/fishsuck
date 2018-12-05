#include "Body.hpp"

FishSuck::Body::Body(FishSuck::Shape::BaseShape *shape, FishSuck::Space *space) {
    this->shape = shape;
    this->space = space;
}

void FishSuck::Body::addForce(float x, float y, float z) {

}

void FishSuck::Body::addTorque(float x, float y, float z) {

}
