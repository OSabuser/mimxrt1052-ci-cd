# Add set(CONFIG_USE_driver_clock true) in config.cmake to use this component

include_guard(GLOBAL)

if(HAS_COMPONENT_driver_clock)

target_sources(${EXECUTABLE} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/fsl_clock.c
)

target_include_directories(${EXECUTABLE} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/.
)

else()

message(FATAL_ERROR  
  "HAS_COMPONENT_driver_clock = ${HAS_COMPONENT_driver_clock}  must be true!\n")

endif()
