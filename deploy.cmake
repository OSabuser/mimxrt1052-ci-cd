include_guard(GLOBAL)
message(STATUS "${CMAKE_CURRENT_LIST_FILE} component is included.")

SET(SPT_PROJECT_ROOT_PATH "C:/Development/MIMXRT1052/VSCODE/secure_provisioning/")
SET(SPT_PROJECT_INIT_SCRIPT_PATH "${SPT_PROJECT_ROOT_PATH}gen_scripts/")
SET(SPT_PROJECT_BIN_PATH "${SPT_PROJECT_ROOT_PATH}source_images")
SET(SPT_IMAGE_BUILD_SCRIPT_NAME build_image_win.bat)
SET(SPT_IMAGE_WRITE_SCRIPT_NAME write_image_win.bat)
SET(SPT_IMAGE_INIT_SCRIPT_NAME init_flashloader_win.bat)

# Copy the executable image to SPT project dir, build & download the generated image
function(deploy_target_to_board target)

    add_custom_command(
        TARGET ${target} POST_BUILD
    
        COMMAND ${CMAKE_COMMAND}
        ARGS -E copy $<TARGET_FILE:${target}> ${SPT_PROJECT_BIN_PATH}
  
        COMMAND ${CMAKE_COMMAND}
        ARGS -E copy ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${PROJECT_NAME}.srec ${SPT_PROJECT_BIN_PATH}
  
        COMMAND cd ${SPT_PROJECT_ROOT_PATH}

        # Build the bootable image for IMXRT1050
        COMMAND ${SPT_IMAGE_BUILD_SCRIPT_NAME}
        # Try to load the flashloader into the board
        COMMAND ${SPT_PROJECT_INIT_SCRIPT_PATH}${SPT_IMAGE_INIT_SCRIPT_NAME}
        COMMAND ${SPT_IMAGE_WRITE_SCRIPT_NAME}

    )
endfunction()

   