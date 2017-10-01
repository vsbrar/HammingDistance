cbs_add_sources(SOURCES ../src/
	future.cpp
	)

cbs_add_win_sources(SOURCES ./
	../src/tss_null.cpp
	../src/win32/thread.cpp
	../src/win32/tss_dll.cpp
	../src/win32/tss_pe.cpp
	)

cbs_add_mac_sources(SOURCES ./
	../src/pthread/once.cpp
	../src/pthread/thread.cpp
	)

cbs_add_linux_sources(SOURCES ./
	../src/pthread/once.cpp
	../src/pthread/thread.cpp
	)

add_library(BoostThread ${SOURCES})
target_include_directories(BoostThread PUBLIC ${DEPOT}/boost PRIVATE ${DEPOT}/boost/libs/thread)
if(${BUILD_SHARED_LIBS})
  target_compile_definitions(BoostThread PUBLIC BOOST_THREAD_USE_DLL PRIVATE BOOST_THREAD_BUILD_DLL)
else()
  target_compile_definitions(BoostThread PUBLIC BOOST_THREAD_USE_LIB PRIVATE BOOST_THREAD_BUILD_LIB)
endif()
target_link_libraries(BoostThread boost BoostChrono BoostSystem)

if(${BUILD_SHARED_LIBS})
  install(TARGETS BoostThread RUNTIME DESTINATION bin LIBRARY DESTINATION bin)
endif()