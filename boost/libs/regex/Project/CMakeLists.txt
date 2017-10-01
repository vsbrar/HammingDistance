# FIXME? option for BOOST_NO_WREGEX ? Used?

cbs_add_sources(SOURCES ../src/
	c_regex_traits.cpp
	cpp_regex_traits.cpp
	cregex.cpp
	fileiter.cpp
	instances.cpp
	posix_api.cpp
	regex_raw_buffer.cpp
	regex_traits_defaults.cpp
	regex.cpp
	static_mutex.cpp
	wc_regex_traits.cpp
	wide_posix_api.cpp
	winstances.cpp
	)

if(BOOST_HAS_ICU)
cbs_add_sources(SOURCES ../src/
	icu.cpp
	)
endif()
#	regex_debug.cpp we do not define BOOST_REGEX_CONFIG_INFO ...

cbs_add_win_sources(SOURCES ../src/
	usinstances.cpp
	w32_regex_traits.cpp
	)

add_library(BoostRegEx ${SOURCES})
target_include_directories(BoostRegEx PUBLIC ${DEPOT}/boost PRIVATE ${DEPOT}/boost/libs/regex)
if(${BUILD_SHARED_LIBS})
	target_compile_definitions(BoostRegEx PUBLIC BOOST_REGEX_DYN_LINK)
else()
	target_compile_definitions(BoostRegEx PUBLIC BOOST_REGEX_STATIC_LINK)
endif()
target_link_libraries(BoostRegEx PUBLIC boost)

if(BOOST_HAS_ICU)
	target_compile_definitions(BoostRegEx PRIVATE BOOST_HAS_ICU)
	target_link_libraries(BoostRegEx PRIVATE icuin)
endif()

