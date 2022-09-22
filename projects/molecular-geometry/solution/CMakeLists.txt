cmake_minimum_required(VERSION 3.0)
project(solution)

find_package(Eigen3 3.4 REQUIRED NO_MODULE)

include_directories(include)

add_executable(solution solution.cpp molecule.cpp)
target_link_libraries(solution Eigen3::Eigen)
