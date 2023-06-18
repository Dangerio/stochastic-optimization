function [q, k] = annealing(n, alpha, t_0)
t = t_0;
q = 1:n;
strikes = h(q);
k = 0;
while strikes ~= 0
    t_new = alpha * t;
    q_new = swap(q);
    strikes_new = h(q_new);
    delta_strikes = strikes_new - strikes;
    p = exp(-delta_strikes / t);
    xi = binornd(1, p);
    if or(delta_strikes < 0, xi == 1)
        q = q_new;
        strikes = strikes_new;
    end
    t = t_new;
    k = k + 1;
end