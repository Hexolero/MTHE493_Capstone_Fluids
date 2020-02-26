clear
clc

%% TEST 1 - Plot flow field from a single source sheet.
%A = [-0.25 -0.25];
%B = [0.25 0.25];
%
%range = -0.5:0.026:0.5;8
%[x, y] = meshgrid(range, range);
%[u, v] = UVSS_List(A, B, x, y);
%
%quiver(x, y, u, v);
%hold on
%plot([A(1) B(1)], [A(2) B(2)], 'r');

%% TEST 2 - Solve AIC for a freestream and plot the flow field.
% freestream = @(P) [1 0];
% controlPoints = [-0.5 0; 0 0.5; 0.5 0; 0 -0.5]; % diamond body
% lambda = AIC_Solve(controlPoints, freestream);
% 
% % plot resulting flow field
% range = -1:0.021:1;
% [x, y] = meshgrid(range, range);
% u = zeros(size(x)) + 1; % freestream
% v = zeros(size(x));
% for i=1:4
%    [nu, nv] = UVSS_List(controlPoints(i, :), controlPoints(mod(i, 4) + 1, :), x, y);
%    u = u + lambda(i) * nu;
%    v = v + lambda(i) * nv;
% end
% quiver(x, y, u, v);
% PlotControlPoints(controlPoints);
% hold on;
% streamline(x, y, u, v, zeros(size(-0.5:0.011:0.5)) - 0.75, -0.5:0.011:0.5);

%% TEST 3 - More complex body with freestream
freestream = @(P) [1 0.5];
controlPoints = [-0.5 0.05; -0.4 0.75; 0 0.5; 0.3 0.3; 0.5 0.05; 0.5 -0.05; 0.3 -0.3; 0 -0.5; -0.3 -0.3; -0.5 -0.05];
lambda = AIC_Solve(controlPoints, freestream);

[N, ~] = size(controlPoints);

% plot resulting flow field
range = -1:0.02:1;
[x, y] = meshgrid(range, range);
u = zeros(size(x)) + 1; % freestream
v = zeros(size(x)) + 0.5;
for i=1:N
   [nu, nv] = UVSS_List(controlPoints(i, :), controlPoints(mod(i, N) + 1, :), x, y);
   u = u + lambda(i) * nu;
   v = v + lambda(i) * nv;
end
quiver(x, y, u, v);
PlotControlPoints(controlPoints);
hold on;
streamline(x, y, u, v, zeros(size(-0.5:0.1:0.5)) - 0.75, -0.5:0.1:0.5);