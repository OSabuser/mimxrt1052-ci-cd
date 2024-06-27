include_guard(GLOBAL)
message(STATUS "${CMAKE_CURRENT_LIST_FILE} component is included.")

# Check if ${module_name} must be included to current build
function(include_if_use module_name)

    message(STATUS "\n Search for ${module_name} module")
    
    set(IS_MATCH_FOUND false)

    message(STATUS "Is module enabled: ${HAS_COMPONENT_${module_name}}")
    
    if(${HAS_COMPONENT_${module_name}})
        set(IS_MATCH_FOUND true)
    endif()

    if(IS_MATCH_FOUND)
    
        include(${module_name} OPTIONAL RESULT_VARIABLE loaded_file)
    
        if(EXISTS ${loaded_file})
            message(STATUS "INCLUDE: ${loaded_file}\n")
            return()
        else()
            message(SEND_ERROR "ERROR: ${loaded_file}.cmake does not exist.\n")
        endif()
    else()
        message(STATUS "SKIP\n")
    endif()
endfunction()




# Root path's to additional component's source files
set(COMPONENTS_DIR ${PROJECT_SOURCE_DIR}/components)
set(DRIVERS_DIR ${PROJECT_SOURCE_DIR}/drivers)



#*********************************************DRIVERS
# description: fsl_clock driver
set(HAS_COMPONENT_driver_clock true)
# description: fsl_common driver
set(HAS_COMPONENT_driver_common true)
# description: fsl_gpio driver
set(HAS_COMPONENT_driver_igpio true)
# description: fsl_iomux driver
set(HAS_COMPONENT_driver_iomuxc true)
# description: fsl_lpuart driver
set(HAS_COMPONENT_driver_lpuart true)
# description: fsl_pit driver
set(HAS_COMPONENT_driver_pit true)
# description: fsl_gpt driver
set(HAS_COMPONENT_driver_gpt false)
# description: fsl_wdog driver
set(HAS_COMPONENT_driver_wdog true)

#*********************************************COMPONENTS
# description: HAL GPIO API
set(HAS_COMPONENT_hal_gpio true)
# description: HAL Uart API
set(HAS_COMPONENT_hal_uart true)
# description: HAL Timer API
set(HAS_COMPONENT_hal_tim true)
# description: Timer manager API
set(HAS_COMPONENT_tim_manager false)
# description: HAL Button API
set(HAS_COMPONENT_hal_button false)
# description: Serial manager API
set(HAS_COMPONENT_serial_manager true)
# description: Generic list API
set(HAS_COMPONENT_generic_list true)
# description: Heartbeat API
set(HAS_COMPONENT_heartbeat true)



# Paths to extra modules
list(APPEND CMAKE_MODULE_PATH
    ${COMPONENTS_DIR}/hal_gpio
    ${COMPONENTS_DIR}/hal_tim
    ${COMPONENTS_DIR}/hal_button
    ${COMPONENTS_DIR}/hal_uart
    ${COMPONENTS_DIR}/generic_list
    ${COMPONENTS_DIR}/tim_manager
    ${COMPONENTS_DIR}/serial_manager
    ${COMPONENTS_DIR}/heartbeat
    ${DRIVERS_DIR}
)

# Include the required components

# DRIVERS
include_if_use(driver_clock)
include_if_use(driver_common)
include_if_use(driver_gpt)
include_if_use(driver_igpio)
include_if_use(driver_iomuxc)
include_if_use(driver_lpuart)
include_if_use(driver_pit)
include_if_use(driver_wdog)

# COMPONENTS
include_if_use(hal_gpio)
include_if_use(hal_uart)
include_if_use(hal_tim)
include_if_use(generic_list)
include_if_use(tim_manager)
include_if_use(serial_manager)
include_if_use(heartbeat)

