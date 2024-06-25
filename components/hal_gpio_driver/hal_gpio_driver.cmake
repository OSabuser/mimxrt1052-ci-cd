include_guard(GLOBAL)

if(HAS_COMPONENT_driver_igpio AND HAS_COMPONENT_hal_gpio_driver)

message("${CMAKE_CURRENT_LIST_FILE} component has been included.\n")

target_sources(${EXECUTABLE} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/fsl_adapter_igpio.c
)

target_include_directories(${EXECUTABLE} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/.
)

else()

message(SEND_ERROR "HAS_COMPONENT_hal_gpio_driver dependency does not meet, please check ${CMAKE_CURRENT_LIST_FILE}.\n")

endif()