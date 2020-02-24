//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include <spirv/spirv.h>

#define __CLC_NATIVE_INTRINSIC log10

#define __CLC_BODY <native_unary_intrinsic.inc>
#define __FLOAT_ONLY
#include <clc/math/gentype.inc>
