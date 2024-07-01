cmake_minimum_required(VERSION 3.30.0)

project(main_programm VERSION "0.2")

enable_language(C ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)

set(EXECUTABLE ${PROJECT_NAME}.elf)


# Set version info header
set(PROJECT_CODE_LETTER "X")
configure_file(${PROJECT_SOURCE_DIR}/manufacturing_info.h.in ${PROJECT_SOURCE_DIR}/source/manufacturing_info.h @ONLY)


# Path to ld script file
set(LINKER_FILE ${PROJECT_SOURCE_DIR}/device/template_project_debug.ld)


include(${PROJECT_SOURCE_DIR}/settings.cmake)



# List of source files
set(SRC_FILES 
        "${PROJECT_SOURCE_DIR}/board/pin_mux.c"
        "${PROJECT_SOURCE_DIR}/board/dcd.c"
        "${PROJECT_SOURCE_DIR}/board/clock_config.c"
        "${PROJECT_SOURCE_DIR}/board/board.c"
        "${PROJECT_SOURCE_DIR}/device/system_MIMXRT1052.c"
        "${PROJECT_SOURCE_DIR}/device/startup_mimxrt1052.c"
        "${PROJECT_SOURCE_DIR}/source/main.c"
        "${PROJECT_SOURCE_DIR}/utilities/fsl_str.c"
        "${PROJECT_SOURCE_DIR}/utilities/fsl_memcpy.S"
        "${PROJECT_SOURCE_DIR}/utilities/fsl_debug_console.c"
        "${PROJECT_SOURCE_DIR}/utilities/fsl_assert.c"
        "${PROJECT_SOURCE_DIR}/xip/fsl_flexspi_nor_boot.c"
        "${PROJECT_SOURCE_DIR}/xip/evkbimxrt1050_flexspi_nor_config.c"
)


# Set output bin directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/build/binaries)

# Build the executable based on the source files
add_executable(${EXECUTABLE} ${SRC_FILES})

# Link REDLIB
if(${LIBRARY_TYPE} STREQUAL "REDLIB")
    target_include_directories(${EXECUTABLE} PRIVATE $ENV{ARMGCC_DIR}/redlib/include)
    MESSAGE(STATUS "REDLIB WAS FOUND: /../$ENV{ARMGCC_DIR}/redlib/include")
endif()


# List of compiler defines, prefix with -D compiler option
target_compile_definitions(${EXECUTABLE} PRIVATE
        -DSDK_DEBUGCONSOLE_UART 
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
        -DDEBUG_CONSOLE_TRANSFER_NON_BLOCKING
        -DSDK_DELAY_USE_DWT
)


# List of include directories
target_include_directories(${EXECUTABLE} PRIVATE 
        source
        utilities
        device
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

# Include additional software components
include(${PROJECT_SOURCE_DIR}/modules_config.cmake)


# Print executable size as part of the post build process
add_custom_command(
        TARGET ${EXECUTABLE} POST_BUILD  
        COMMAND ${CMAKE_SIZE_UTIL} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${EXECUTABLE}
)

# Create S-Record file after the build
add_custom_command(
        TARGET ${EXECUTABLE} POST_BUILD
        COMMAND cd ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
        COMMAND ${CMAKE_OBJCOPY} -O srec --srec-len=64 ${EXECUTABLE} ${PROJECT_NAME}.srec
)

#include(${PROJECT_SOURCE_DIR}/deploy.cmake)
#deploy_target_to_board(${EXECUTABLE})     