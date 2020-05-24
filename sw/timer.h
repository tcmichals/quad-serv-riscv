
#define TIMER_BASE_REG 0x80000000
#define TIMER_REG_OFFSET 0
#define TIMER_CMP_OFFSET 4
#define TIMER_STATUS_OFFSET 8

#define TIMER_VALUE_REG     *(volatile uint32_t *)(TIMER_BASE_REG)
#define TIMER_COMPARE_REG   *(volatile uint32_t *)(TIMER_BASE_REG + (TIMER_CMP_OFFSET))
#define TIMER_STATUS_REG    *(volatile uint32_t *)(TIMER_BASE_REG + (TIMER_STATUS_OFFSET))

#define TIMER_STATUS_REG_ENABLE 0x1