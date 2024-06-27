# Add set(CONFIG_USE_driver_common true) in config.cmake to use this component

include_guard(GLOBAL)

if(HAS_COMPONENT_driver_clock AND HAS_COMPONENT_driver_common)

target_sources(${EXECUTABLE} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/fsl_common.c
)

target_sources(${EXECUTABLE} PRIVATE
      ${CMAKE_CURRENT_LIST_DIR}/fsl_common_arm.c
  )

target_include_directories(${EXECUTABLE} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/.
)

else()

message(FATAL_ERROR  
  "HAS_COMPONENT_driver_clock = ${HAS_COMPONENT_driver_clock}  
  HAS_COMPONENT_driver_common = ${HAS_COMPONENT_driver_common} must be true!\n")

endif()
