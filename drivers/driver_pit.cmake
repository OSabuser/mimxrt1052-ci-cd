# Add set(CONFIG_USE_driver_pit true) in config.cmake to use this component

include_guard(GLOBAL)
message("${CMAKE_CURRENT_LIST_FILE} component is included.")

if(HAS_COMPONENT_driver_pit)

target_sources(${EXECUTABLE} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/fsl_pit.c
)

target_include_directories(${EXECUTABLE} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/.
)

else()

message(SEND_ERROR "driver_pit.MIMXRT1052 dependency does not meet, please check ${CMAKE_CURRENT_LIST_FILE}.")

endif()
