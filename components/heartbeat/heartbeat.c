#include "heartbeat.h"
#include "fsl_adapter_timer.h"
#include "fsl_debug_console.h"
#include "fsl_adapter_gpio.h"
#include "fsl_common_arm.h"
#include "heartbeat_config.h"


/* Possible values are (GPIO3, PIN3), (GPIO3, PIN4) !*/
#define HEARTBEAT_LED_PORT 3U
#define HEARTBEAT_LED_PIN 3U

#if USE_WATCHDOG
    #include "watchdog.h"
#endif

#if USE_LOGGING
    #include <elog.h>
    #define LOG_TAG    "heartbeat" /* Current sourcefile Tag */
#endif

static GPIO_HANDLE_DEFINE(heartbeat_led);
static TIMER_HANDLE_DEFINE(heartbeat_routine_timer);

// TODO: create doc
static void toggle_heartbeat_led(hal_gpio_handle_t gpio_handle)
{
    static uint8_t pin_state = 0;

    pin_state ^= 1;

    HAL_GpioSetOutput(gpio_handle, pin_state);
}


// TODO: create doc
static void heartbeat_timer_routine(void *param)
{
    toggle_heartbeat_led(param);
 
#if USE_WATCHDOG
    feed_watchdog_timer();
#endif
}

// TODO: create doc
static void init_heartbeat_led(hal_gpio_handle_t gpio_handle)
{

    hal_gpio_pin_config_t heartbeat_led_config = {
        .direction = kHAL_GpioDirectionOut,
        .level = 1,
        .port = HEARTBEAT_LED_PORT,
        .pin = HEARTBEAT_LED_PIN};

    assert(HAL_GpioInit(gpio_handle, &heartbeat_led_config) == kStatus_HAL_GpioSuccess);
}

// TODO: create doc
static void init_heartbeat_tim(hal_timer_handle_t heartbeat_timer_handle, hal_gpio_handle_t heartbeat_gpio_handle, uint16_t timeout_ms)
{

    uint32_t timer_source_clock = CLOCK_GetFreq(kCLOCK_PerClk);

    hal_timer_config_t heartbeat_timer_config = {
        .timeout = 1000 * HEARTBEAT_PERIOD_MSEC,
        .srcClock_Hz = timer_source_clock,
        .instance = 0,
    };

    assert(HAL_TimerInit(heartbeat_timer_handle, &heartbeat_timer_config) == kStatus_HAL_TimerSuccess);

    HAL_TimerInstallCallback(heartbeat_timer_handle, heartbeat_timer_routine, heartbeat_gpio_handle);

    HAL_TimerEnable(heartbeat_timer_handle);
}

// TODO: create doc
uint8_t start_heartbeat_routine(void)
{

    uint8_t reset_status = 0xFF;

#if USE_LOGGING
    log_i("Enable the heartbeat routine.\r\n");
    log_i("Heartbeat period is %d ms. \r\n", HEARTBEAT_PERIOD_MSEC);
#endif
    init_heartbeat_led(heartbeat_led);

    init_heartbeat_tim(heartbeat_routine_timer, heartbeat_led, HEARTBEAT_PERIOD_MSEC);

#if USE_WATCHDOG
    #if USE_LOGGING
        log_i("Watchdog is enabled.\r\n");
        log_i("Watchdog's timeout is %d s.\r\n", get_watchdog_sec_timeout_value());

        reset_status = get_system_reset_reason();

        switch (reset_status)
        {
            case wRESET_BY_POWER_ON:
                log_w("System was reseted by power on reset!\r\n");
            break;
            case wRESET_BY_TIMEOUT:
                log_w("System was reseted by watchdog timeout!\r\n");
            break;
            case wRESET_BY_SOFTWARE:
                log_w("System was reseted by software!\r\n");
            break;
            default:
                log_w("System was reseted by undefined reason!\r\n");
            break;
        }
    #endif
    
    /* Start the BOARD_WATCHDOG_INSTANCE timer*/
    start_watchdog_timer();
#else
    #if USE_LOGGING
        log_i("Watchdog is disabled.\r\n");
    #endif
#endif

    return reset_status;
}


