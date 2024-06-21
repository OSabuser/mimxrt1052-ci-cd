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
#include "fsl_gpio.h"

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
    /* Define the init structure for the output LED pin*/
    gpio_pin_config_t led_config = {kGPIO_DigitalOutput, LOGIC_LED_OFF, kGPIO_NoIntmode};

    /* Board pin, clock, debug console init */
    BOARD_ConfigMPU();
    BOARD_InitBootPins();
    BOARD_InitBootClocks();
    BOARD_InitDebugConsole();


    /* Print a note to terminal. */
    PRINTF("\r\n GPIO Driver example\r\n");
    PRINTF("\r\n The LED is blinking.\r\n");

    /* Init output LED GPIO. */
    GPIO_PinInit(BOARD_INITPINS_PROCESS_LED_GPIO,
    		BOARD_INITPINS_PROCESS_LED_GPIO_PIN,
			&led_config);
    GPIO_PinInit(BOARD_INITPINS_ALIVE_LED_GPIO,
    		BOARD_INITPINS_ALIVE_LED_GPIO_PIN,
			&led_config);

    while (1)
    {
        GPIO_PinWrite(BOARD_INITPINS_PROCESS_LED_GPIO, BOARD_INITPINS_PROCESS_LED_GPIO_PIN, LOGIC_LED_ON);
        SDK_DelayAtLeastUs(50000, SDK_DEVICE_MAXIMUM_CPU_CLOCK_FREQUENCY);
        GPIO_PinWrite(BOARD_INITPINS_PROCESS_LED_GPIO, BOARD_INITPINS_PROCESS_LED_GPIO_PIN, LOGIC_LED_OFF);
        SDK_DelayAtLeastUs(500000, SDK_DEVICE_MAXIMUM_CPU_CLOCK_FREQUENCY);
    }
}
