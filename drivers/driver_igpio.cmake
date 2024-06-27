# Add set(CONFIG_USE_driver_igpio true) in config.cmake to use this component

include_guard(GLOBAL)

if(HAS_COMPONENT_driver_igpio)

target_sources(${EXECUTABLE} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/fsl_gpio.c
)

target_include_directories(${EXECUTABLE} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/.
)

else()

message(FATAL_ERROR  
  "HAS_COMPONENT_driver_igpio = ${HAS_COMPONENT_driver_igpio} must be true!\n")

endif()
