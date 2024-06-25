# Add set(CONFIG_USE_driver_gpt true) in config.cmake to use this component

include_guard(GLOBAL)
message("${CMAKE_CURRENT_LIST_FILE} component is included.")

if(HAS_COMPONENT_driver_gpt)

target_sources(${EXECUTABLE} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/fsl_gpt.c
)

target_include_directories(${EXECUTABLE} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/.
)

else()

message(SEND_ERROR "HAS_COMPONENT_driver_gpt dependency does not meet, please check ${CMAKE_CURRENT_LIST_FILE}.")

endif()
