#include <string>                   // For kernel source
#include <vector>                   // For matrices
#include <iostream>                 // For output
#include <CL/cl.hpp>                // For OpenCL

#ifndef __CL_ENABLE_EXCEPTIONS      // For exceptions handling
#define __CL_ENABLE_EXCEPTIONS
#endif

int main(void)
{
    try
    {
        std::vector<int> A =        // First matrix
               {1, 2, 3, 4,
                5, 6, 7, 8,
                9,10,11,12,
                13,14,15,16};

        std::vector<int> B =        // Second matrix
               {16,15,14,13,
                12,11,10, 9,
                8, 7, 6, 5,
                4, 3, 2, 1};

        std::vector<int> C(16);     // Result

        std::string sourceAdd  =    // Kernel source
                "__kernel void addMatrix(                               "
                "   __global int* A,                                    "
                "   __global int* B,                                    "
                "   __global int* C,                                    "
                "   int size)                                           "
                "{                                                      "
                "   int i = get_global_id(0)*size + get_global_id(1);   "
                "   C[i] = A[i] + B[i];                                 "
                "}                                                      ";

        // Gets the first available platform
        cl::Platform platform = cl::Platform::get();

        // Get all available devices per platform
        std::vector<cl::Device> devices;
        platform.getDevices(CL_DEVICE_TYPE_ALL, &devices);

        // Create context for devices on platform
        cl_context_properties properties[] = {
            CL_CONTEXT_PLATFORM,
            (cl_context_properties)(platform)(),
            0};
        cl::Context context(devices, properties);

        // Create command queue for first device
        cl::CommandQueue queue(context, devices[0]);

        // Create program
        cl::Program program(context, sourceAdd, false);

        // Build program for devices
        program.build(devices);

        // Create memory buffers
        cl::Buffer bufferA(
                    context,
                    CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
                    sizeof(int) * 16,
                    A.data());
        cl::Buffer bufferB(
                    context,
                    CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
                    sizeof(int) * 16,
                    B.data());
        cl::Buffer bufferC(
                    context,
                    CL_MEM_WRITE_ONLY,
                    sizeof(int) * 16);

        // Create kernel
        cl::Kernel kernel(program, "addMatrix");

        // Apply kernel arguments
        kernel.setArg(0, bufferA);
        kernel.setArg(1, bufferB);
        kernel.setArg(2, bufferC);
        kernel.setArg(3, 4);

        // Create event listener object
        cl::Event event;

        // Run kernel
        queue.enqueueNDRangeKernel(
                    kernel,
                    cl::NullRange,      // Offset range
                    cl::NDRange(4,4),   // Global range
                    cl::NDRange(2,2),   // Local range
                    NULL,
                    &event);

        // Wait untill done
        event.wait();

        // Read results
        queue.enqueueReadBuffer(
                    bufferC,
                    CL_FALSE,           // Blocking
                    0,                  // Offset
                    sizeof(int) * 16,
                    C.data(),
                    NULL,
                    &event);

        // Wait untill done
        event.wait();

        for(int i: C)
            std::cout << i << " ";

        // All cl objects will be destroyed automatically
    }
    catch(std::exception e)
    {
        std::cout << e.what();
    }
    return 0;
}
