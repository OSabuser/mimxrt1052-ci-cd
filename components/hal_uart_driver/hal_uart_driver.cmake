include_guard(GLOBAL)
message("${CMAKE_CURRENT_LIST_FILE} component has been  included.\n")

if(HAS_COMPONENT_driver_lpuart AND HAS_COMPONENT_hal_uart_driver)

target_sources(${EXECUTABLE} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/fsl_adapter_lpuart.c
)

target_include_directories(${EXECUTABLE} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/.
)

else()

message(SEND_ERROR "HAS_COMPONENT_hal_uart_driver dependency does not meet, please check ${CMAKE_CURRENT_LIST_FILE}.\n")

endif()