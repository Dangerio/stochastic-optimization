function [y] = gen_alg_test_2(X)
dim = size(X, 2);
start = 1;
stop = start + dim - 1;
A = repmat(start:stop, size(X, 1), 1);

Z = zeros(size(X, 1), dim);
mask_0 = X == 0;
Z(mask_0) = A(mask_0);
sum_0 = sum(Z, 2);

Z = zeros(size(X, 1), dim);
mask_1 = X == 1;
Z(mask_1) = A(mask_1);
sum_1 = sum(Z, 2);

y = abs(sum_1 - sum_0);