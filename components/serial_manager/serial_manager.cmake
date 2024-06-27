# Add set(HAS_COMPONENT_serial_manager true) in config.cmake to use this component

include_guard(GLOBAL)


if(HAS_COMPONENT_hal_uart AND HAS_COMPONENT_serial_manager AND HAS_COMPONENT_generic_list)

target_sources(${EXECUTABLE} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/fsl_component_serial_manager.c
  ${CMAKE_CURRENT_LIST_DIR}/fsl_component_serial_port_uart.c
)

target_include_directories(${EXECUTABLE} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/.
)

target_compile_definitions(${EXECUTABLE} PUBLIC
    -DSERIAL_PORT_TYPE_UART=1
)

else()

message(FATAL_ERROR  
  "HAS_COMPONENT_hal_uart = ${HAS_COMPONENT_hal_uart}, \
  HAS_COMPONENT_serial_manager = ${HAS_COMPONENT_serial_manager}, \
  HAS_COMPONENT_generic_list = ${HAS_COMPONENT_generic_list} must be true!\n")

endif()
