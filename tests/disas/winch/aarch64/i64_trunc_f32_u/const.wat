;;! target = "aarch64"
;;! test = "winch"

(module
    (func (result i64)
        (f32.const 1.0)
        (i64.trunc_f32_u)
    )
)
;; wasm[0]::function[0]:
;;       stp     x29, x30, [sp, #-0x10]!
;;       mov     x29, sp
;;       str     x28, [sp, #-0x10]!
;;       mov     x28, sp
;;       mov     x9, x0
;;       sub     x28, x28, #0x10
;;       mov     sp, x28
;;       stur    x0, [x28, #8]
;;       stur    x1, [x28]
;;       mov     x16, #0x3f800000
;;       fmov    s0, w16
;;       fcmp    s0, s0
;;       b.vs    #0x6c
;;   34: fmov    s31, #-1.00000000
;;       fcmp    s31, s0
;;       b.le    #0x70
;;   40: mov     x16, #0x5f800000
;;       fmov    s31, w16
;;       fcmp    s31, s0
;;       b.ge    #0x74
;;   50: fcvtzu  x0, s0
;;       add     x28, x28, #0x10
;;       mov     sp, x28
;;       mov     sp, x28
;;       ldr     x28, [sp], #0x10
;;       ldp     x29, x30, [sp], #0x10
;;       ret
;;   6c: .byte   0x1f, 0xc1, 0x00, 0x00
;;   70: .byte   0x1f, 0xc1, 0x00, 0x00
;;   74: .byte   0x1f, 0xc1, 0x00, 0x00
