function [y_best, x_best] = gen_alg_lp(A, c, b, int_idx, M, M_c, L) 
% get continious variables indexes
n = size(A, 2);
cont_idx = 1:n;
cont_idx(int_idx) = [];
% determine bounds of variables
B = repmat(b, 1, n);
x_max = min(B ./ (A + 1e-8))';
x_min = zeros(n, 1);

% generate population
X = zeros(M, n);
% continious variables
for i = cont_idx
    x_lower = x_min(i);
    x_upper = x_max(i);
    X(:, i) = unifrnd(x_lower, x_upper, M, 1);
end
% integer variables
for i = int_idx
    x_lower = x_min(i);
    x_upper = floor(x_max(i)) + 1;
    X(:, i) = randi([x_lower, x_upper], M, 1);
end

% main loop
for t = 1:L
    % profit calc
    y = X * c;
    % fit func calc and checking constraint
    res_usage = A * X';
    res_cond_mask = all(res_usage <= repmat(b, 1, M), 1);
    fit = y;
    fit(~res_cond_mask) = 0;
    % sort gens
    X = [fit X];
    X = sortrows(X, 1, "descend");
    fit = X(:, 1);
    X = X(:, 2:(n + 1));
    % crossing
    male_idx = 2:M - M_c;
    female_idx = randsample(1:length(M), M - M_c - 1, true);
    male = X(male_idx, :);
    female = X(female_idx, :);
    child_male_gen_ind = zeros(M - M_c - 1, n);
    male_proba = fit(male_idx) ./ (fit(male_idx) + fit(female_idx) + 1e-8);
    for i = 1:M - M_c - 1
        child_male_gen_ind(i, :) = binornd(1, male_proba(i), 1, n);
    end
    X = male .* child_male_gen_ind + female .* (1 - child_male_gen_ind);
    replace_ind = (M - M_c + 1):M;
    % replacing M_c gens
    % cont variables
    for i = cont_idx
        x_lower = x_min(i);
        x_upper = x_max(i);
        X(replace_ind, i) = unifrnd(x_lower, x_upper, M_c, 1);
    end
    % integer variables
    for i = int_idx
        x_lower = x_min(i);
        x_upper = floor(x_max(i)) + 1;
        X(replace_ind, i) = randi([x_lower, x_upper], M_c, 1);
    end
end
x_best = X(1, :);
y_best = x_best * c;
