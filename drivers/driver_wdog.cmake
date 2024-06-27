# Add set(CONFIG_USE_driver_wdog01 true) in config.cmake to use this component

include_guard(GLOBAL)

if(HAS_COMPONENT_driver_wdog)

target_sources(${EXECUTABLE} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/fsl_wdog.c
)

target_include_directories(${EXECUTABLE} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/.
)

else()

message(FATAL_ERROR  
  "HAS_COMPONENT_driver_wdog = ${HAS_COMPONENT_driver_wdog} must be true!\n")


endif()
