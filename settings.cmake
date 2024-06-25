include_guard(GLOBAL)
message(STATUS "${CMAKE_CURRENT_LIST_FILE} component is included.")

if (NOT DEFINED ENV{ARMGCC_DIR})
	MESSAGE(FATAL_ERROR "$ENV{ARMGCC_DIR} have to be defined!")
endif()
if (NOT DEFINED ENV{LIBRARY_TYPE})
	SET(LIBRARY_TYPE REDLIB)
endif()
if (NOT DEFINED ENV{LANGUAGE})
	SET(LANGUAGE C)
endif()
if (NOT DEFINED ENV{DEBUG_CONSOLE})
	SET(DEBUG_CONSOLE UART)
endif()

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
