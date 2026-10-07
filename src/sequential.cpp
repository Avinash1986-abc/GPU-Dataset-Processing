#include <iostream>
#include <vector>
#include <random>
#include <chrono>

using namespace std;
using namespace chrono;

int main() {

    const long long N = 100000;

    vector<float> data(N);

    // Generate dataset
    mt19937 generator(42);
    uniform_real_distribution<float> distribution(1.0, 100.0);

    for (long long i = 0; i < N; i++) {
        data[i] = distribution(generator);
    }

    // Start timing
    auto start = high_resolution_clock::now();

    double sum = 0.0;

    // Sequential summation
    for (long long i = 0; i < N; i++) {
        sum += data[i];
    }

    double average = sum / N;

    // End timing
    auto end = high_resolution_clock::now();

    double cpu_time =
        duration<double>(end - start).count();

    // Display results
    cout << "Dataset Size: " << N << endl;
    cout << "Sum: " << sum << endl;
    cout << "Average: " << average << endl;
    cout << "CPU Execution Time: "
         << cpu_time << " seconds" << endl;

    return 0;
}