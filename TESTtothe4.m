% clear
% clc
% 
% freestream = @(P) VelocityFreestreamVortices([2*pi, 0], [2*pi, pi], [0 0; 0.2 0], P);
% 
% range = [-0.25:0.005:-0.005, 0.005:0.005:0.25];
% [x, y] = meshgrid(range, range);
% u = zeros(size(x));
% v = zeros(size(x));
% [nx, ~] = size(x);
% [ny, ~] = size(y);
% for i=1:nx
%     for j=1:ny
%         [u(i, j), v(i, j)] = freestream([x(i, j), y(i, j)]);
%     end
% end
% 
% quiver(x, y, u, v);

%% TEST 4 - Plot flow field from a single LINEAR source panel.
A = [-0.25 -0.25];
B = [0.25 0.25];

range = -0.5:0.026:0.5;
[x, y] = meshgrid(range, range);

u = zeros(size(x));
v = zeros(size(x));

[nx, ~] = size(x);
[ny, ~] = size(y);

alpha = sin(linspace(-1,1));
beta = BetaFromAlpha(alpha);
for i=1:nx
    for j=1:ny
        [u(i, j), v(i, j)] = LinearVelocitySS(A, B, [x(i, j), y(i, j)], alpha, beta);
    end
end

quiver(x, y, u, v);
hold on
plot([A(1) B(1)], [A(2) B(2)], 'r');