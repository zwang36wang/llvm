// RUN: %clang_cc1 -I %S/Inputs -fsycl -fsycl-is-device -ast-dump %s | FileCheck %s

// This test checks that compiler generates correct kernel wrapper in case when
// accessor is wrapped.

#include <sycl.hpp>

template <typename Acc>
struct AccWrapper { Acc accessor; };

template <typename name, typename Func>
__attribute__((sycl_kernel)) void kernel(Func kernelFunc) {
  kernelFunc();
}

int main() {
  cl::sycl::accessor<int, 1, cl::sycl::access::mode::read_write> acc;
  auto acc_wrapped = AccWrapper<decltype(acc)>{acc};
  kernel<class wrapped_access>(
      [=]() {
        acc_wrapped.accessor.use();
      });
}

// Check declaration of the kernel
// CHECK: wrapped_access{{.*}} 'void (AccWrapper<cl::sycl::accessor<int, 1, cl::sycl::access::mode::read_write, cl::sycl::access::target::global_buffer, cl::sycl::access::placeholder::false_t> >, __global int *, cl::sycl::range<1>, cl::sycl::range<1>, cl::sycl::id<1>)'

// Check parameters of the kernel
// CHECK: ParmVarDecl {{.*}} used _arg_ 'AccWrapper<cl::sycl::accessor<int, 1, cl::sycl::access::mode::read_write, cl::sycl::access::target::global_buffer, cl::sycl::access::placeholder::false_t> >':'AccWrapper<cl::sycl::accessor<int, 1, cl::sycl::access::mode::read_write, cl::sycl::access::target::global_buffer, cl::sycl::access::placeholder::false_t> >'
// CHECK: ParmVarDecl {{.*}} used _arg_accessor '__global int *'
// CHECK: ParmVarDecl {{.*}} used [[_arg_AccessRange:[0-9a-zA-Z_]+]] 'cl::sycl::range<1>'
// CHECK: ParmVarDecl {{.*}} used [[_arg_MemRange:[0-9a-zA-Z_]+]] 'cl::sycl::range<1>'
// CHECK: ParmVarDecl {{.*}} used [[_arg_Offset:[0-9a-zA-Z_]+]] 'cl::sycl::id<1>'

// Check that wrapper object itself is initialized with corresponding kernel
// argument
// CHECK: VarDecl {{.*}}'(lambda at {{.*}}wrapped-accessor.cpp{{.*}})'
// CHECK-NEXT: InitListExpr
// CHECK-NEXT: CXXConstructExpr {{.*}}AccWrapper<cl::sycl::accessor
// CHECK-NEXT: ImplicitCastExpr {{.*}} 'const AccWrapper<cl::sycl::accessor<int, 1, cl::sycl::access::mode::read_write, cl::sycl::access::target::global_buffer, cl::sycl::access::placeholder::false_t> >' lvalue <NoOp>
// CHECK-NEXT: DeclRefExpr {{.*}} 'AccWrapper<cl::sycl::accessor<int, 1, cl::sycl::access::mode::read_write, cl::sycl::access::target::global_buffer, cl::sycl::access::placeholder::false_t> >':'AccWrapper<cl::sycl::accessor<int, 1, cl::sycl::access::mode::read_write, cl::sycl::access::target::global_buffer, cl::sycl::access::placeholder::false_t> >' lvalue ParmVar {{.*}} '_arg_' 'AccWrapper<cl::sycl::accessor<int, 1, cl::sycl::access::mode::read_write, cl::sycl::access::target::global_buffer, cl::sycl::access::placeholder::false_t> >':'AccWrapper<cl::sycl::accessor<int, 1, cl::sycl::access::mode::read_write, cl::sycl::access::target::global_buffer, cl::sycl::access::placeholder::false_t> >'

// Check that accessor field of the wrapper object is initialized using __init method
// CHECK-NEXT: CXXMemberCallExpr {{.*}} 'void'
// CHECK-NEXT: MemberExpr {{.*}} 'void ({{.*}}PtrType, range<1>, range<1>, id<1>)' lvalue .__init
// CHECK-NEXT: MemberExpr {{.*}} 'cl::sycl::accessor<int, 1, cl::sycl::access::mode::read_write, cl::sycl::access::target::global_buffer, cl::sycl::access::placeholder::false_t>':'cl::sycl::accessor<int, 1, cl::sycl::access::mode::read_write, cl::sycl::access::target::global_buffer, cl::sycl::access::placeholder::false_t>' lvalue .accessor {{.*}}
// CHECK-NEXT: MemberExpr {{.*}} 'AccWrapper<cl::sycl::accessor<int, 1, cl::sycl::access::mode::read_write, cl::sycl::access::target::global_buffer, cl::sycl::access::placeholder::false_t> >':'AccWrapper<cl::sycl::accessor<int, 1, cl::sycl::access::mode::read_write, cl::sycl::access::target::global_buffer, cl::sycl::access::placeholder::false_t> >' lvalue .
// CHECK-NEXT: DeclRefExpr {{.*}} '(lambda at {{.*}}wrapped-accessor.cpp{{.*}})' lvalue Var {{.*}} '(lambda at {{.*}}wrapped-accessor.cpp{{.*}})'

// Parameters of the _init method
// CHECK-NEXT: ImplicitCastExpr {{.*}} <LValueToRValue>
// CHECK-NEXT: DeclRefExpr {{.*}} '__global int *' lvalue ParmVar {{.*}} '_arg_accessor' '__global int *'

// CHECK-NEXT: CXXConstructExpr {{.*}} 'range<1>':'cl::sycl::range<1>'
// CHECK-NEXT: ImplicitCastExpr {{.*}} 'const cl::sycl::range<1>' lvalue <NoOp>
// CHECK-NEXT: DeclRefExpr {{.*}} 'cl::sycl::range<1>' lvalue ParmVar {{.*}} '[[_arg_AccessRange]]' 'cl::sycl::range<1>'

// CHECK-NEXT: CXXConstructExpr {{.*}} 'range<1>':'cl::sycl::range<1>'
// CHECK-NEXT: ImplicitCastExpr {{.*}} 'const cl::sycl::range<1>' lvalue <NoOp>
// CHECK-NEXT: DeclRefExpr {{.*}} 'cl::sycl::range<1>' lvalue ParmVar {{.*}} '[[_arg_MemRange]]' 'cl::sycl::range<1>'

// CHECK-NEXT: CXXConstructExpr {{.*}} 'id<1>':'cl::sycl::id<1>'
// CHECK-NEXT: ImplicitCastExpr {{.*}} 'const cl::sycl::id<1>' lvalue <NoOp>
// CHECK-NEXT: DeclRefExpr {{.*}} 'cl::sycl::id<1>' lvalue ParmVar {{.*}} '[[_arg_Offset]]' 'cl::sycl::id<1>'
