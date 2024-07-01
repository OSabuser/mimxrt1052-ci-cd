/*
 * This file is part of the EasyLogger Library.
 *
 * Copyright (c) 2015, Armink, <armink.ztl@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * 'Software'), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * Function: Portable interface for each platform.
 * Created on: 2015-04-28
 */

#include <elog.h>
#include "cmsis_gcc.h"
#include "board.h"
#include "fsl_debug_console.h"
#include <stdio.h>

#ifdef HAS_RTC
    #include "rtc.h"
#endif

/**
 * EasyLogger port initialize
 *
 * @return result
 */
ElogErrCode elog_port_init(void)
{
    ElogErrCode result = ELOG_NO_ERR;

    /* add your code here */
    BOARD_InitDebugConsole();
#ifdef HAS_RTC
    rtc_init();
#endif
    return result;
}

/**
 * EasyLogger port deinitialize
 *
 */
void elog_port_deinit(void)
{

    /* add your code here */
}

/**
 * output log port interface
 *
 * @param log output of log
 * @param size log size
 */
void elog_port_output(const char *log, size_t size)
{

    /* add your code here */
    DbgConsole_Printf("%s", log);
    (void)size;
}

/**
 * output lock
 */
void elog_port_output_lock(void)
{

    /* add your code here */
    __disable_irq();
}

/**
 * output unlock
 */
void elog_port_output_unlock(void)
{

    /* add your code here */
    __enable_irq();
    SDK_DelayAtLeastUs(5000, SDK_DEVICE_MAXIMUM_CPU_CLOCK_FREQUENCY);
}

/**
 * get current time interface
 *
 * @return current time
 */
const char *elog_port_get_time(void)
{

    static char time[9];

#ifdef HAS_RTC

    snvs_hp_rtc_datetime_t rtc_time;

    /* Get current date time */
    SNVS_HP_RTC_GetDatetime(SNVS, &rtc_time);
    sprintf(time, "%02hd:%02hd:%02hd", rtc_time.hour, rtc_time.minute, rtc_time.second);
#else
    sprintf(time, "%s", "none");
#endif

    /* add your code here */
    return time;
}

/**
 * get current process name interface
 *
 * @return current process name
 */
const char *elog_port_get_p_info(void)
{

    /* add your code here */
    return "pid:0";
}

/**
 * get current thread name interface
 *
 * @return current thread name
 */
const char *elog_port_get_t_info(void)
{

    /* add your code here */
    return "main.c";
}