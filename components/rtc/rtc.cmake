include_guard(GLOBAL)

if(HAS_COMPONENT_rtc AND HAS_COMPONENT_driver_snvs_hp)


  target_sources(${EXECUTABLE} PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/rtc.c
  )

  target_include_directories(${EXECUTABLE} PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/.
  )

else()

message(FATAL_ERROR  
  "HAS_COMPONENT_rtc = ${HAS_COMPONENT_rtc}, \
  HAS_COMPONENT_driver_snvs_hp = ${HAS_COMPONENT_driver_snvs_hp} must be true!\n")

endif()