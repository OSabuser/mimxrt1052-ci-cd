# Add set(CONFIG_USE_driver_iomuxc true) in config.cmake to use this component

include_guard(GLOBAL)

if(HAS_COMPONENT_driver_iomuxc)

target_include_directories(${EXECUTABLE} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/.
)

else()

message(FATAL_ERROR  
  "HAS_COMPONENT_driver_iomuxc = ${HAS_COMPONENT_driver_iomuxc} must be true!\n")

endif()
