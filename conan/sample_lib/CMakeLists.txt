cmake_minimum_required(VERSION 3.10.2)
project(sample_lib)

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

if (MSVC)
  set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MD")
  set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MDd")
else ()
  set(CMAKE_CXX_FLAGS_DEBUG "$ENV{CMAKE_CXX_FLAGS} -O0 -g3 -ggdb -fvisibility=hidden ")
  set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CMAKE_CXX_FLAGS} -O3  -fvisibility=hidden ")
  set(CMAKE_C_FLAGS_DEBUG "$ENV{CMAKE_C_FLAGS} -O0 -g3 -ggdb -fvisibility=hidden ")
  set(CMAKE_C_FLAGS_RELEASE "$ENV{CMAKE_C_FLAGS} -O3 -fvisibility=hidden ")
endif ()

if (MSVC)
  add_compile_options(/MP)
elseif (${arch} STREQUAL "aarch64-j3" OR ${arch} STREQUAL "aarch64-j5")
  add_definitions(-DAARCH)
endif()

add_definitions(-DSAMPLE_LIB)

# ##############################################################################
# set related dependency library search path
include(cmake/utils.cmake)

# ##############################################################################
# related dependency libraries

# BASE_LIB
set(BASE_LIB)

# ThirdParty_LIB
set(ThirdParty_LIB fmt)

# SYS_LIB
if (MSVC)
  set(SYS_LIB ws2_32)
else()
  set(SYS_LIB dl pthread)
endif()

# BOOST_LIBS
set(BOOST_LIBS boost_system boost_filesystem)

# platform related dependency libraries
if (${arch} STREQUAL "aarch64-j3" OR ${arch} STREQUAL "aarch64-j5")
  # set(TURBO_JPEG_LIBS)
else()
  # set(TURBO_JPEG_LIBS turbojpeg)
endif()

# platform related system dependency libraries
if (APPLE)
  # find_library(VIDEO_TOOLBOX VideoToolbox)
endif()

# RPATH : https://gitlab.kitware.com/cmake/community/-/wikis/doc/cmake/RPATH-handling
set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/output)

add_subdirectory(src)