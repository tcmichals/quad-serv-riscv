
#define GPIO_BASE  0x91000000
#define GPIO_SET_OR_OFFSET      4
#define GPIO_SET_CLEAR_OFFSET   8
#define GPIO_SET_TOGGLE_OFFSET 0xc
/* read or write at this address */
#define GPIO_READ_OR_WRITE_REG  *(volatile uint32_t *)(GPIO_BASE)
/* OR on the GPIO at the HW level */
#define GPIO_SET_OR_REG         *(volatile uint32_t *)(GPIO_BASE + (GPIO_SET_OR_OFFSET))
/* Clear what ever bit is set */
#define GPIO_SET_CLEAR_REG      *(volatile uint32_t *)(GPIO_BASE + (GPIO_SET_CLEAR_OFFSET))
/* XOR on the GPIO at the HW level */
#define GPIO_SET_TOGGLE_REG    *(volatile uint32_t *)(GPIO_BASE + (GPIO_SET_TOGGLE_OFFSET))