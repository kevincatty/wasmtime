;;! target = "s390x"
;;! test = "compile"
;;! flags = " -C cranelift-enable-heap-access-spectre-mitigation -O static-memory-maximum-size=0 -O static-memory-guard-size=4294967295 -O dynamic-memory-guard-size=4294967295"

;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;; !!! GENERATED BY 'make-load-store-tests.sh' DO NOT EDIT !!!
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

(module
  (memory i32 1)

  (func (export "do_store") (param i32 i32)
    local.get 0
    local.get 1
    i32.store offset=0xffff0000)

  (func (export "do_load") (param i32) (result i32)
    local.get 0
    i32.load offset=0xffff0000))

;; wasm[0]::function[0]:
;;       lg      %r1, 8(%r2)
;;       lg      %r1, 0x10(%r1)
;;       la      %r1, 0xa0(%r1)
;;       clgrtle %r15, %r1
;;       stmg    %r14, %r15, 0x70(%r15)
;;       lgr     %r1, %r15
;;       aghi    %r15, -0xa0
;;       stg     %r1, 0(%r15)
;;       lg      %r6, 0x60(%r2)
;;       lgr     %r3, %r2
;;       llgfr   %r2, %r4
;;       lghi    %r7, 0
;;       lgr     %r4, %r3
;;       lgr     %r3, %r2
;;       ag      %r3, 0x58(%r4)
;;       llilh   %r4, 0xffff
;;       agr     %r3, %r4
;;       clgr    %r2, %r6
;;       locgrh  %r3, %r7
;;       strv    %r5, 0(%r3)
;;       lmg     %r14, %r15, 0x110(%r15)
;;       br      %r14
;;
;; wasm[0]::function[1]:
;;       lg      %r1, 8(%r2)
;;       lg      %r1, 0x10(%r1)
;;       la      %r1, 0xa0(%r1)
;;       clgrtle %r15, %r1
;;       stmg    %r14, %r15, 0x70(%r15)
;;       lgr     %r1, %r15
;;       aghi    %r15, -0xa0
;;       stg     %r1, 0(%r15)
;;       lg      %r6, 0x60(%r2)
;;       lgr     %r3, %r2
;;       llgfr   %r2, %r4
;;       lghi    %r7, 0
;;       lgr     %r4, %r3
;;       lgr     %r3, %r2
;;       ag      %r3, 0x58(%r4)
;;       llilh   %r4, 0xffff
;;       agrk    %r5, %r3, %r4
;;       clgr    %r2, %r6
;;       locgrh  %r5, %r7
;;       lrv     %r2, 0(%r5)
;;       lmg     %r14, %r15, 0x110(%r15)
;;       br      %r14
