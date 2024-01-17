file(GLOB_RECURSE SRC_FILES "*.cc")
add_library(${PROJECT_NAME} SHARED ${SRC_FILES})

custom_target_link_libraries(${PROJECT_NAME}
    ${BASE_LIB}
    ${ThirdParty_LIB}
    ${SYS_LIB}
    ${BOOST_LIBS})

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