file(GLOB_RECURSE SRC_FILES "*.cc")
add_executable(${PROJECT_NAME} ${SRC_FILES})

target_link_libraries(${PROJECT_NAME}
    ${BASE_LIB}
    ${ThirdParty_LIB}
    ${SYS_LIB}
    ${BOOST_LIBS})

install(TARGETS ${PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_BINDIR})