#include <stdio.h>
#include <assert.h>

// CUDA runtime
#include <cuda_runtime.h>

// helper functions and utilities to work with CUDA
//#include <helper_functions.h>
//#include <helper_cuda.h>

#define MAX 1024
#define M 2

static __device__ __inline__ unsigned int __mysmid(){
	unsigned int smid;
	asm volatile("mov.u32 %0, %%smid;" : "=r"(smid));
	return smid;

}

__global__ void testKernel(int SM_num_start, int SM_num_end,int val)
{
    int SM_num;
    SM_num = __mysmid();

    if((SM_num_start <= SM_num)&&(SM_num <= SM_num_end)){


    
	

    long int off_set = blockDim.x * (SM_num_end - SM_num_start + 1);
    
    int id = threadIdx.x + (SM_num - SM_num_end)* blockDim.x;


    for(id = id;id < MAX; id = id + off_set){
    printf("[%d, %d]:\t\tValue is:%d\n",\
            blockIdx.x,\
            threadIdx.x,\
            val);
    }
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

    int SM_num_start = 0;
    int SM_num_end = 2;
    testKernel<<<1024/32, 32>>>(SM_num_start,SM_num_end ,10);
    cudaDeviceSynchronize();

    return EXIT_SUCCESS;
}


