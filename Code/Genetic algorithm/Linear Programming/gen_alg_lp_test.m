M = 1000;
M_c = 200;
L = 300;

% test - 1
A = eye(3);
b = [0.5, 1, 2]';
c = [1, 1, 1]';
int_idx = [3];

true = [0.5, 1, 2];
[~, x_best] = gen_alg_lp(A, c, b, int_idx, M, M_c, L);
disp(true)
disp(x_best)

% test - 2 
A = [[40, 30]; [20, 30]];
b = [4000, 3000]';
c = [30, 40]';
int_idx = [];
[~, x_best] = gen_alg_lp(A, c, b, int_idx, M, M_c, L);
true = [50, 200/3];
disp(true)
disp(x_best)

% test - 3
A = [[40, 30]; [20, 30]];
b = [4000, 3000]';
c = [30, 40]';
int_idx = [1];
[~, x_best] = gen_alg_lp(A, c, b, int_idx, M, M_c, L);
true = [50, 200/3];
disp(true)
disp(x_best)

% test - 4
A = [[40, 30]; [20, 30]];
b = [4000, 3000]';
c = [30, 40]';
int_idx = [2];
[~, x_best] = gen_alg_lp(A, c, b, int_idx, M, M_c, L);
disp(true)
disp(x_best)


% test - 5
A = [[10, 20, 30]; [60, 20, 10]; [35.4, 40.2, 50]];
b = [1000, 750, 830.5]';
c = [30, 15, 22.5]';
int_idx = [2, 3];

true = intlinprog(-c, int_idx, A, b ,[], [] , zeros(3, 1));
[~, x_best] = gen_alg_lp(A, c, b, int_idx, M, M_c, L);
disp(true)
disp(x_best)
