#include <stdio.h>
#include <assert.h>

// CUDA runtime
#include <cuda_runtime.h>

// helper functions and utilities to work with CUDA
//#include <helper_functions.h>
//#include <helper_cuda.h>

#define MAX 1024
#define M 2

__global__ void testKernel(int val)
{
    long int off_set = blockDim.x * M;
    
    int id = blockIdx.x * blockDim.x *M;


    for(id = id;id < MAX; id = id + off_set){
    printf("[%d, %d]:\t\tValue is:%d\n",\
            blockIdx.x,\
            threadIdx.x,\
            val);
    }
}

int main(int argc, char **argv)
{
 /*
    int devID;
    cudaDeviceProp props;

    // This will pick the best possible CUDA capable device
    devID = findCudaDevice(argc, (const char **)argv);

    //Get GPU information
    checkCudaErrors(cudaGetDevice(&devID));
    checkCudaErrors(cudaGetDeviceProperties(&props, devID));
    printf("Device %d: \"%s\" with Compute %d.%d capability\n",
           devID, props.name, props.major, props.minor);

    printf("printf() is called. Output:\n\n");

    //Kernel configuration, where a two-dimensional grid and
    //three-dimensional blocks are configured.
  */
    testKernel<<<M, 32>>>(10);
    cudaDeviceSynchronize();

    return EXIT_SUCCESS;
}


