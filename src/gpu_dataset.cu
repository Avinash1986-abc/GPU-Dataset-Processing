#include <iostream>
#include <cuda_runtime.h>

using namespace std;

__global__ void sumKernel(const float* data, double* result, long long N) {

    int idx = blockIdx.x * blockDim.x + threadIdx.x;

    if (idx < N) {
        atomicAdd(result, (double)data[idx]);
    }
}

int main() {

    const long long N = 100000;
    const int threadsPerBlock = 128;

    size_t dataSize = N * sizeof(float);

    float* h_data = new float[N];

    unsigned int seed = 42;

    // Generate numerical dataset
    for (long long i = 0; i < N; i++) {
        seed = 1664525 * seed + 1013904223;
        h_data[i] = 1.0f + (seed % 9901) / 100.0f;
    }

    float* d_data;
    double* d_result;

    cudaMalloc(&d_data, dataSize);
    cudaMalloc(&d_result, sizeof(double));

    double zero = 0.0;

    cudaMemcpy(d_data, h_data, dataSize, cudaMemcpyHostToDevice);
    cudaMemcpy(d_result, &zero, sizeof(double),
               cudaMemcpyHostToDevice);

    int blocks = (N + threadsPerBlock - 1) / threadsPerBlock;

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    // Start GPU timing
    cudaEventRecord(start);

    sumKernel<<<blocks, threadsPerBlock>>>(d_data, d_result, N);

    cudaEventRecord(stop);
    cudaEventSynchronize(stop);

    float gpuTime;
    cudaEventElapsedTime(&gpuTime, start, stop);

    double sum;

    cudaMemcpy(&sum, d_result, sizeof(double),
               cudaMemcpyDeviceToHost);

    double average = sum / N;

    cout << "Dataset Size: " << N << endl;
    cout << "Threads per Block: " << threadsPerBlock << endl;
    cout << "Blocks: " << blocks << endl;
    cout << "Sum: " << sum << endl;
    cout << "Average: " << average << endl;
    cout << "GPU Execution Time: "
         << gpuTime / 1000.0 << " seconds" << endl;

    cudaFree(d_data);
    cudaFree(d_result);
    delete[] h_data;

    return 0;
}