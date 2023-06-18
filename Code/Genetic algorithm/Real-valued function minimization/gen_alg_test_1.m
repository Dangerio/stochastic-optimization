function [y] = gen_alg_test_1(X)
dim = size(X, 2);
y = 0;
for i = 1:dim
    y = y + X(:, i).^2 .* (1 + abs(sin(100 * X(:, i))));
end

