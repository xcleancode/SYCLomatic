// UNSUPPORTED: cuda-8.0, cuda-9.0, cuda-9.1, cuda-9.2, cuda-10.0, cuda-10.1, cuda-10.2, cuda-11.0
// UNSUPPORTED: v8.0, v9.0, v9.1, v9.2, v10.0, v10.1, v10.2, v11.0
// RUN: dpct --format-range=none --use-custom-helper=api -out-root %T/LapackUtils/api_test14_out %s --cuda-include-path="%cuda-path/include" -- -x cuda --cuda-host-only
// RUN: grep "IsCalled" %T/LapackUtils/api_test14_out/MainSourceFiles.yaml | wc -l > %T/LapackUtils/api_test14_out/count.txt
// RUN: FileCheck --input-file %T/LapackUtils/api_test14_out/count.txt --match-full-lines %s
// RUN: rm -rf %T/LapackUtils/api_test14_out

// CHECK: 34
// TEST_FEATURE: LapackUtils_potrs

#include "cusolverDn.h"

int main() {
  float* a_s;
  float* b_s;
  cusolverDnHandle_t handle;
  size_t device_ws_size_s;
  size_t host_ws_size_s;
  cusolverDnParams_t params;
  void* device_ws_s;
  void* host_ws_s;
  int *info;

  cusolverDnXpotrs(handle, params, CUBLAS_FILL_MODE_LOWER, 3, 1, CUDA_R_32F, a_s, 3, CUDA_R_32F, b_s, 3, info);
  return 0;
}
