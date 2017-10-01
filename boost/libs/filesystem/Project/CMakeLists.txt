cbs_add_sources(SOURCES ../src/
	codecvt_error_category.cpp
	operations.cpp
	path_traits.cpp
	path.cpp
	portability.cpp
	unique_path.cpp
	utf8_codecvt_facet.cpp
	windows_file_codecvt.cpp
	)

add_library(BoostFileSystem ${SOURCES})
target_include_directories(BoostFileSystem PUBLIC ${DEPOT}/boost PRIVATE ${DEPOT}/boost/libs/filesystem)
if(${BUILD_SHARED_LIBS})
  target_compile_definitions(BoostFileSystem PUBLIC BOOST_FILESYSTEM_DYN_LINK)
endif()
target_link_libraries(BoostFileSystem boost BoostSystem)

if(${BUILD_SHARED_LIBS})
  install(TARGETS BoostFileSystem RUNTIME DESTINATION bin LIBRARY DESTINATION bin)
endif()