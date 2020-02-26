function [ bool_mesh ] = PnPolyMesh( controlPoints, x_mesh, y_mesh )
%% PnPoly takes a set of control points defining a body, and checks if the
% given points lie inside the polygon or not.
% This uses a horizontal raycast algorithm - should be reasonably fast.
% Worth noting that we say points ON the line are INSIDE.

% default false - need an odd number of crossings to be inside.
bool_mesh = zeros(size(x_mesh));

[nx, ~] = size(x_mesh);
[ny, ~] = size(y_mesh);
[N, ~] = size(controlPoints);
% iterate over all points in the grid
for i=1:nx
    for j=1:ny
        % iterate over all panels
        P = [x_mesh(i, j) y_mesh(i, j)];
        A = controlPoints(N);
        for k=1:N
            B = controlPoints(k);
            if ((A(2) >= P(2)) ~= (B(2) >= P(2))) && 
                bool_mesh(i, j) = ~bool_mesh(i, j);
            end
            
        end
    end
end

end

