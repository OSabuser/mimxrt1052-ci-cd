

include_guard(GLOBAL)

if(HAS_COMPONENT_driver_ocotp)

target_sources(${EXECUTABLE} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/fsl_ocotp.c
)

target_include_directories(${EXECUTABLE} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/.
)

else()

message(FATAL_ERROR  
  "HAS_COMPONENT_driver_ocotp = ${HAS_COMPONENT_driver_ocotp}  must be true!\n")

endif()
