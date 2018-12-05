cmake_minimum_required(VERSION 3.12)

set(CMAKE_CXX_STANDARD 17)

# Include Hunter
include("gate/cmake/HunterGate.cmake")
HunterGate(
        URL "https://github.com/ruslo/hunter/archive/v0.23.64.tar.gz"
        SHA1 "a5f3c4999e03173d28b8469c4da4545dea740a41"
)

# Create the project
project(fishsuck)

# Download the dependencies
hunter_add_package(glm)

# Add the sub-projects
add_subdirectory(src)
add_subdirectory(demo)