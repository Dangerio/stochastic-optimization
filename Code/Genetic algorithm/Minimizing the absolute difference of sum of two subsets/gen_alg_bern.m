function [y_min, x_min] = gen_alg_bern(f, dim, M, M_c, L) 
X = zeros(M, dim);
X = binornd(1, 0.5, M, dim);
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
    X(replace_ind, :) = binornd(1, 0.5, M_c, dim);
end
x_min = X(1, :);
y_min = f(x_min);