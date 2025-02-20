;;! target = "x86_64"
;;! test = "clif"
;;! flags = " -C cranelift-enable-heap-access-spectre-mitigation=false -W memory64 -O static-memory-forced -O static-memory-guard-size=4294967295 -O dynamic-memory-guard-size=4294967295"

;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;; !!! GENERATED BY 'make-load-store-tests.sh' DO NOT EDIT !!!
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

(module
  (memory i64 1)

  (func (export "do_store") (param i64 i32)
    local.get 0
    local.get 1
    i32.store offset=0xffff0000)

  (func (export "do_load") (param i64) (result i32)
    local.get 0
    i32.load offset=0xffff0000))

;; function u0:0(i64 vmctx, i64, i64, i32) tail {
;;     gv0 = vmctx
;;     gv1 = load.i64 notrap aligned readonly gv0+8
;;     gv2 = load.i64 notrap aligned gv1+16
;;     gv3 = vmctx
;;     gv4 = load.i64 notrap aligned gv3+96
;;     gv5 = load.i64 notrap aligned readonly checked gv3+88
;;     stack_limit = gv2
;;
;;                                 block0(v0: i64, v1: i64, v2: i64, v3: i32):
;; @0040                               v4 = iconst.i64 0xfffc
;; @0040                               v5 = icmp ugt v2, v4  ; v4 = 0xfffc
;; @0040                               trapnz v5, heap_oob
;; @0040                               v6 = load.i64 notrap aligned readonly checked v0+88
;; @0040                               v7 = iadd v6, v2
;; @0040                               v8 = iconst.i64 0xffff_0000
;; @0040                               v9 = iadd v7, v8  ; v8 = 0xffff_0000
;; @0040                               store little heap v3, v9
;; @0047                               jump block1
;;
;;                                 block1:
;; @0047                               return
;; }
;;
;; function u0:1(i64 vmctx, i64, i64) -> i32 tail {
;;     gv0 = vmctx
;;     gv1 = load.i64 notrap aligned readonly gv0+8
;;     gv2 = load.i64 notrap aligned gv1+16
;;     gv3 = vmctx
;;     gv4 = load.i64 notrap aligned gv3+96
;;     gv5 = load.i64 notrap aligned readonly checked gv3+88
;;     stack_limit = gv2
;;
;;                                 block0(v0: i64, v1: i64, v2: i64):
;; @004c                               v4 = iconst.i64 0xfffc
;; @004c                               v5 = icmp ugt v2, v4  ; v4 = 0xfffc
;; @004c                               trapnz v5, heap_oob
;; @004c                               v6 = load.i64 notrap aligned readonly checked v0+88
;; @004c                               v7 = iadd v6, v2
;; @004c                               v8 = iconst.i64 0xffff_0000
;; @004c                               v9 = iadd v7, v8  ; v8 = 0xffff_0000
;; @004c                               v10 = load.i32 little heap v9
;; @0053                               jump block1
;;
;;                                 block1:
;; @0053                               return v10
;; }
