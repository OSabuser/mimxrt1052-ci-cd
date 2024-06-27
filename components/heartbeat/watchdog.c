#include "watchdog.h"
#include "fsl_wdog.h"
#include "fsl_debug_console.h"
#include "heartbeat_config.h"


#define BOARD_WATCHDOG_INSTANCE WDOG1
#define BOARD_WATCHDOG_MAX_TIMEOUT_SEC 128U



// TODO: create doc
static uint8_t watchdog_sec_to_count(uint8_t time_s)
{
    assert((time_s < BOARD_WATCHDOG_MAX_TIMEOUT_SEC) && (time_s > 0));
    return 2 * time_s - 1;
}

/*!
 * brief Initializes the WDOG.
 *
 * This function initializes the WDOG. When called, the WDOG runs according to the configuration.
 *
 */
void start_watchdog_timer(void)
{

    wdog_config_t watchdog_config = {
        .enableWdog = true,
        .workMode.enableWait = true,
        .workMode.enableStop = true,
        .workMode.enableDebug = true,
        .enableInterrupt = false,
        .enablePowerDown = false,
        .softwareResetExtension = false,
        .timeoutValue = watchdog_sec_to_count(WATCHDOG_TIMEOUT_SEC),
        .interruptTimeValue = 0x04u,
    };

    WDOG_Init(BOARD_WATCHDOG_INSTANCE, &watchdog_config);
}

//TODO: create doc
uint8_t get_watchdog_sec_timeout_value(void) {
    return WATCHDOG_TIMEOUT_SEC;
}


/*!
 * brief Shuts down the WDOG.
 *
 * This function shuts down the WDOG.
 * Watchdog Enable bit is a write one once only bit. It is not
 * possible to clear this bit by a software write, once the bit is set.
 * This bit(WDE) can be set/reset only in debug mode(exception).
 */
void stop_watchdog_timer(void)
{
    WDOG_Deinit(BOARD_WATCHDOG_INSTANCE);
}

/*!
 * brief Refreshes the WDOG timer.
 *
 * This function feeds the WDOG.
 * This function should be called before the WDOG timer is in timeout. Otherwise, a reset is asserted.
 *
 */
void feed_watchdog_timer(void)
{
    WDOG_Refresh(BOARD_WATCHDOG_INSTANCE);
}

/*!
 * brief Trigger the system software reset.
 *
 * This function will write to the WCR[SRS] bit to trigger a software system reset.
 * This bit will automatically resets to "1" after it has been asserted to "0".
 * Note: Calling this API will reset the system right now, please using it with more attention.
 *
 */
void trigger_system_software_reset(void)
{
    WDOG_TriggerSystemSoftwareReset(BOARD_WATCHDOG_INSTANCE);
}

/*!
 * brief Gets the WDOG all reset status flags.
 *
 * This function gets all reset status flags.
 *
 */
wdog_reset_reason_t get_system_reset_reason(void)
{
    uint16_t reset_flag = WDOG_GetStatusFlags(BOARD_WATCHDOG_INSTANCE);
    return reset_flag & (wRESET_BY_POWER_ON | wRESET_BY_TIMEOUT | wRESET_BY_SOFTWARE);
}

// TODO: create doc
void print_system_reset_reason(wdog_reset_reason_t status)
{
    switch (status)
    {
    case wRESET_BY_POWER_ON:
        DbgConsole_Printf("System was reseted by power on reset!\r\n");
        break;
    case wRESET_BY_TIMEOUT:
        DbgConsole_Printf("System was reseted by watchdog timeout!\r\n");
        break;
    case wRESET_BY_SOFTWARE:
        DbgConsole_Printf("System was reseted by software!\r\n");
        break;
    default:
        DbgConsole_Printf("System was reseted by undefined reason!\r\n");
        break;
    }
}

void WDOG1_IRQHandler(void)
{
    WDOG_ClearInterruptStatus(WDOG1, kWDOG_InterruptFlag);
    /* User code. User can do urgent case before timeout reset.
     * IE. user can backup the ram data or ram log to flash.
     * the period is set by config.interruptTimeValue, user need to
     * check the period between interrupt and timeout.
     */
}