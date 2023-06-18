function [y_min, x_min] = gen_alg_unif(f, D, M, M_c, L) 
dim = size(D, 1);
X = zeros(M, dim);
for i = 1:dim
    x_lower = D(i, 1);
    x_upper = D(i, 2);
    X(:, i) = unifrnd(x_lower, x_upper, M, 1);
end
for t = 1:L
    fit = ones(M, 1) ./ (1 + f(X));
    X = [fit X];
    X = sortrows(X, 1, "descend");
    fit = X(:, 1);
    X = X(:, 2:(dim + 1));
    male_idx = 2:M - M_c;
    female_idx = randsample(1:length(M), M - M_c - 1, true);
    male = X(male_idx, :);
    female = X(female_idx, :);
    child_male_gen_ind = zeros(M - M_c - 1, dim);
    male_proba = fit(male_idx) / (fit(male_idx) + fit(female_idx));
    for i = 1:M - M_c - 1
        child_male_gen_ind(i, :) = binornd(1, male_proba(i), 1, dim);
    end
    X = male .* child_male_gen_ind + female .* (1 - child_male_gen_ind);
    replace_ind = (M - M_c + 1):M;
    for i = 1:dim
        x_lower = D(i, 1);
        x_upper = D(i, 2);
        X(replace_ind, i) = unifrnd(x_lower, x_upper, M_c, 1);
    end
end
x_min = X(1, :);
y_min = f(x_min);