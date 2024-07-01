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
#include "manufacturing_info.h"
#include "heartbeat.h"
#include "fsl_ocotp.h"
#include <elog.h>
/*******************************************************************************
 * Definitions
 ******************************************************************************/
#define LOG_TAG "main" /* Current sourcefile Tag */

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

    /* initialize EasyLogger */
    elog_init();

    /* set EasyLogger log format */
    elog_set_fmt(ELOG_LVL_ASSERT, ELOG_FMT_ALL);
    elog_set_fmt(ELOG_LVL_ERROR, ELOG_FMT_LVL | ELOG_FMT_TAG | ELOG_FMT_TIME);
    elog_set_fmt(ELOG_LVL_WARN, ELOG_FMT_LVL | ELOG_FMT_TAG | ELOG_FMT_TIME);
    elog_set_fmt(ELOG_LVL_INFO, ELOG_FMT_LVL | ELOG_FMT_TAG | ELOG_FMT_TIME);
    elog_set_fmt(ELOG_LVL_DEBUG, ELOG_FMT_ALL & ~(ELOG_FMT_FUNC | ELOG_FMT_T_INFO | ELOG_FMT_P_INFO));
    elog_set_fmt(ELOG_LVL_VERBOSE, ELOG_FMT_ALL & ~(ELOG_FMT_FUNC | ELOG_FMT_T_INFO | ELOG_FMT_P_INFO));

    /* start EasyLogger */
    elog_start();

    /* Print a note to terminal. */
    log_i("BOARD: TFT");
    log_i("Project:%s, version_number: %s%s \r\n", PROJECT_NAME, PROJECT_VERSION, UNIQUE_LETTER);

    start_heartbeat_routine();

    OCOTP_Init(OCOTP, CLOCK_GetFreq(kCLOCK_IpgClk));

    uint32_t ID_0, ID_1;
    /* Get the Unique ID. */
    ID_0 = OCOTP->CFG0;
    ID_1 = OCOTP->CFG1;

    log_i("ID: 0x%08X,0x%08X", ID_0, ID_1);

    while (1)
    {
        log_w("We are still alive!");
        SDK_DelayAtLeastUs(4000000, SDK_DEVICE_MAXIMUM_CPU_CLOCK_FREQUENCY);
    }
}
