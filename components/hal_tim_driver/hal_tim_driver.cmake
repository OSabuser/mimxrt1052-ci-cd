include_guard(GLOBAL)
message("${CMAKE_CURRENT_LIST_FILE} component is included.")

if(HAS_COMPONENT_hal_tim_driver AND HAS_COMPONENT_driver_pit)

target_sources(${EXECUTABLE} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/fsl_adapter_pit.c
)

target_include_directories(${EXECUTABLE} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/.
)

else()

message(SEND_ERROR "hal_tim_driver dependency does not meet, please check ${CMAKE_CURRENT_LIST_FILE}.")

endif()