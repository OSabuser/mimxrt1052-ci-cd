# EASYLOGGER COMPONENT

include_guard(GLOBAL)


if(HAS_COMPONENT_serial_manager AND HAS_COMPONENT_easylogger)

target_sources(${EXECUTABLE} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/src/elog.c
  ${CMAKE_CURRENT_LIST_DIR}/src/elog_buf.c
  ${CMAKE_CURRENT_LIST_DIR}/src/elog_utils.c
  ${CMAKE_CURRENT_LIST_DIR}/port/elog_port.c
)

target_include_directories(${EXECUTABLE} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/inc
)

else()

message(FATAL_ERROR  
  "HAS_COMPONENT_easylogger = ${HAS_COMPONENT_easylogger}, \
  HAS_COMPONENT_serial_manager = ${HAS_COMPONENT_serial_manager} must be true!\n")

endif()