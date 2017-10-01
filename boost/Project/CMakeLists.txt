# Target 'boost' is for header only boost modules.
add_library(boost INTERFACE)
target_include_directories(boost INTERFACE ${DEPOT}/boost)
target_compile_definitions(boost INTERFACE BOOST_ALL_NO_LIB)

add_subdirectory(../libs/chrono/Project ${CMAKE_BINARY_DIR}/BoostChrono)	# Defines target 'BoostChrono'
add_subdirectory(../libs/date_time/Project ${CMAKE_BINARY_DIR}/BoostDateTime)	# Defines target 'BoostDateTime'
add_subdirectory(../libs/filesystem/Project ${CMAKE_BINARY_DIR}/BoostFileSystem)	# Defines target 'BoostFileSystem'
# FIXME: graph
# FIXME: iostream
add_subdirectory(../libs/program_options/Project ${CMAKE_BINARY_DIR}/BoostProgramOptions)	# Defines target 'BoostProgramOptions'
# FIXME: random
add_subdirectory(../libs/regex/Project ${CMAKE_BINARY_DIR}/BoostRegEx)	# Defines target 'BoostRegEx'
# FIXME: serialization
# FIXME: signals
add_subdirectory(../libs/system/Project ${CMAKE_BINARY_DIR}/BoostSystem)	# Defines target 'BoostSystem'
add_subdirectory(../libs/thread/Project ${CMAKE_BINARY_DIR}/BoostThread)	# Defines target 'BoostThread'
