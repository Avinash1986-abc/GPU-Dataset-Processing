# Team 8 - GPU Dataset Processing

## Objective

Process a large numerical dataset using CUDA and analyze the execution time.

## Technology Used

- CUDA
- C++
- Google Colab
- NVIDIA Tesla T4 GPU

## Dataset Sizes

The program was tested with the following dataset sizes:

- 100,000 elements
- 500,000 elements
- 1,000,000 elements
- 2,000,000 elements

## Implementation

Two implementations were used:

1. Sequential CPU implementation
2. CUDA GPU implementation

The CUDA implementation was tested using:

- 128 threads per block
- 256 threads per block
- 512 threads per block

## Results

The execution time of the CPU and CUDA implementations was measured for different dataset sizes.

### 1. Execution Time

This graph compares the sequential CPU execution time with the best CUDA execution time for each dataset size.

![Execution Time](graphs/execution_time.png)

### 2. CUDA Speedup

Speedup is calculated using:

**Speedup = CPU Execution Time / CUDA Execution Time**

![CUDA Speedup](graphs/speedup.png)

### 3. CUDA Configuration Efficiency

This graph compares the performance of the CUDA configurations using 128, 256, and 512 threads per block.

![CUDA Configuration Efficiency](graphs/efficiency.png)


