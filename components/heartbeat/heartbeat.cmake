include_guard(GLOBAL)

if(HAS_COMPONENT_hal_tim AND HAS_COMPONENT_hal_gpio AND HAS_COMPONENT_heartbeat)

  set(USE_WATCHDOG 0)
  set(USE_LOGGING 0)
  set(HEARTBEAT_PERIOD_MSEC 1000)
  set(WATCHDOG_TIMEOUT_SEC 10)

  if(HAS_COMPONENT_driver_wdog)
    target_sources(${EXECUTABLE} PRIVATE
      ${CMAKE_CURRENT_LIST_DIR}/watchdog.c
    )
    
    set(USE_WATCHDOG 1)

  endif()

  if(HAS_COMPONENT_easylogger)
    set(USE_LOGGING 1)
  endif()


  target_sources(${EXECUTABLE} PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/heartbeat.c
  )

  target_include_directories(${EXECUTABLE} PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/.
  )

  #set the default values are used in heartbeat_config.h 
  configure_file(${CMAKE_CURRENT_LIST_DIR}/heartbeat_config.h.in ${CMAKE_CURRENT_LIST_DIR}/heartbeat_config.h @ONLY)

else()

message(FATAL_ERROR  
  "HAS_COMPONENT_hal_tim = ${HAS_COMPONENT_hal_tim}, \
  HAS_COMPONENT_hal_gpio = ${HAS_COMPONENT_hal_gpio}, \
  HAS_COMPONENT_heartbeat = ${HAS_COMPONENT_heartbeat} must be true!\n")

endif()