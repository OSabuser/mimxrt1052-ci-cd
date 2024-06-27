
include_guard(GLOBAL)

if(HAS_COMPONENT_hal_tim AND HAS_COMPONENT_generic_list AND HAS_COMPONENT_driver_pit AND HAS_COMPONENT_tim_manager)

target_sources(${EXECUTABLE} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/fsl_component_timer_manager.c
)

target_include_directories(${EXECUTABLE} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/.
)

else()

message(FATAL_ERROR  
  "HAS_COMPONENT_hal_tim = ${HAS_COMPONENT_hal_tim}, \
  HAS_COMPONENT_generic_list = ${HAS_COMPONENT_generic_list}, \
  HAS_COMPONENT_driver_pit = ${HAS_COMPONENT_driver_pit} \
  HAS_COMPONENT_tim_manager = ${HAS_COMPONENT_tim_manager} must be true!\n")

endif()