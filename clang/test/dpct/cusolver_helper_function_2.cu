// UNSUPPORTED: cuda-8.0
// UNSUPPORTED: v8.0
// RUN: dpct --format-range=none -out-root %T/cusolver_helper_function_2 %s --cuda-include-path="%cuda-path/include" -- -x cuda --cuda-host-only
// RUN: FileCheck --input-file %T/cusolver_helper_function_2/cusolver_helper_function_2.dp.cpp --match-full-lines %s

//CHECK:#include <sycl/sycl.hpp>
//CHECK-NEXT:#include <dpct/dpct.hpp>
//CHECK-NEXT:#include <dpct/lapack_utils.hpp>
#include "cusolverDn.h"

int foo1() {
  cusolverDnHandle_t handle;
  float ** a_s_ptrs;
  double ** a_d_ptrs;
  float2 ** a_c_ptrs;
  double2 ** a_z_ptrs;
  int *infoArray;
  cusolverStatus_t status;

  //CHECK:status = dpct::lapack::potrf_batch(*handle, oneapi::mkl::uplo::upper, 3, a_s_ptrs, 3, infoArray, 2);
  //CHECK:status = dpct::lapack::potrf_batch(*handle, oneapi::mkl::uplo::upper, 3, a_d_ptrs, 3, infoArray, 2);
  //CHECK:status = dpct::lapack::potrf_batch(*handle, oneapi::mkl::uplo::upper, 3, a_c_ptrs, 3, infoArray, 2);
  //CHECK:status = dpct::lapack::potrf_batch(*handle, oneapi::mkl::uplo::upper, 3, a_z_ptrs, 3, infoArray, 2);
  status = cusolverDnSpotrfBatched(handle, CUBLAS_FILL_MODE_UPPER, 3, a_s_ptrs, 3, infoArray, 2);
  status = cusolverDnDpotrfBatched(handle, CUBLAS_FILL_MODE_UPPER, 3, a_d_ptrs, 3, infoArray, 2);
  status = cusolverDnCpotrfBatched(handle, CUBLAS_FILL_MODE_UPPER, 3, a_c_ptrs, 3, infoArray, 2);
  status = cusolverDnZpotrfBatched(handle, CUBLAS_FILL_MODE_UPPER, 3, a_z_ptrs, 3, infoArray, 2);

  return 0;
}

int foo2() {
  cusolverDnHandle_t handle;
  float ** a_s_ptrs, ** b_s_ptrs;
  double ** a_d_ptrs, ** b_d_ptrs;
  float2 ** a_c_ptrs, ** b_c_ptrs;
  double2 ** a_z_ptrs, ** b_z_ptrs;
  int *infoArray;
  cusolverStatus_t status;

  //CHECK:status = dpct::lapack::potrs_batch(*handle, oneapi::mkl::uplo::upper, 3, 1, a_s_ptrs, 3, b_s_ptrs, 3, infoArray, 2);
  //CHECK:status = dpct::lapack::potrs_batch(*handle, oneapi::mkl::uplo::upper, 3, 1, a_d_ptrs, 3, b_d_ptrs, 3, infoArray, 2);
  //CHECK:status = dpct::lapack::potrs_batch(*handle, oneapi::mkl::uplo::upper, 3, 1, a_c_ptrs, 3, b_c_ptrs, 3, infoArray, 2);
  //CHECK:status = dpct::lapack::potrs_batch(*handle, oneapi::mkl::uplo::upper, 3, 1, a_z_ptrs, 3, b_z_ptrs, 3, infoArray, 2);
  status = cusolverDnSpotrsBatched(handle, CUBLAS_FILL_MODE_UPPER, 3, 1, a_s_ptrs, 3, b_s_ptrs, 3, infoArray, 2);
  status = cusolverDnDpotrsBatched(handle, CUBLAS_FILL_MODE_UPPER, 3, 1, a_d_ptrs, 3, b_d_ptrs, 3, infoArray, 2);
  status = cusolverDnCpotrsBatched(handle, CUBLAS_FILL_MODE_UPPER, 3, 1, a_c_ptrs, 3, b_c_ptrs, 3, infoArray, 2);
  status = cusolverDnZpotrsBatched(handle, CUBLAS_FILL_MODE_UPPER, 3, 1, a_z_ptrs, 3, b_z_ptrs, 3, infoArray, 2);

  return 0;
}

void foo3() {
  cusolverDnHandle_t handle;
  void *a_s, *a_d, *a_c, *a_z;
  void *s_s, *s_d, *s_c, *s_z;
  void *u_s, *u_d, *u_c, *u_z;
  void *vt_s, *vt_d, *vt_c, *vt_z;
  int device_ws_size_s;
  int device_ws_size_d;
  int device_ws_size_c;
  int device_ws_size_z;

  //CHECK:int gesvdjinfo;
  //CHECK-NEXT:/*
  //CHECK-NEXT:DPCT1026:{{[0-9]+}}: The call to cusolverDnCreateGesvdjInfo was removed because this call is redundant in SYCL.
  //CHECK-NEXT:*/
  gesvdjInfo_t gesvdjinfo;
  cusolverDnCreateGesvdjInfo(&gesvdjinfo);

  //CHECK:dpct::lapack::gesvd_scratchpad_size(*handle, oneapi::mkl::job::vec, 0, 2, 2, dpct::library_data_t::real_float, 2, dpct::library_data_t::real_float, 2, dpct::library_data_t::real_float, 2, &device_ws_size_s);
  //CHECK-NEXT:dpct::lapack::gesvd_scratchpad_size(*handle, oneapi::mkl::job::vec, 0, 2, 2, dpct::library_data_t::real_double, 2, dpct::library_data_t::real_double, 2, dpct::library_data_t::real_double, 2, &device_ws_size_d);
  //CHECK-NEXT:dpct::lapack::gesvd_scratchpad_size(*handle, oneapi::mkl::job::vec, 0, 2, 2, dpct::library_data_t::complex_float, 2, dpct::library_data_t::complex_float, 2, dpct::library_data_t::complex_float, 2, &device_ws_size_c);
  //CHECK-NEXT:dpct::lapack::gesvd_scratchpad_size(*handle, oneapi::mkl::job::vec, 0, 2, 2, dpct::library_data_t::complex_double, 2, dpct::library_data_t::complex_double, 2, dpct::library_data_t::complex_double, 2, &device_ws_size_z);
  cusolverDnSgesvdj_bufferSize(handle, CUSOLVER_EIG_MODE_VECTOR, 0, 2, 2, (float*)a_s, 2, (float*)s_s, (float*)u_s, 2, (float*)vt_s, 2, &device_ws_size_s, gesvdjinfo);
  cusolverDnDgesvdj_bufferSize(handle, CUSOLVER_EIG_MODE_VECTOR, 0, 2, 2, (double*)a_d, 2, (double*)s_d, (double*)u_d, 2, (double*)vt_d, 2, &device_ws_size_d, gesvdjinfo);
  cusolverDnCgesvdj_bufferSize(handle, CUSOLVER_EIG_MODE_VECTOR, 0, 2, 2, (float2*)a_c, 2, (float*)s_c, (float2*)u_c, 2, (float2*)vt_c, 2, &device_ws_size_c, gesvdjinfo);
  cusolverDnZgesvdj_bufferSize(handle, CUSOLVER_EIG_MODE_VECTOR, 0, 2, 2, (double2*)a_z, 2, (double*)s_z, (double2*)u_z, 2, (double2*)vt_z, 2, &device_ws_size_z, gesvdjinfo);

  void* device_ws_s;
  void* device_ws_d;
  void* device_ws_c;
  void* device_ws_z;
  int *info;

  //CHECK:dpct::lapack::gesvd(*handle, oneapi::mkl::job::vec, 0, 2, 2, dpct::library_data_t::real_float, (float*)a_s, 2, dpct::library_data_t::real_float, (float*)s_s, dpct::library_data_t::real_float, (float*)u_s, 2, dpct::library_data_t::real_float, (float*)vt_s, 2, (float*)device_ws_s, device_ws_size_s, info);
  //CHECK-NEXT:dpct::lapack::gesvd(*handle, oneapi::mkl::job::vec, 0, 2, 2, dpct::library_data_t::real_double, (double*)a_d, 2, dpct::library_data_t::real_double, (double*)s_d, dpct::library_data_t::real_double, (double*)u_d, 2, dpct::library_data_t::real_double, (double*)vt_d, 2, (double*)device_ws_d, device_ws_size_d, info);
  //CHECK-NEXT:dpct::lapack::gesvd(*handle, oneapi::mkl::job::vec, 0, 2, 2, dpct::library_data_t::complex_float, (sycl::float2*)a_c, 2, dpct::library_data_t::real_float, (float*)s_c, dpct::library_data_t::complex_float, (sycl::float2*)u_c, 2, dpct::library_data_t::complex_float, (sycl::float2*)vt_c, 2, (sycl::float2*)device_ws_c, device_ws_size_c, info);
  //CHECK-NEXT:dpct::lapack::gesvd(*handle, oneapi::mkl::job::vec, 0, 2, 2, dpct::library_data_t::complex_double, (sycl::double2*)a_z, 2, dpct::library_data_t::real_double, (double*)s_z, dpct::library_data_t::complex_double, (sycl::double2*)u_z, 2, dpct::library_data_t::complex_double, (sycl::double2*)vt_z, 2, (sycl::double2*)device_ws_z, device_ws_size_z, info);
  cusolverDnSgesvdj(handle, CUSOLVER_EIG_MODE_VECTOR, 0, 2, 2, (float*)a_s, 2, (float*)s_s, (float*)u_s, 2, (float*)vt_s, 2, (float*)device_ws_s, device_ws_size_s, info, gesvdjinfo);
  cusolverDnDgesvdj(handle, CUSOLVER_EIG_MODE_VECTOR, 0, 2, 2, (double*)a_d, 2, (double*)s_d, (double*)u_d, 2, (double*)vt_d, 2, (double*)device_ws_d, device_ws_size_d, info, gesvdjinfo);
  cusolverDnCgesvdj(handle, CUSOLVER_EIG_MODE_VECTOR, 0, 2, 2, (float2*)a_c, 2, (float*)s_c, (float2*)u_c, 2, (float2*)vt_c, 2, (float2*)device_ws_c, device_ws_size_c, info, gesvdjinfo);
  cusolverDnZgesvdj(handle, CUSOLVER_EIG_MODE_VECTOR, 0, 2, 2, (double2*)a_z, 2, (double*)s_z, (double2*)u_z, 2, (double2*)vt_z, 2, (double2*)device_ws_z, device_ws_size_z, info, gesvdjinfo);

  //CHECK:/*
  //CHECK-NEXT:DPCT1026:{{[0-9]+}}: The call to cusolverDnDestroyGesvdjInfo was removed because this call is redundant in SYCL.
  //CHECK-NEXT:*/
  cusolverDnDestroyGesvdjInfo(gesvdjinfo);
}
