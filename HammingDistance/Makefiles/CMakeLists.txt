# the min version of CMake this file is compatible with
# a required part of every CMake file

cmake_minimum_required(VERSION 3.8.2)

include(../../CMakeBuildSystem/Config.cmake)
find_package(CBSSupport REQUIRED)
find_package(CBSBoostSupport REQUIRED)

cbs_add_sources(SOURCES
    GHDHammingDistance.cpp
    )

add_library(HammingDistance STATIC ${SOURCES})

target_include_directories(HammingDistance PUBLIC ../ PRIVATE ../Sources)
target_include_directories(HammingDistance PUBLIC ${Boost_INCLUDE_DIRS})

# Install
install(TARGETS HammingDistance
        ARCHIVE  DESTINATION lib
        )
install(DIRECTORY ../
        DESTINATION include
        FILES_MATCHING PATTERN "*.h"
        )