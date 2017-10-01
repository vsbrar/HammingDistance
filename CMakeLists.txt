# the min version of CMake this file is compatible with
# a required part of every CMake file

cmake_minimum_required(VERSION 3.8.2)

project(HammingDistanceMain)

add_subdirectory(HammingDistance/Makefiles)
add_subdirectory(HammingDistanceTester/Makefiles)
add_subdirectory(HammingDistanceCalculator/Makefiles)

# Testing
enable_testing()

# Install
set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/Output)