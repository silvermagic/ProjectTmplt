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

# 方式一: 使用apt install libboost-dev能安装的, CMake能自动查找到的模块
find_package(Boost REQUIRED COMPONENTS system filesystem)
if(Boost_FOUND)
    include_directories(${Boost_INCLUDE_DIRS})
    
    MESSAGE(STATUS "Boost_INCLUDE_DIRS = ${Boost_INCLUDE_DIRS}")
    MESSAGE(STATUS "Boost_LIBRARY_DIRS = ${Boost_LIBRARY_DIRS}")
    MESSAGE(STATUS "Boost_LIBRARIES = ${Boost_LIBRARIES}")
endif()

# 方式二: 使用cmake --help-module-list能查询到的, CMake特殊处理的模块
# set(BOOST_ROOT /usr/local) # 设置非标准的安装路径
# set(Boost_NO_SYSTEM_PATHS ON)
# find_package(Boost REQUIRED COMPONENTS system filesystem)
# if(Boost_FOUND)
#     include_directories(${Boost_INCLUDE_DIRS})
    
#     MESSAGE(STATUS "Boost_INCLUDE_DIRS = ${Boost_INCLUDE_DIRS}")
#     MESSAGE(STATUS "Boost_LIBRARY_DIRS = ${Boost_LIBRARY_DIRS}")
#     MESSAGE(STATUS "Boost_LIBRARIES = ${Boost_LIBRARIES}")
# endif()

# 方式三: 使用pkg-config --list-all能查看到的, 特别适用于自己编译的第三方库(通过设置PKG_CONFIG_PATH)，如果依赖多个库，库名之间使用空格隔开
find_package(PkgConfig)
pkg_check_modules(ThirdParty REQUIRED fmt)
if(ThirdParty_FOUND)
    include_directories(${ThirdParty_INCLUDE_DIRS})
    
    MESSAGE(STATUS "ThirdParty_INCLUDE_DIRS = ${ThirdParty_INCLUDE_DIRS}")
    MESSAGE(STATUS "ThirdParty_LIBRARY_DIRS = ${ThirdParty_LIBRARY_DIRS}")
    MESSAGE(STATUS "ThirdParty_LIBRARIES = ${ThirdParty_LIBRARIES}")
endif()

# RPATH : https://gitlab.kitware.com/cmake/community/-/wikis/doc/cmake/RPATH-handling
set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/output)

file(GLOB_RECURSE SRC_FILES "src/*.cc")
add_executable(${PROJECT_NAME} ${SRC_FILES})

target_link_libraries(${PROJECT_NAME}
    ${ThirdParty_LIBRARIES}
    ${Boost_LIBRARIES})

install(TARGETS ${PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_BINDIR})