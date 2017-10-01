# Boost support
set(Boost_NO_BOOST_CMAKE ON) # Do not use CMake boost
set(Boost_USE_STATIC_LIBS ON) # only find static libs
set(BOOST_ROOT ../../boost)
find_package(Boost REQUIRED)

include_directories(${Boost_INCLUDE_DIRS})