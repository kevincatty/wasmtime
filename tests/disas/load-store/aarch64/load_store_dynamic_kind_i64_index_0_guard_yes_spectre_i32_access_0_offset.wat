;;! target = "aarch64"
;;! test = "compile"
;;! flags = " -C cranelift-enable-heap-access-spectre-mitigation -W memory64 -O static-memory-maximum-size=0 -O static-memory-guard-size=0 -O dynamic-memory-guard-size=0"

;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;; !!! GENERATED BY 'make-load-store-tests.sh' DO NOT EDIT !!!
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

(module
  (memory i64 1)

  (func (export "do_store") (param i64 i32)
    local.get 0
    local.get 1
    i32.store offset=0)

  (func (export "do_load") (param i64) (result i32)
    local.get 0
    i32.load offset=0))

;; wasm[0]::function[0]:
;;       stp     x29, x30, [sp, #-0x10]!
;;       mov     x29, sp
;;       ldr     x10, [x2, #0x60]
;;       ldr     x9, [x2, #0x58]
;;       sub     x10, x10, #4
;;       mov     x11, #0
;;       add     x9, x9, x4
;;       cmp     x4, x10
;;       csel    x10, x11, x9, hi
;;       csdb
;;       str     w5, [x10]
;;       ldp     x29, x30, [sp], #0x10
;;       ret
;;
;; wasm[0]::function[1]:
;;       stp     x29, x30, [sp, #-0x10]!
;;       mov     x29, sp
;;       ldr     x10, [x2, #0x60]
;;       ldr     x9, [x2, #0x58]
;;       sub     x10, x10, #4
;;       mov     x11, #0
;;       add     x9, x9, x4
;;       cmp     x4, x10
;;       csel    x10, x11, x9, hi
;;       csdb
;;       ldr     w2, [x10]
;;       ldp     x29, x30, [sp], #0x10
;;       ret
