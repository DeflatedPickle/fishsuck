cmake_minimum_required(VERSION 3.12)
project(fishsuck_src)

set(CMAKE_CXX_STANDARD 17)

add_library(fishsuck_src
        main/cpp/Space.cpp
        main/cpp/Space.hpp
        main/cpp/Body.cpp
        main/cpp/Body.hpp
        main/cpp/bounds/BaseBounds.cpp
        main/cpp/bounds/BaseBounds.hpp
        main/cpp/bounds/RectangleBounds.cpp
        main/cpp/bounds/RectangleBounds.hpp)
target_include_directories(fishsuck_src PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# Find the packages
find_package(glm CONFIG REQUIRED)
target_link_libraries(fishsuck_src PUBLIC glm)