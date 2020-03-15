function [ resu, resv ] = LinearVelocitySS( A, B, P, alpha, beta )
%% LinearVelocitySS returns the velocity at point P given by a piecewise
% linear source panel between A and B with parameters (alpha, beta)
% (both vectors) giving the density averages and differences respectively.

%% 1. Define equations and other setup
Lf = @(x, y) log((y.^2 + (x + 1/2).^2) / (y.^2 + (x - 1/2).^2));
Af = @(x, y) atan((x + 1/2) / y) - atan((x - 1/2) / y);
u = @(x, y, k) (1/(4*pi)) * (alpha(k) * Lf(x,y) + beta(k) * (x*Lf(x, y) + 2*y*Af(x,y) - 2));
v = @(x, y, k) (1/(2*pi)) * (alpha(k) * Af(x,y) + beta(k) * (x*Af(x,y) - (1/2)*y*Lf(x,y)));

% number of panel segments
M = numel(alpha);

%% 2. Evaluation
resu = 0;
resv = 0;

% Iterate over all panel segments, each panel requires a different
% transformation of P
P_original = P;
for k=1:M
    Ak = A + (B - A) * (k - 1) / M;
    Bk = A + (B - A) * k / M;
    
    % Translate by midpoint
    Mk = (Ak + Bk) / 2;
    P = P - Mk;
    % Rotate by angle of Bk - Ak
    thetak = -atan((Bk(2) - Ak(2)) / (Bk(1) - Ak(1)));
    R = [cos(thetak) -sin(thetak); sin(thetak) cos(thetak)];
    P = (R * P')';
    % 3. stretch Bk - Ak so that Ak falls on (-1/2, 0) and Bk falls on (1/2, 0)
    P = P / norm(Bk - Ak);
    % Calculate translated point and velocity at this point
% FROM UntreatedVelocitySS IMPLEMENT LATER
%     if P(2) == 0 % careful when transformed y is 0
%         % Default take the *upwards* normal as the direction
%         % NB this may be cause of weird behaviour later!!!
%         unvel = [u(P(1), P(2)), 1/2];
%     else
%         unvel = [u(P(1), P(2)), v(P(1), P(2))];
%     end
    velk = [u(P(1), P(2), k), v(P(1), P(2), k)];
    
    % The only inverse transform we have to do on the velocity is rotation.
    R_inv = [cos(thetak) sin(thetak); -sin(thetak) cos(thetak)];
    velk = (R_inv * velk')';
    resu = resu + velk(1);
    resv = resv + velk(2);
    
    P = P_original;
end
end

