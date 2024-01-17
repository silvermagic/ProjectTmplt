cmake_minimum_required(VERSION 3.10.2)
project(sample)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_FLAGS "-O3 ")
set(CMAKE_C_FLAGS "-O3 ")
set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/output)

include_directories(/usr/local/include)

file(GLOB_RECURSE SRC_FILES "*.cc")
add_executable(${PROJECT_NAME} ${SRC_FILES})

target_link_libraries(${PROJECT_NAME}
    fmt
    boost_system
    boost_filesystem)

install(TARGETS ${PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_BINDIR})