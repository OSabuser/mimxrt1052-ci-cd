include_guard(GLOBAL)

if(HAS_COMPONENT_driver_lpuart AND HAS_COMPONENT_hal_uart)

target_sources(${EXECUTABLE} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/fsl_adapter_lpuart.c
)

target_include_directories(${EXECUTABLE} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/.
)

else()

message(FATAL_ERROR  
  "HAS_COMPONENT_hal_uart = ${HAS_COMPONENT_hal_uart}, \
  HAS_COMPONENT_driver_lpuart = ${HAS_COMPONENT_driver_lpuart} must be true!\n")

endif()