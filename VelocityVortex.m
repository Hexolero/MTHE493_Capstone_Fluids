function [ resu, resv ] = VelocityVortex( gamma, O, P )
%% VelocityVortex returns the velocity vector a vortex of strength gamma at
% location O would induce at a point P.
P = P - O;
normsqr = P(1).^2 + P(2).^2;
str = gamma / (2 * pi);
fac = str / normsqr;
resu = fac * P(2);
resv = -fac * P(1);

end

