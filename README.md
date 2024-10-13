# Entropy Estimation Project

This project implements an entropy estimation method based on eigenvalue decomposition and kernel density estimation. The goal is to estimate the number of sources in a given dataset using a statistical approach.

## Overview

The code performs the following steps:
1. Loads the data from a `.mat` file.
2. Calculates estimations based on the eigenvalues of the covariance matrix.
3. Uses a kernel entropy estimator to estimate the number of sources in the dataset.

## Code Structure

### Main Script

- **Data Loading**: Loads the dataset from a `.mat` file.
- **Calculating Estimations**: Computes the covariance matrix and performs eigenvalue decomposition.
- **Entropy Estimation**: Estimates the number of sources using the `EEE_estimator` function.

### Functions

- **`EEE_estimator(data, P)`**
  - **Inputs**: 
    - `data`: Input data matrix of size \(N \times T\)
    - `P`: Number of sources to estimate
  - **Outputs**: Estimated number of sources.
  - **Description**: Estimates the number of sources based on the difference in kernel entropy calculated from sorted eigenvalues.

- **`kernel_entropy_estimator(eigenvalues)`**
  - **Inputs**: 
    - `eigenvalues`: Sorted eigenvalues obtained from the covariance matrix.
  - **Outputs**: Estimated entropy.
  - **Description**: Computes the entropy of the eigenvalues using a Gaussian kernel.

## Usage

To run the project, follow these steps:

1. Ensure you have the required data in a `.mat` file format.
2. Load the project in MATLAB or compatible environment.
3. Run the main script to perform the entropy estimation.

```matlab
% Load the data
data = load('data.mat');
data = data.recieve;

% Call the entropy estimation function
[x, y] = min(EEE_estimator(data, 40));
disp("The number of sources: ")
disp(y)
