/*
 * Copyright (c) 2015, Freescale Semiconductor, Inc.
 * Copyright 2016-2020 NXP
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#include "pin_mux.h"
#include "clock_config.h"
#include "board.h"
#include "fsl_debug_console.h"
#include "fsl_adapter_gpio.h"
#include "config.h"

/*******************************************************************************
 * Definitions
 ******************************************************************************/


/*******************************************************************************
 * Prototypes
 ******************************************************************************/

/*******************************************************************************
 * Variables
 ******************************************************************************/

/*******************************************************************************
 * Code
 ******************************************************************************/
/*!
 * @brief Main function
 */
int main(void)
{
    /* Board pin, clock, debug console init */
    BOARD_ConfigMPU();
    BOARD_InitBootPins();
    BOARD_InitBootClocks();
    BOARD_InitDebugConsole();

    // /* Init output LED GPIO. */
    GPIO_HANDLE_DEFINE(led_1);
    GPIO_HANDLE_DEFINE(led_2);
   
    hal_gpio_pin_config_t led_1_config = {
        .direction = kHAL_GpioDirectionOut,
        .level = 1,
        .port = 3,
        .pin = BOARD_INITPINS_ALIVE_LED_CHANNEL
    };

    hal_gpio_pin_config_t led_2_config = {
        .direction = kHAL_GpioDirectionOut,
        .level = 1,
        .port = 3,
        .pin = BOARD_INITPINS_PROCESS_LED_CHANNEL
    };

    HAL_GpioInit(led_1, &led_1_config);
    HAL_GpioInit(led_2, &led_2_config);


    /* Print a note to terminal. */
    PRINTF("Project:%s, version_number: %s%s\r\n", PROJECT_NAME, PROJECT_VERSION, UNIQUE_LETTER);
    uint8_t pin_state = 0;
    
    if(HAL_GpioGetInput(led_1, &pin_state) == kStatus_HAL_GpioSuccess) {
        PRINTF("Led 1 state #0: %d\n", pin_state);
    } else {
        PRINTF("Something goes wrong\n");
    }


    while (1)
    {
        HAL_GpioSetOutput(led_1, 0);
        HAL_GpioSetOutput(led_2, 0);

        if(HAL_GpioGetInput(led_1, &pin_state) == kStatus_HAL_GpioSuccess) {
            PRINTF("Led 1 state #1: %d\n", pin_state);
        } else {
            PRINTF("Something goes wrong\n");
        }

        SDK_DelayAtLeastUs(50000, SDK_DEVICE_MAXIMUM_CPU_CLOCK_FREQUENCY);
        HAL_GpioSetOutput(led_1, 1);
        HAL_GpioSetOutput(led_2, 1);
        if(HAL_GpioGetInput(led_1, &pin_state) == kStatus_HAL_GpioSuccess) {
            PRINTF("Led 1 state #2: %d\n", pin_state);
        } else {
            PRINTF("Something goes wrong\n");
        }
        SDK_DelayAtLeastUs(500000, SDK_DEVICE_MAXIMUM_CPU_CLOCK_FREQUENCY);
        DbgConsole_Printf("It is a test!\n");
    }
}
