# the min version of CMake this file is compatible with
# a required part of every CMake file

cmake_minimum_required(VERSION 3.8.2)

include(../../CMakeBuildSystem/Config.cmake)
find_package(CBSSupport)
find_package(CBSBoostSupport)

if (NOT TARGET HammingDistance)
    add_subdirectory(${DEPOT}/HammingDistance/Makefiles HammingDistance)
endif()

add_subdirectory(${DEPOT}/boost/Project boost)

cbs_add_sources(SOURCES
    GHDCMain.cpp
    )

add_executable(HammingDistanceCalculator ${SOURCES})

target_include_directories(HammingDistanceCalculator PRIVATE ../Sources)

target_link_libraries(HammingDistanceCalculator HammingDistance)
target_link_libraries(HammingDistanceCalculator BoostProgramOptions)

# ----------------------------------------------------------------------------
# Testing
enable_testing()

# Application run
add_test(HDCRuns HammingDistanceCalculator)

# Usage message
add_test(HDCUsage HammingDistanceCalculator)
set_tests_properties (HDCUsage PROPERTIES PASS_REGULAR_EXPRESSION "Options:.*")

# Incorrect input
add_test(HDCStringLengthNotEqual HammingDistanceCalculator 1010 101)
set_tests_properties (HDCStringLengthNotEqual PROPERTIES WILL_FAIL true)

# Invalid input
add_test(HDCInvalidInput HammingDistanceCalculator 1010)
set_tests_properties (HDCInvalidInput PROPERTIES WILL_FAIL true)

# Positive test
add_test(HDCPostive HammingDistanceCalculator 1010 1010)

# Install
install(TARGETS HammingDistanceCalculator
        RUNTIME  DESTINATION bin)
