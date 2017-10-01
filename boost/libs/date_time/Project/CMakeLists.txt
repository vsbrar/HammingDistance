
cbs_add_sources(SOURCES ../src/gregorian/
	date_generators.cpp
	greg_month.cpp
	greg_weekday.cpp
	gregorian_types.cpp
	)

add_library(BoostDateTime ${SOURCES})
target_include_directories(BoostDateTime PUBLIC ${DEPOT}/boost PRIVATE ${DEPOT}/boost/libs/regex)

if(${BUILD_SHARED_LIBS})
# TODO GCC4_MACOSX_COMPILER_FLAGS += -fvisibility=default
# TODO CLANG_MACOSX_COMPILER_FLAGS += -fvisibility=default
	target_compile_definitions(BoostDateTime PUBLIC BOOST_DATE_TIME_DYN_LINK)
endif()

target_link_libraries(BoostDateTime PUBLIC boost)

