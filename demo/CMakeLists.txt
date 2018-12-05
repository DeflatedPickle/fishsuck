cmake_minimum_required(VERSION 3.12)
project(fishsuck_demo)

set(CMAKE_CXX_STANDARD 17)

add_executable(fishsuck_demo main.cpp)
target_link_libraries(fishsuck_demo LINK_PUBLIC fishsuck_src)