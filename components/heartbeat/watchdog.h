#ifndef WATCHDOG_H
#define WATCHDOG_H


/*!
 * @brief Initializes the WDOG.
 *
 * This function initializes the WDOG. When called, the WDOG runs according to the configuration.
 *
 */
void start_watchdog_timer(void);

/*!
 * @brief Shuts down the WDOG.
 *
 * This function shuts down the WDOG.
 * Watchdog Enable bit is a write one once only bit. It is not
 * possible to clear this bit by a software write, once the bit is set.
 * This bit(WDE) can be set/reset only in debug mode(exception).
 */
void stop_watchdog_timer(void);

/*!
 * @brief Refreshes the WDOG timer.
 *
 * This function feeds the WDOG.
 * This function should be called before the WDOG timer is in timeout. Otherwise, a reset is asserted.
 *
 */
void feed_watchdog_timer(void);

typedef enum
{
    wRESET_BY_POWER_ON  = (0x10U),  /*!< Power On flag, set when reset is the result of a powerOnReset*/
    wRESET_BY_TIMEOUT  = (0x2U), /*!< Timeout flag, set when reset is the result of a timeout*/
    wRESET_BY_SOFTWARE = (0x1U) /*!< Software flag, set when reset is the result of a software*/
} wdog_reset_reason_t;

/*!
 * @brief Gets the WDOG all reset status flags.
 *
 * This function gets all reset status flags.
 *
 */
wdog_reset_reason_t get_system_reset_reason(void);

//TODO: create doc
void print_system_reset_reason(wdog_reset_reason_t status);

//TODO: create doc
unsigned char get_watchdog_sec_timeout_value(void);

/*!
 * @brief Trigger the system software reset.
 *
 * This function will write to the WCR[SRS] bit to trigger a software system reset.
 * This bit will automatically resets to "1" after it has been asserted to "0".
 * Note: Calling this API will reset the system right now, please using it with more attention.
 *
 */
void trigger_system_software_reset(void);

#endif