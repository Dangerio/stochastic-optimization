function [x, y] = annealing_alg(f, opt_set, alpha, t_0, t_thr)
dim = size(opt_set, 1);
x = zeros(1, dim);
for i = 1:dim
    lb = opt_set(i, 1);
    ub = opt_set(i, 2);
    x(1, i) = unifrnd(lb, ub);
end

t = t_0;
y = f(x);
while t > t_thr
    x_new = zeros(1, dim);
    for i = 1:dim
        lb = opt_set(i, 1);
        ub = opt_set(i, 2);
        x_new(1, i) = x(1, i) + unifrnd((lb - ub) / 20, (ub - lb) / 20);
    end
    y_new = f([x_new]);

    delta_y = y_new - y;
    p = exp(-delta_y / t);
    xi = binornd(1, p);
    if or(delta_y < 0, xi == 1)
        x = x_new;
        y = y_new;
    end
    t = t * alpha;
end