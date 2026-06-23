    //
    // Vector table (ARMv6-M)
    // ----------------------
    //
    // The vector table contains the initialization value for the stack pointer
    // on reset, and the entry point addresses for all exception handlers. The
    // exception number also defines the order of entries in the vector table.
    //
    // In the ARMv6-M priority model, lower numbers take precedence. That is,
    // the lower the assigned priority value, the higher the priority level. The
    // priority order for exceptions with the same priority level is fixed, and
    // is determined by their exception number.
    // 
    // Reset, NMI, and HardFault execute at fixed priorities of -3, -2, and -1
    // respectively. Software can set the priority of all other exceptions using
    // registers in the SCS. A reset clears these software-configured priority
    // settings. Software-assigned priority values start at 0, so Reset, NMI,
    // and HardFault always have higher priorities than any other exception.
    //
    // When multiple pending exceptions have the same priority number, the
    // pending exception with the lowest exception number takes precedence. When
    // an exception is active, only an exception with a higher priority can
    // preempt it.

    .global exc_vector
exc_vector:

    .word 0x1000  // stack pointer, TODO: set this appropriately
    .word exc_reset_handler
    .word exc_nmi_handler
    .word exc_hard_fault_handler
    .rept 7
    .word 0x0 // reserved
    .endr
    .word exc_svcall_handler
    .word 0x0 // reserved
    .word 0x0 // reserved
    .word exc_pendsv_handler
    .word exc_systick_handler
    .rept 32
    .word exc_extern_generic_handler
    .endr

    // Exception return behaviour
    // --------------------------
    //
    // An exception return occurs when the processor is in Handler mode and one
    // of the following instructions loads a value of 0xFXXXXXXX into the PC
    //
    // Return to Handler Mode. Exception return gets state from the Main stack.
    // On return execution uses the Main Stack.
.equ EXC_RETURN1, 0xFFFFFFF1
    // Return to Thread Mode. Exception return gets state from the Main stack.
    // On return execution uses the Main Stack
.equ EXC_RETURN2, 0xFFFFFFF9
    // Return to Thread Mode. Exception return gets state from the Process
    // stack. On return execution uses the Process Stack
.equ EXC_RETURN3, 0xFFFFFFFD

exc_reset_handler:
    b start
    ldr r2, =EXC_RETURN1
    bx r2

exc_nmi_handler:
    ldr r2, =EXC_RETURN1
    bx r2

exc_hard_fault_handler:
    ldr r2, =EXC_RETURN1
    bx r2

exc_svcall_handler:
    ldr r2, =EXC_RETURN1
    bx r2

exc_pendsv_handler:
    ldr r2, =EXC_RETURN1
    bx r2

exc_systick_handler:
    ldr r2, =EXC_RETURN1
    bx r2

exc_extern_generic_handler:
    ldr r2, =EXC_RETURN1
    bx r2

    // This is called by the reset handler, and is the actual start of the
    // program
    .global start
start:

    .loop:
    wfi
    b .loop
