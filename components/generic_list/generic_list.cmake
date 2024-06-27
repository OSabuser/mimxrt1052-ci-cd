# Add set(CONFIG_USE_component_lists true) in config.cmake to use this component

include_guard(GLOBAL)

if(HAS_COMPONENT_generic_list)

target_sources(${EXECUTABLE} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/fsl_component_generic_list.c
)

target_include_directories(${EXECUTABLE} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/.
)

else()

message(FATAL_ERROR  
  "HAS_COMPONENT_generic_list = ${HAS_COMPONENT_generic_list}  must be true!\n")

endif()
