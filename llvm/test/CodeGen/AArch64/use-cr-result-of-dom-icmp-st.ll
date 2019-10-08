; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-unknown-unknown -O3 -verify-machineinstrs < %s | FileCheck %s

; Test cases are generated from:
; long long NAME(PARAM a, PARAM b) {
;   if (LHS > RHS)
;     return b;
;   if (LHS < RHS)
;     return a;\
;   return a * b;
; }
; Please note funtion name is defined as <PARAM>_<LHS>_<RHS>. Take ll_a_op_b__1
; for example. ll is PARAM, a_op_b (i.e., a << b) is LHS, _1 (i.e., -1) is RHS.

target datalayout = "e-m:e-i64:64-n32:64"

define i64 @ll_a_op_b__2(i64 %a, i64 %b) {
; CHECK-LABEL: ll_a_op_b__2:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    lsl x8, x0, x1
; CHECK-NEXT:    cmn x8, #2 // =2
; CHECK-NEXT:    b.le .LBB0_2
; CHECK-NEXT:  // %bb.1: // %return
; CHECK-NEXT:    mov x0, x1
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB0_2: // %if.end
; CHECK-NEXT:    csinc x8, x1, xzr, eq
; CHECK-NEXT:    mul x0, x8, x0
; CHECK-NEXT:    ret
entry:
  %shl = shl i64 %a, %b
  %cmp = icmp sgt i64 %shl, -2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i64 %shl, -2
  %mul = select i1 %cmp2, i64 %b, i64 1
  %spec.select = mul nsw i64 %mul, %a
  ret i64 %spec.select

return:                                           ; preds = %entry
  ret i64 %b
}

define i64 @ll_a_op_b__1(i64 %a, i64 %b) {
; CHECK-LABEL: ll_a_op_b__1:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    lsl x8, x0, x1
; CHECK-NEXT:    tbnz x8, #63, .LBB1_2
; CHECK-NEXT:  // %bb.1: // %return
; CHECK-NEXT:    mov x0, x1
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB1_2: // %if.end
; CHECK-NEXT:    cmn x8, #1 // =1
; CHECK-NEXT:    csinc x8, x1, xzr, eq
; CHECK-NEXT:    mul x0, x8, x0
; CHECK-NEXT:    ret
entry:
  %shl = shl i64 %a, %b
  %cmp = icmp sgt i64 %shl, -1
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i64 %shl, -1
  %mul = select i1 %cmp2, i64 %b, i64 1
  %spec.select = mul nsw i64 %mul, %a
  ret i64 %spec.select

return:                                           ; preds = %entry
  ret i64 %b
}

define i64 @ll_a_op_b_0(i64 %a, i64 %b) {
; CHECK-LABEL: ll_a_op_b_0:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    lsl x8, x0, x1
; CHECK-NEXT:    cmp x8, #0 // =0
; CHECK-NEXT:    b.le .LBB2_2
; CHECK-NEXT:  // %bb.1: // %return
; CHECK-NEXT:    mov x0, x1
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB2_2: // %if.end
; CHECK-NEXT:    csinc x8, x1, xzr, eq
; CHECK-NEXT:    mul x0, x8, x0
; CHECK-NEXT:    ret
entry:
  %shl = shl i64 %a, %b
  %cmp = icmp sgt i64 %shl, 0
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i64 %shl, 0
  %mul = select i1 %cmp2, i64 %b, i64 1
  %spec.select = mul nsw i64 %mul, %a
  ret i64 %spec.select

return:                                           ; preds = %entry
  ret i64 %b
}

define i64 @ll_a_op_b_1(i64 %a, i64 %b) {
; CHECK-LABEL: ll_a_op_b_1:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    lsl x8, x0, x1
; CHECK-NEXT:    cmp x8, #1 // =1
; CHECK-NEXT:    b.le .LBB3_2
; CHECK-NEXT:  // %bb.1: // %return
; CHECK-NEXT:    mov x0, x1
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB3_2: // %if.end
; CHECK-NEXT:    csinc x8, x1, xzr, eq
; CHECK-NEXT:    mul x0, x8, x0
; CHECK-NEXT:    ret
entry:
  %shl = shl i64 %a, %b
  %cmp = icmp sgt i64 %shl, 1
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i64 %shl, 1
  %mul = select i1 %cmp2, i64 %b, i64 1
  %spec.select = mul nsw i64 %mul, %a
  ret i64 %spec.select

return:                                           ; preds = %entry
  ret i64 %b
}

define i64 @ll_a_op_b_2(i64 %a, i64 %b) {
; CHECK-LABEL: ll_a_op_b_2:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    lsl x8, x0, x1
; CHECK-NEXT:    cmp x8, #2 // =2
; CHECK-NEXT:    b.le .LBB4_2
; CHECK-NEXT:  // %bb.1: // %return
; CHECK-NEXT:    mov x0, x1
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB4_2: // %if.end
; CHECK-NEXT:    csinc x8, x1, xzr, eq
; CHECK-NEXT:    mul x0, x8, x0
; CHECK-NEXT:    ret
entry:
  %shl = shl i64 %a, %b
  %cmp = icmp sgt i64 %shl, 2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i64 %shl, 2
  %mul = select i1 %cmp2, i64 %b, i64 1
  %spec.select = mul nsw i64 %mul, %a
  ret i64 %spec.select

return:                                           ; preds = %entry
  ret i64 %b
}

define i64 @ll_a__2(i64 %a, i64 %b) {
; CHECK-LABEL: ll_a__2:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    cmn x0, #2 // =2
; CHECK-NEXT:    b.le .LBB5_2
; CHECK-NEXT:  // %bb.1: // %return
; CHECK-NEXT:    mov x0, x1
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB5_2: // %if.end
; CHECK-NEXT:    csinc x8, x1, xzr, eq
; CHECK-NEXT:    mul x0, x8, x0
; CHECK-NEXT:    ret
entry:
  %cmp = icmp sgt i64 %a, -2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp1 = icmp eq i64 %a, -2
  %mul = select i1 %cmp1, i64 %b, i64 1
  %spec.select = mul nsw i64 %mul, %a
  ret i64 %spec.select

return:                                           ; preds = %entry
  ret i64 %b
}

define i64 @ll_a__1(i64 %a, i64 %b) {
; CHECK-LABEL: ll_a__1:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    tbnz x0, #63, .LBB6_2
; CHECK-NEXT:  // %bb.1: // %return
; CHECK-NEXT:    mov x0, x1
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB6_2: // %if.end
; CHECK-NEXT:    cmn x0, #1 // =1
; CHECK-NEXT:    csinc x8, x1, xzr, eq
; CHECK-NEXT:    mul x0, x8, x0
; CHECK-NEXT:    ret
entry:
  %cmp = icmp sgt i64 %a, -1
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp1 = icmp eq i64 %a, -1
  %mul = select i1 %cmp1, i64 %b, i64 1
  %spec.select = mul nsw i64 %mul, %a
  ret i64 %spec.select

return:                                           ; preds = %entry
  ret i64 %b
}

define i64 @ll_a_0(i64 %a, i64 %b) {
; CHECK-LABEL: ll_a_0:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    cmp x0, #0 // =0
; CHECK-NEXT:    b.le .LBB7_2
; CHECK-NEXT:  // %bb.1: // %return
; CHECK-NEXT:    mov x0, x1
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB7_2: // %if.end
; CHECK-NEXT:    csinc x8, x1, xzr, eq
; CHECK-NEXT:    mul x0, x8, x0
; CHECK-NEXT:    ret
entry:
  %cmp = icmp sgt i64 %a, 0
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp1 = icmp eq i64 %a, 0
  %mul = select i1 %cmp1, i64 %b, i64 1
  %spec.select = mul nsw i64 %mul, %a
  ret i64 %spec.select

return:                                           ; preds = %entry
  ret i64 %b
}

define i64 @ll_a_1(i64 %a, i64 %b) {
; CHECK-LABEL: ll_a_1:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    cmp x0, #1 // =1
; CHECK-NEXT:    b.le .LBB8_2
; CHECK-NEXT:  // %bb.1: // %return
; CHECK-NEXT:    mov x0, x1
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB8_2: // %if.end
; CHECK-NEXT:    csinc x8, x1, xzr, eq
; CHECK-NEXT:    mul x0, x8, x0
; CHECK-NEXT:    ret
entry:
  %cmp = icmp sgt i64 %a, 1
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp1 = icmp eq i64 %a, 1
  %mul = select i1 %cmp1, i64 %b, i64 1
  %spec.select = mul nsw i64 %mul, %a
  ret i64 %spec.select

return:                                           ; preds = %entry
  ret i64 %b
}

define i64 @ll_a_2(i64 %a, i64 %b) {
; CHECK-LABEL: ll_a_2:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    cmp x0, #2 // =2
; CHECK-NEXT:    b.le .LBB9_2
; CHECK-NEXT:  // %bb.1: // %return
; CHECK-NEXT:    mov x0, x1
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB9_2: // %if.end
; CHECK-NEXT:    csinc x8, x1, xzr, eq
; CHECK-NEXT:    mul x0, x8, x0
; CHECK-NEXT:    ret
entry:
  %cmp = icmp sgt i64 %a, 2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp1 = icmp eq i64 %a, 2
  %mul = select i1 %cmp1, i64 %b, i64 1
  %spec.select = mul nsw i64 %mul, %a
  ret i64 %spec.select

return:                                           ; preds = %entry
  ret i64 %b
}

define i64 @i_a_op_b__2(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: i_a_op_b__2:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    lsl w8, w0, w1
; CHECK-NEXT:    cmn w8, #2 // =2
; CHECK-NEXT:    csinc w8, w1, wzr, eq
; CHECK-NEXT:    mul w8, w8, w0
; CHECK-NEXT:    csel w8, w1, w8, gt
; CHECK-NEXT:    sxtw x0, w8
; CHECK-NEXT:    ret
entry:
  %shl = shl i32 %a, %b
  %cmp = icmp sgt i32 %shl, -2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i32 %shl, -2
  %mul = select i1 %cmp2, i32 %b, i32 1
  %spec.select = mul nsw i32 %mul, %a
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0.in = phi i32 [ %b, %entry ], [ %spec.select, %if.end ]
  %retval.0 = sext i32 %retval.0.in to i64
  ret i64 %retval.0
}

define i64 @i_a_op_b__1(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: i_a_op_b__1:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    lsl w8, w0, w1
; CHECK-NEXT:    cmn w8, #1 // =1
; CHECK-NEXT:    csinc w9, w1, wzr, eq
; CHECK-NEXT:    mul w9, w9, w0
; CHECK-NEXT:    cmp w8, #0 // =0
; CHECK-NEXT:    csel w8, w1, w9, ge
; CHECK-NEXT:    sxtw x0, w8
; CHECK-NEXT:    ret
entry:
  %shl = shl i32 %a, %b
  %cmp = icmp sgt i32 %shl, -1
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i32 %shl, -1
  %mul = select i1 %cmp2, i32 %b, i32 1
  %spec.select = mul nsw i32 %mul, %a
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0.in = phi i32 [ %b, %entry ], [ %spec.select, %if.end ]
  %retval.0 = sext i32 %retval.0.in to i64
  ret i64 %retval.0
}

define i64 @i_a_op_b_0(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: i_a_op_b_0:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    lsl w8, w0, w1
; CHECK-NEXT:    cmp w8, #0 // =0
; CHECK-NEXT:    csinc w8, w1, wzr, eq
; CHECK-NEXT:    mul w8, w8, w0
; CHECK-NEXT:    csel w8, w1, w8, gt
; CHECK-NEXT:    sxtw x0, w8
; CHECK-NEXT:    ret
entry:
  %shl = shl i32 %a, %b
  %cmp = icmp sgt i32 %shl, 0
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i32 %shl, 0
  %mul = select i1 %cmp2, i32 %b, i32 1
  %spec.select = mul nsw i32 %mul, %a
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0.in = phi i32 [ %b, %entry ], [ %spec.select, %if.end ]
  %retval.0 = sext i32 %retval.0.in to i64
  ret i64 %retval.0
}

define i64 @i_a_op_b_1(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: i_a_op_b_1:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    lsl w8, w0, w1
; CHECK-NEXT:    cmp w8, #1 // =1
; CHECK-NEXT:    csinc w8, w1, wzr, eq
; CHECK-NEXT:    mul w8, w8, w0
; CHECK-NEXT:    csel w8, w1, w8, gt
; CHECK-NEXT:    sxtw x0, w8
; CHECK-NEXT:    ret
entry:
  %shl = shl i32 %a, %b
  %cmp = icmp sgt i32 %shl, 1
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i32 %shl, 1
  %mul = select i1 %cmp2, i32 %b, i32 1
  %spec.select = mul nsw i32 %mul, %a
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0.in = phi i32 [ %b, %entry ], [ %spec.select, %if.end ]
  %retval.0 = sext i32 %retval.0.in to i64
  ret i64 %retval.0
}

define i64 @i_a_op_b_2(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: i_a_op_b_2:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    lsl w8, w0, w1
; CHECK-NEXT:    cmp w8, #2 // =2
; CHECK-NEXT:    csinc w8, w1, wzr, eq
; CHECK-NEXT:    mul w8, w8, w0
; CHECK-NEXT:    csel w8, w1, w8, gt
; CHECK-NEXT:    sxtw x0, w8
; CHECK-NEXT:    ret
entry:
  %shl = shl i32 %a, %b
  %cmp = icmp sgt i32 %shl, 2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i32 %shl, 2
  %mul = select i1 %cmp2, i32 %b, i32 1
  %spec.select = mul nsw i32 %mul, %a
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0.in = phi i32 [ %b, %entry ], [ %spec.select, %if.end ]
  %retval.0 = sext i32 %retval.0.in to i64
  ret i64 %retval.0
}

define i64 @i_a__2(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: i_a__2:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    cmn w0, #2 // =2
; CHECK-NEXT:    csinc w8, w1, wzr, eq
; CHECK-NEXT:    mul w8, w8, w0
; CHECK-NEXT:    csel w8, w1, w8, gt
; CHECK-NEXT:    sxtw x0, w8
; CHECK-NEXT:    ret
entry:
  %cmp = icmp sgt i32 %a, -2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp1 = icmp eq i32 %a, -2
  %mul = select i1 %cmp1, i32 %b, i32 1
  %spec.select = mul nsw i32 %mul, %a
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0.in = phi i32 [ %b, %entry ], [ %spec.select, %if.end ]
  %retval.0 = sext i32 %retval.0.in to i64
  ret i64 %retval.0
}

define i64 @i_a__1(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: i_a__1:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    cmn w0, #1 // =1
; CHECK-NEXT:    csinc w8, w1, wzr, eq
; CHECK-NEXT:    mul w8, w8, w0
; CHECK-NEXT:    cmp w0, #0 // =0
; CHECK-NEXT:    csel w8, w1, w8, ge
; CHECK-NEXT:    sxtw x0, w8
; CHECK-NEXT:    ret
entry:
  %cmp = icmp sgt i32 %a, -1
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp1 = icmp eq i32 %a, -1
  %mul = select i1 %cmp1, i32 %b, i32 1
  %spec.select = mul nsw i32 %mul, %a
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0.in = phi i32 [ %b, %entry ], [ %spec.select, %if.end ]
  %retval.0 = sext i32 %retval.0.in to i64
  ret i64 %retval.0
}

define i64 @i_a_0(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: i_a_0:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    cmp w0, #0 // =0
; CHECK-NEXT:    csinc w8, w1, wzr, eq
; CHECK-NEXT:    mul w8, w8, w0
; CHECK-NEXT:    csel w8, w1, w8, gt
; CHECK-NEXT:    sxtw x0, w8
; CHECK-NEXT:    ret
entry:
  %cmp = icmp sgt i32 %a, 0
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp1 = icmp eq i32 %a, 0
  %mul = select i1 %cmp1, i32 %b, i32 1
  %spec.select = mul nsw i32 %mul, %a
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0.in = phi i32 [ %b, %entry ], [ %spec.select, %if.end ]
  %retval.0 = sext i32 %retval.0.in to i64
  ret i64 %retval.0
}

define i64 @i_a_1(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: i_a_1:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    cmp w0, #1 // =1
; CHECK-NEXT:    csinc w8, w1, wzr, eq
; CHECK-NEXT:    mul w8, w8, w0
; CHECK-NEXT:    csel w8, w1, w8, gt
; CHECK-NEXT:    sxtw x0, w8
; CHECK-NEXT:    ret
entry:
  %cmp = icmp sgt i32 %a, 1
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp1 = icmp eq i32 %a, 1
  %mul = select i1 %cmp1, i32 %b, i32 1
  %spec.select = mul nsw i32 %mul, %a
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0.in = phi i32 [ %b, %entry ], [ %spec.select, %if.end ]
  %retval.0 = sext i32 %retval.0.in to i64
  ret i64 %retval.0
}

define i64 @i_a_2(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: i_a_2:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    cmp w0, #2 // =2
; CHECK-NEXT:    csinc w8, w1, wzr, eq
; CHECK-NEXT:    mul w8, w8, w0
; CHECK-NEXT:    csel w8, w1, w8, gt
; CHECK-NEXT:    sxtw x0, w8
; CHECK-NEXT:    ret
entry:
  %cmp = icmp sgt i32 %a, 2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp1 = icmp eq i32 %a, 2
  %mul = select i1 %cmp1, i32 %b, i32 1
  %spec.select = mul nsw i32 %mul, %a
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0.in = phi i32 [ %b, %entry ], [ %spec.select, %if.end ]
  %retval.0 = sext i32 %retval.0.in to i64
  ret i64 %retval.0
}
