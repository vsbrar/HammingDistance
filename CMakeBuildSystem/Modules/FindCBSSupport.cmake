if(__CBS_CBSSUPPORT_INCLUDED)
  return()
endif()
set(__CBS_CBSSUPPORT_INCLUDED TRUE)

cmake_minimum_required(VERSION 3.8.2)

include(CMakeParseArguments)

# ----------------------------------------------------------------------------
# For debug only.
function(__cbs_print_all_cmake_variable_values)
  message(STATUS "")
  get_cmake_property(vs VARIABLES)
  foreach(v ${vs})
    message(STATUS "${v}='${${v}}'")
  endforeach(v)
  message(STATUS "")
endfunction()

# ----------------------------------------------------------------------------
# For debug only.
# Based on http://stackoverflow.com/questions/32183975/how-to-print-all-the-properties-of-a-target-in-cmake
function(__cbs_print_target_properties tgt)
  if(NOT TARGET ${tgt})
    message("There is no target named '${tgt}'")
    return()
  endif()

  if (NOT DEFINED __CBS_CMAKE_PROPERTY_LIST)
    # Get all propreties that cmake supports
    execute_process(COMMAND cmake --help-property-list OUTPUT_VARIABLE PROPERTY_LIST)

    # Convert command output into a CMake list
    string(REGEX REPLACE ";" "\\\\;" PROPERTY_LIST "${PROPERTY_LIST}")
    string(REGEX REPLACE "\n" ";" PROPERTY_LIST "${PROPERTY_LIST}")
    # The LOCATION properties are taboo to fetch via get_target_property(), see policy CMP0026.
    string(REGEX REPLACE "[^;]*LOCATION[^;]*;" "" PROPERTY_LIST "${PROPERTY_LIST}")
    # Oddly enough, some properties are listed multiple times.
    list(REMOVE_DUPLICATES PROPERTY_LIST)
    set(__CBS_CMAKE_PROPERTY_LIST "${PROPERTY_LIST}" CACHE INTERNAL "All known property names")
  endif()

  foreach (prop ${__CBS_CMAKE_PROPERTY_LIST})
    string(REPLACE "<CONFIG>" "${CMAKE_BUILD_TYPE}" prop ${prop})
    get_property(propval TARGET ${tgt} PROPERTY ${prop} SET)
    if (propval)
      get_target_property(propval ${tgt} ${prop})
      message ("${tgt} ${prop} = ${propval}")
    endif()
  endforeach()
endfunction()

# ----------------------------------------------------------------------------
macro(__cbs_add_default_definitions)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
endmacro()

# ----------------------------------------------------------------------------
# cbs_add_sources(SOURCELIST_VAR [ RELATIVE_PATH ] SRC1 SRC2 ... SRCN)
#   SOURCELIST_VAR : variable which will be used to add/append the source filenames
#   RELATIVE_PATH : (optional) when it is an existing directory relative to the
#     directory containing the current CMakeLists.txt, this will be the directory used
#     to find the sources SRC1 .. SRCN.
#   SRC1 .. SRCN : zero or more source filenames relative to "Sources"
#     or RELATIVE_PATH (when specified).
function(cbs_add_sources OUTPUT_VAR ...)
  set(OUTPUT ${${OUTPUT_VAR}})
  set(PREFIX "")
  list(REMOVE_AT ARGV 0)

  # RELATIVE_PATH specified ?
  if (IS_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/${ARGV1})
    set(PREFIX ${CMAKE_CURRENT_LIST_DIR}/${ARGV1})
    list(REMOVE_AT ARGV 0)
  else()
    if(IS_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}/../Sources")
      set(PREFIX ../Sources)
    endif()
  endif()

  if ("${PREFIX}" STREQUAL ""
      AND NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${ARGV1}"
      )
    message(SEND_ERROR "CBSSupport: cbs_add_sources: Don't know where to look for those sources")
  endif()
  
  foreach(f ${ARGV})
    # message("Add source ${PREFIX}${f}")
    list(APPEND OUTPUT ${PREFIX}/${f})
  endforeach(f)
  set(${OUTPUT_VAR} "${OUTPUT}" PARENT_SCOPE)
endfunction()

# Like cbs_add_sources() but only for WIN32 targets.
function(cbs_add_win_sources OUTPUT_VAR ...)
  if(WIN32)
    list(REMOVE_AT ARGV 0)
    cbs_add_sources(${OUTPUT_VAR} ${ARGV})
    set(${OUTPUT_VAR} ${${OUTPUT_VAR}} PARENT_SCOPE)
  endif()
endfunction()

# Like cbs_add_sources() but only for MacOSX targets.
function(cbs_add_mac_sources OUTPUT_VAR ...)
  if(APPLE)
    list(REMOVE_AT ARGV 0)
    cbs_add_sources(${OUTPUT_VAR} ${ARGV})
    set(${OUTPUT_VAR} ${${OUTPUT_VAR}} PARENT_SCOPE)
  endif()
endfunction()

# Like Add_sources() but ony for Linux targets.
function(cbs_add_linux_sources OUTPUT_VAR ...)
  if(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
    list(REMOVE_AT ARGV 0)
    cbs_add_sources(${OUTPUT_VAR} ${ARGV})
    set(${OUTPUT_VAR} ${${OUTPUT_VAR}} PARENT_SCOPE)
  endif()
endfunction()

# ----------------------------------------------------------------------------
# Main
get_filename_component(DEPOT ${CMAKE_CURRENT_LIST_DIR}/../.. ABSOLUTE)

__cbs_add_default_definitions()
