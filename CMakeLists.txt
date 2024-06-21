cmake_minimum_required(VERSION 3.15.3)

set(CMAKE_VERBOSE_MAKEFILE OFF)

# Path to toolchain file. This one has to be before 'project()' below
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_SOURCE_DIR}/armgcc.cmake)

# Path to ld script file
set(LINKER_FILE ${CMAKE_SOURCE_DIR}/device/template_project_debug.ld)
set(PROJECT_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR})




project(gpio_led_output)
set(EXECUTABLE ${PROJECT_NAME}.elf)

enable_language(C ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)

include(${PROJECT_ROOT_DIR}/settings.cmake)

# List of source files
set(SRC_FILES 
        "${PROJECT_ROOT_DIR}/board/pin_mux.c"
        "${PROJECT_ROOT_DIR}/board/dcd.c"
        "${PROJECT_ROOT_DIR}/board/clock_config.c"
        "${PROJECT_ROOT_DIR}/board/board.c"
        "${PROJECT_ROOT_DIR}/component/uart/fsl_adapter_lpuart.c"
        "${PROJECT_ROOT_DIR}/component/lists/fsl_component_generic_list.c"
        "${PROJECT_ROOT_DIR}/device/system_MIMXRT1052.c"
        "${PROJECT_ROOT_DIR}/device/startup_mimxrt1052.c"
        "${PROJECT_ROOT_DIR}/drivers/fsl_lpuart.c"
        "${PROJECT_ROOT_DIR}/drivers/fsl_gpio.c"
        "${PROJECT_ROOT_DIR}/drivers/fsl_common_arm.c"
        "${PROJECT_ROOT_DIR}/drivers/fsl_common.c"
        "${PROJECT_ROOT_DIR}/drivers/fsl_clock.c"
        "${PROJECT_ROOT_DIR}/source/gpio_led_output.c"
        "${PROJECT_ROOT_DIR}/utilities/fsl_str.c"
        "${PROJECT_ROOT_DIR}/utilities/fsl_memcpy.S"
        "${PROJECT_ROOT_DIR}/utilities/fsl_debug_console.c"
        "${PROJECT_ROOT_DIR}/utilities/fsl_assert.c"
        "${PROJECT_ROOT_DIR}/xip/fsl_flexspi_nor_boot.c"
        "${PROJECT_ROOT_DIR}/xip/evkbimxrt1050_flexspi_nor_config.c"
)


# Set output bin directory
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_ROOT_DIR}/build/binaries)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${EXECUTABLE_OUTPUT_PATH})

# Build the executable based on the source files
add_executable(${EXECUTABLE} ${SRC_FILES})

# Link REDLIB
if(${LIBRARY_TYPE} STREQUAL "REDLIB")
    target_include_directories(${EXECUTABLE} PRIVATE $ENV{ARMGCC_DIR}/redlib/include)
    MESSAGE(STATUS "REDLIB WAS FOUND: $ENV{ARMGCC_DIR}/redlib/include")
endif()

# List of compiler defines, prefix with -D compiler option
target_compile_definitions(${EXECUTABLE} PRIVATE
        -DXIP_BOOT_HEADER_DCD_ENABLE=0 
        -DXIP_EXTERNAL_FLASH=1 
        -DXIP_BOOT_HEADER_ENABLE=0 
        -DMCUXPRESSO_SDK 
        -DSDRAM_MPU_INIT=0 
        -DSKIP_SYSCLK_INIT=0 
        -DPRINTF_FLOAT_ENABLE=0 
        -DCR_INTEGER_PRINTF 
        -D__MCUXPRESSO 
        -D__USE_CMSIS 
        -DDEBUG 
        -DCPU_MIMXRT1052CVJ5B 
        -DCPU_MIMXRT1052CVJ5B_cm7 
)

# List of include directories
target_include_directories(${EXECUTABLE} PRIVATE 
        source
        utilities
        drivers
        device
        component/uart
        component/lists
        xip
        CMSIS
        board
)

# Compiler options
target_compile_options(${EXECUTABLE} PRIVATE
        -std=gnu11 
        -O0 
        -fno-common 
        -fmerge-constants 
        -g3 
        -ffunction-sections -fdata-sections -ffreestanding -fno-builtin 
        -fstack-usage 
        -mcpu=cortex-m7 
        -mthumb 
)

# Linker options
target_link_options(${EXECUTABLE} PRIVATE
        -T${LINKER_FILE}
        -mcpu=cortex-m7 
        -mthumb 
        -Xlinker -no-warn-rwx-segments -Xlinker     
        -Wl,-Map=${PROJECT_NAME}.map,--cref
        -Wl,--gc-sections 
        -Wl,-print-memory-usage
)


# Optional: Print executable size as part of the post build process
add_custom_command(TARGET ${EXECUTABLE}
        POST_BUILD
        COMMAND ${CMAKE_SIZE_UTIL} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${EXECUTABLE})

# Optional: Create hex, bin and S-Record files after the build
add_custom_command(TARGET ${EXECUTABLE}
        POST_BUILD
        COMMAND cd ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
        COMMAND ${CMAKE_OBJCOPY} -O srec --srec-len=64 ${EXECUTABLE} ${PROJECT_NAME}.s19
        COMMAND ${CMAKE_OBJCOPY} -O ihex ${EXECUTABLE} ${PROJECT_NAME}.hex
        COMMAND ${CMAKE_OBJCOPY} -O binary ${EXECUTABLE} ${PROJECT_NAME}.bin)
