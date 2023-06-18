function [x, y] = annealing_alg(alpha, t_0, t_thr)
t = t_0;
x = unifrnd(-10, 10);
y = x^2 * (2 + abs(sin(4 * x)));
while t > t_thr
    x_new = x + unifrnd(-1, 1);
    y_new = x_new^2 * (2 + abs(sin(4 * x_new)));
    delta_y = y_new - y;
    p = exp(-delta_y / t);
    xi = binornd(1, p);
    if or(delta_y < 0, xi == 1)
        x = x_new;
        y = y_new;
    end
    t = t * alpha;
end