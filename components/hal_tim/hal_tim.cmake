include_guard(GLOBAL)


if(HAS_COMPONENT_hal_tim AND HAS_COMPONENT_driver_pit)

target_sources(${EXECUTABLE} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/fsl_adapter_pit.c
)

target_include_directories(${EXECUTABLE} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/.
)

else()

message(FATAL_ERROR  
  "HAS_COMPONENT_hal_tim = ${HAS_COMPONENT_hal_tim}, \
  HAS_COMPONENT_driver_pit = ${HAS_COMPONENT_driver_pit}  must be true!\n")
endif()