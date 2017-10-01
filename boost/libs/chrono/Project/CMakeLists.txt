cbs_add_sources(SOURCES ../src/
	chrono.cpp
	process_cpu_clocks.cpp
	thread_clock.cpp
	)

add_library(BoostChrono ${SOURCES})
target_include_directories(BoostChrono PUBLIC ${DEPOT}/boost PRIVATE ${DEPOT}/boost/libs/chrono)
if(${BUILD_SHARED_LIBS})
  target_compile_definitions(BoostChrono PUBLIC BOOST_CHRONO_DYN_LINK)
endif()
target_link_libraries(BoostChrono boost BoostSystem)

if(${BUILD_SHARED_LIBS})
  install(TARGETS BoostChrono RUNTIME DESTINATION bin LIBRARY DESTINATION bin)
endif()