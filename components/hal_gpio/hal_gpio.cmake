include_guard(GLOBAL)

if(HAS_COMPONENT_driver_igpio AND HAS_COMPONENT_hal_gpio)

target_sources(${EXECUTABLE} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/fsl_adapter_igpio.c
)

target_include_directories(${EXECUTABLE} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/.
)

else()

message(FATAL_ERROR  
  "HAS_COMPONENT_driver_igpio = ${HAS_COMPONENT_driver_igpio}, \
  HAS_COMPONENT_hal_gpio = ${HAS_COMPONENT_hal_gpio}  must be true!\n")

endif()