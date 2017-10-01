# the min version of CMake this file is compatible with
# a required part of every CMake file

cmake_minimum_required(VERSION 3.8.2)

include(../../CMakeBuildSystem/Config.cmake)
find_package(CBSSupport)

add_subdirectory(${DEPOT}/googletest googletest)
if (NOT TARGET HammingDistance)
    add_subdirectory(${DEPOT}/HammingDistance/Makefiles HammingDistance)
endif()

cbs_add_sources(SOURCES
    GHDTHammingDistanceTest.cpp
    )
    
add_executable(HammingDistanceTester ${SOURCES})
target_link_libraries(HammingDistanceTester HammingDistance gtest_main)

# Testing 
enable_testing()

add_test(HammingDistanceTest HammingDistanceTester)

# Install
install(TARGETS HammingDistanceTester
        RUNTIME  DESTINATION bin)
