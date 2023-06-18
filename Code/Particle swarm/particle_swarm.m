function [argvalue_global, argmin_global] = particle_swarm(f, dim, x_lower, x_upper, alpha, beta, gamma, M, L) 
X = unifrnd(x_lower, x_upper, M, dim);
V = unifrnd(x_lower - x_upper, x_upper - x_lower, M, dim); 
X = X + V;
y = f(X);
argvalue_local = y;
argmin_local = X;

[argvalue_global, idxmin_global] = min(argvalue_local);
argmin_global = argmin_local(idxmin_global, :);

for t = 1:L
    xi_1 = repmat(unifrnd(0, 1, M, 1), 1, dim);
    xi_2 = repmat(unifrnd(0, 1, M, 1), 1, dim);
    V = alpha * V + beta * xi_1 .* (argmin_local - X) +  gamma * xi_2 .* (argmin_global - X);
    X = X + V;
    y = f(X);
    [argvalue_local, idxmin_local] = min([argvalue_local, y], [], 2);
    mask_idx = find(idxmin_local == 2);
    argmin_local(mask_idx, :) = X(mask_idx, :);
    [argvalue_global, idxmin_global] = min(argvalue_local);
    argmin_global = argmin_local(idxmin_global, :);
end