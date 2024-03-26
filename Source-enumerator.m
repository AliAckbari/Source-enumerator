%% Loading our data into the workspace

data = load('data.mat');

data = data.recieve;

%% Calculating the estimations

N = length(data);
sq_data = data*data';
[V,D] = eig(sq_data);
% Sorting the eigenvalues and eigenvectors
[D, ind] = sort(diag(D), 'descend');
D = diag(D);
%V = V(:, ind);
C_hat = V*D*V';

%% Entropy estimation

[x,y] = min(EEE_estimator(data, 40));
disp("The number of sources: ")
disp(y)
function K_hat = EEE_estimator(data, P)
    % Inputs:
    %   - data: Input data matrix of size N x T
    %   - P: Number of sources to estimate

    % Step 1: Compute covariance matrix
    % Step 2: Compute eigenvalues
    eigenvalues = eig(data*data');

    % Step 3: Sort eigenvalues in descending order
    sorted_eigenvalues = sort(eigenvalues, 'descend');
    % Step 4: Initialize variables
    K_hat = zeros(1, P-1);

    % Step 5: Perform EEE estimation
    for i = 1:P-1
        H_prev = kernel_entropy_estimator(sorted_eigenvalues(i:P));
        H_next = kernel_entropy_estimator(sorted_eigenvalues(i+1:P));

        % Find the index of the minimum difference
        K_i = H_next - H_prev;

        % Update the estimated number of sources
        K_hat(i) = K_i;
    end
end

function H = kernel_entropy_estimator(eigenvalues)

    N = length(eigenvalues);
    sigma = var(eigenvalues);
    m = 1/5;
    d = 1.06*sqrt(sigma);
    h = d/(N^m);
    % Gaussian kernel function
    kernel = @(x) 1/(sqrt(2*pi)*h)*exp(-0.5 * (x / h).^2);

    % Compute entropy estimate
    S = 0;
    for i=1:N
        sum = 0;
        yi = eigenvalues(i);
        for j=1:N
            yj = eigenvalues(j);
            sum = sum + kernel(yi-yj);
        end
        S = S + (log2(1/N*sum));
    end
    H = -1/N*S;
end