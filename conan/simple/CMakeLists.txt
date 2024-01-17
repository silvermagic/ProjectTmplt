cmake_minimum_required(VERSION 3.10.2)
project(sample)

# ##############################################################################
# load and run external cmake codes using ccache
find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
  set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CCACHE_PROGRAM}")
endif()

# ##############################################################################
# set related compile flags
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_VERBOSE_MAKEFILE OFF)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(CMAKE_CXX_FLAGS_DEBUG "$ENV{CMAKE_CXX_FLAGS} -O0 -g3 -ggdb ")
set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CMAKE_CXX_FLAGS} -O3 ")
set(CMAKE_C_FLAGS_DEBUG "$ENV{CMAKE_C_FLAGS} -O0 -g3 -ggdb ")
set(CMAKE_C_FLAGS_RELEASE "$ENV{CMAKE_C_FLAGS} -O3 ")

# ##############################################################################
# set related dependency library search path
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

# RPATH : https://gitlab.kitware.com/cmake/community/-/wikis/doc/cmake/RPATH-handling
set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/output)

add_subdirectory(src)