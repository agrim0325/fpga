# Project: Cortex-M3 APB LED Peripheral System

This repository contains the complete SoC (System-on-Chip) design and firmware implementation for controlling custom hardware LEDs using an ARM Cortex-M3 processor on a Microchip SmartFusion2 FPGA.

## System Architecture

The project implements a Memory-Mapped I/O architecture. The processor communicates with the custom hardware through the Advanced Peripheral Bus (APB).



### 1. Hardware Design (`hdl/apb_led_slave.v`)
The `apb_led_slave` is a custom Verilog peripheral designed to interface with the processor's APB bus. 
* **Protocol:** Implements a standard APB slave interface.
* **Function:** It decodes the bus transactions to capture 32-bit data (`PWDATA`) from the CPU and drive physical FPGA output pins connected to LEDs.
* **Integration:** Instantiated within Libero SmartDesign and connected to the Cortex-M3 through the `CoreAPB3` bridge.

### 2. Processor Subsystem (MSS)
* **Cortex-M3:** Acts as the system controller.
* **Memory Map:** The peripheral is mapped to a specific base address in the CPU's memory space (e.g., `0x30000000`). Writing to this address triggers the hardware logic in our `apb_led_slave`.

### 3. Firmware Implementation (`main.c`)
The firmware is written in C and cross-compiled for the ARM Cortex-M3 architecture.
* **Logic:** The code uses volatile pointers to access the hardware base address directly.
* **Operation:** ```c
    #define LED_BASE_ADDR 0x30000000
    volatile uint32_t *led_reg = (uint32_t *)LED_BASE_ADDR;
    *led_reg = 0x0F; // Sets the first 4 bits to high, turning on the LEDs.
    ```



## Build & Integration Workflow

### Hardware Implementation (Libero SoC)
1.  **Synthesis:** Translates Verilog into gate-level logic.
2.  **Place & Route:** Assigns logic to physical FPGA resources and calculates signal routing.
3.  **Constraint Management:** Physical pins are locked to specific FPGA package pins in the I/O Editor.
4.  **Bitstream Generation:** Combines the hardware logic and the MSS configuration into a single programming file.

### Firmware Build (SoftConsole)
1.  **Compilation:** Generates an `.elf` file (for debugging) and a `.hex` file (for memory initialization).
2.  **eNVM Initialization:** The `.hex` file is embedded into the FPGA's non-volatile memory. This allows the processor to boot directly into our custom code upon power-up.



## Deployment Steps
1.  **Configure:** Ensure the `eNVM` data client in Libero is correctly linked to the `apb_led_test.hex` file.
2.  **Generate:** Perform a full "Generate Bitstream" in Libero to update the design.
3.  **Program:** Use FlashPro to flash the final bitstream onto the SmartFusion2 target board.
4.  **Debug:** Use the SoftConsole Debugger (via JTAG) to step through instructions and verify real-time hardware interaction.
