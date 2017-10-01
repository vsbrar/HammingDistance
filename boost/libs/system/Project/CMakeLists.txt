cbs_add_sources(SOURCES ../src/
	error_code.cpp
	)

add_library(BoostSystem ${SOURCES})
target_include_directories(BoostSystem PUBLIC ${DEPOT}/boost PRIVATE ${DEPOT}/boost/libs/system)
if(${BUILD_SHARED_LIBS})
  target_compile_definitions(BoostSystem PUBLIC BOOST_SYSTEM_DYN_LINK)
endif()
target_compile_definitions(BoostSystem PUBLIC BOOST_SYSTEM_NO_DEPRECATED)
target_link_libraries(BoostSystem boost)

if(${BUILD_SHARED_LIBS})
  install(TARGETS BoostSystem RUNTIME DESTINATION bin LIBRARY DESTINATION bin)
endif()