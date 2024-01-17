SET(DEBUG_POSTFIX "d")

# ##############################################################################
# according to CMAKE_BUILD_TYPE links different libraries
function(custom_link_libraries)
  foreach (lib ${ARGN})
    link_libraries(debug "${lib}${DEBUG_POSTFIX}" optimized ${lib})
  endforeach ()
endfunction()

function(custom_target_link_libraries target)
  foreach (lib ${ARGN})
    target_link_libraries(${target} debug "${lib}${DEBUG_POSTFIX}" optimized ${lib})
  endforeach ()
endfunction()

# ##############################################################################
# related dependency libraries

# BASE_LIB

# ThirdParty_LIB
find_package(fmt REQUIRED)
if (fmt_FOUND)
    include_directories(SYSTEM ${fmt_INCLUDE_DIRS})
    list(APPEND LINK_SEARCH_PATH ${fmt_LIB_DIRS})
endif()

# BOOST_LIBS
find_package(Boost REQUIRED)
if (Boost_FOUND)
    include_directories(SYSTEM ${Boost_INCLUDE_DIRS})
    list(APPEND LINK_SEARCH_PATH ${Boost_LIB_DIRS})
endif()

# platform related dependency libraries
if (${arch} STREQUAL "aarch64-j3" OR ${arch} STREQUAL "aarch64-j5")
else()
endif()

link_directories(${LINK_SEARCH_PATH})
message("LINK_SEARCH_PATH:${LINK_SEARCH_PATH}")
include_directories(${PROJECT_SOURCE_DIR}/src)