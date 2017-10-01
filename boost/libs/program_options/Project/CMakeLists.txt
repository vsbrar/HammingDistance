cbs_add_sources(SOURCES ../src/
	cmdline.cpp
	config_file.cpp
	convert.cpp
	options_description.cpp
	parsers.cpp
	positional_options.cpp
	split.cpp
	utf8_codecvt_facet.cpp
	value_semantic.cpp
	variables_map.cpp
	winmain.cpp
	)

add_library(BoostProgramOptions STATIC ${SOURCES})
target_include_directories(BoostProgramOptions PUBLIC ${DEPOT}/boost PRIVATE ${DEPOT}/boost/libs/regex)
target_link_libraries(BoostProgramOptions boost)