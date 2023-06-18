function [q_old] = swap(q_old)
n = size(q_old, 2);
idx = randi([1, n], 1, 2);
q_old([idx(1), idx(2)]) = q_old([idx(2), idx(1)]);
end
