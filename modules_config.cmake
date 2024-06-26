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
            message(STATUS "OK: ${loaded_file} was found\n")
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

# description: HAL GPIO API
set(HAS_COMPONENT_hal_gpio_driver true)
# description: HAL Uart API
set(HAS_COMPONENT_hal_uart_driver true)
# description: HAL Timer API
set(HAS_COMPONENT_hal_tim_driver true)
# description: Timer manager API
set(HAS_COMPONENT_tim_manager false)
# description: HAL Button API
set(HAS_COMPONENT_hal_button_driver false)
# description: Generic list API
set(HAS_COMPONENT_generic_list false)


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

# Paths to extra modules
list(APPEND CMAKE_MODULE_PATH
    ${COMPONENTS_DIR}/hal_gpio_driver 
    ${COMPONENTS_DIR}/hal_tim_driver
    ${COMPONENTS_DIR}/hal_button_driver
    ${COMPONENTS_DIR}/hal_uart_driver
    ${COMPONENTS_DIR}/generic_list
    ${COMPONENTS_DIR}/tim_manager
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


# COMPONENTS
include_if_use(hal_gpio_driver)
include_if_use(hal_uart_driver)
include_if_use(hal_tim_driver)




