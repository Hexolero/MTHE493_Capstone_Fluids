function [ u, v ] = TotalFlow( controlPoints, lambda, flowFieldFnHandle, P )
%% TotalFlow takes a set of control points, the panel strength vector
% lambda, and it computes the sum of the given flow field with the control
% panel flows for the input point P.
[u, v] = flowFieldFnHandle(P);

[N, ~] = size(controlPoints);
for i=1:N
    [du, dv] = UntreatedVelocitySS(controlPoints(i, :), controlPoints(mod(i, N) + 1, :), P);
    u = u + lambda(i) * du;
    v = v + lambda(i) * dv;
end

end