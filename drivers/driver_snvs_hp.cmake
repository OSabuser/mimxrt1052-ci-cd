# Add set(CONFIG_USE_driver_snvs_hp true) in config.cmake to use this component

include_guard(GLOBAL)
message("${CMAKE_CURRENT_LIST_FILE} component is included.")

if(HAS_COMPONENT_driver_snvs_hp)

target_sources(${EXECUTABLE} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/fsl_snvs_hp.c
)

target_include_directories(${EXECUTABLE} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/.
)

else()

message(FATAL_ERROR  
  "HAS_COMPONENT_driver_snvs_hp = ${HAS_COMPONENT_driver_snvs_hp} must be true!\n")

endif()
