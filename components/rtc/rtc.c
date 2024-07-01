#include "rtc.h"
#include "manufacturing_info.h"


void rtc_init(void) {
    snvs_hp_rtc_config_t snvsRtcConfig;
    snvs_hp_rtc_datetime_t rtcDate;

    /* Set a start date time and start RT */
    rtcDate.year   = 1000*CHAR_TO_INT(BUILD_YEAR_CH0) + \
    100*CHAR_TO_INT(BUILD_YEAR_CH1) + \
    10*CHAR_TO_INT(BUILD_YEAR_CH2) + \
    CHAR_TO_INT(BUILD_YEAR_CH3);

    rtcDate.month  = 10*CHAR_TO_INT(BUILD_MONTH_CH0) + CHAR_TO_INT(BUILD_MONTH_CH1);
    rtcDate.day    = 10*CHAR_TO_INT(BUILD_DAY_CH0) + CHAR_TO_INT(BUILD_DAY_CH1);
    rtcDate.hour   = 0U;
    rtcDate.minute = 0U;
    rtcDate.second = 0U;

    /* Init SNVS */
    /*
     * snvsConfig->rtccalenable = false;
     * snvsConfig->rtccalvalue = 0U;
     * snvsConfig->srtccalenable = false;
     * snvsConfig->srtccalvalue = 0U;
     * snvsConfig->PIFreq = 0U;
     */
    SNVS_HP_RTC_GetDefaultConfig(&snvsRtcConfig);
    SNVS_HP_RTC_Init(SNVS, &snvsRtcConfig);

    /* Start the RTC timer*/
    SNVS_HP_RTC_SetDatetime(SNVS, &rtcDate);
    SNVS_HP_RTC_StartTimer(SNVS);
}