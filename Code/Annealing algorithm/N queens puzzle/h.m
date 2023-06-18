function [cnt] = h(q)
n = size(q, 2);
cnt = 0;
for i = 1:n
    for j = i+1:n
        if j - i == abs(q(j) - q(i))
            cnt = cnt + 2;
        end
    end
end
end


