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
set(CMAKE_CXX_FLAGS_DEBUG "$ENV{CMAKE_CXX_FLAGS} -O0 -g3 -ggdb -fvisibility=hidden ")
set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CMAKE_CXX_FLAGS} -O3  -fvisibility=hidden ")
set(CMAKE_C_FLAGS_DEBUG "$ENV{CMAKE_C_FLAGS} -O0 -g3 -ggdb -fvisibility=hidden ")
set(CMAKE_C_FLAGS_RELEASE "$ENV{CMAKE_C_FLAGS} -O3 -fvisibility=hidden ")
set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/output)

add_definitions(-DSAMPLE_LIB)

# ##############################################################################
# set related dependency library search path
find_package(Boost REQUIRED COMPONENTS system filesystem)
if(Boost_FOUND)
    include_directories(${Boost_INCLUDE_DIRS})
    
    MESSAGE(STATUS "Boost_INCLUDE_DIRS = ${Boost_INCLUDE_DIRS}")
    MESSAGE(STATUS "Boost_LIBRARY_DIRS = ${Boost_LIBRARY_DIRS}")
    MESSAGE(STATUS "Boost_LIBRARIES = ${Boost_LIBRARIES}")
endif()

find_package(PkgConfig)
pkg_check_modules(ThirdParty REQUIRED fmt)
if(ThirdParty_FOUND)
    include_directories(${ThirdParty_INCLUDE_DIRS})
    
    MESSAGE(STATUS "ThirdParty_INCLUDE_DIRS = ${ThirdParty_INCLUDE_DIRS}")
    MESSAGE(STATUS "ThirdParty_LIBRARY_DIRS = ${ThirdParty_LIBRARY_DIRS}")
    MESSAGE(STATUS "ThirdParty_LIBRARIES = ${ThirdParty_LIBRARIES}")
endif()

include_directories(SYSTEM "${CMAKE_SOURCE_DIR}/src")

file(GLOB_RECURSE SRC_FILES "src/*.cc")
add_library(${PROJECT_NAME} SHARED ${SRC_FILES})

target_link_libraries(${PROJECT_NAME}
    ${ThirdParty_LIBRARIES}
    ${Boost_LIBRARIES})

install(TARGETS ${PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_LIBDIR})

# Copy the header file to the installation directory and maintain the directory structure
file(GLOB_RECURSE HEADER_FILES
  "${CMAKE_CURRENT_SOURCE_DIR}/*.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/*.hpp")
foreach(HEADER ${HEADER_FILES})
    file(RELATIVE_PATH RELATIVE_HEADER ${CMAKE_CURRENT_SOURCE_DIR} ${HEADER})
    get_filename_component(HEADER_PATH ${RELATIVE_HEADER} DIRECTORY)
    set(HEADER_INSTALL_PATH "include/${HEADER_PATH}")
    install(FILES ${HEADER} DESTINATION ${HEADER_INSTALL_PATH} COMPONENT headers)
endforeach()

add_subdirectory(test)