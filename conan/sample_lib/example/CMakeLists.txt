cmake_minimum_required(VERSION 3.10.2)
project(demo)

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
  set(CMAKE_CXX_FLAGS_DEBUG "$ENV{CMAKE_CXX_FLAGS} -O0 -g3 -ggdb ")
  set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CMAKE_CXX_FLAGS} -O3 ")
  set(CMAKE_C_FLAGS_DEBUG "$ENV{CMAKE_C_FLAGS} -O0 -g3 -ggdb ")
  set(CMAKE_C_FLAGS_RELEASE "$ENV{CMAKE_C_FLAGS} -O3 ")
endif ()

if (MSVC)
  add_compile_options(/MP)
elseif (${arch} STREQUAL "aarch64-j3" OR ${arch} STREQUAL "aarch64-j5")
  add_definitions(-DAARCH)
endif()

# ##############################################################################
# set related dependency library search path
include_directories(SYSTEM "${CMAKE_BINARY_DIR}/include")
link_directories("${CMAKE_BINARY_DIR}/lib")

file(GLOB_RECURSE SRC_FILES "*.cc")
add_executable(${PROJECT_NAME} ${SRC_FILES})

target_link_libraries(${PROJECT_NAME}
    sample_lib
    fmt)

install(TARGETS ${PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_BINDIR})