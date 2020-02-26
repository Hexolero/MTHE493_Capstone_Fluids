function [ bool_mesh ] = PnPolyMesh( controlPoints, x_mesh, y_mesh )
%% PnPoly takes a set of control points defining a body, and checks if the
% given points lie inside the polygon or not.
% This uses a horizontal raycast algorithm - should be reasonably fast.
% Worth noting that we say points ON the line are INSIDE.

bool_mesh = zeros(size(x_mesh));

[nx, ~] = size(x_mesh);
[ny, ~] = size(y_mesh);
[N, ~] = size(controlPoints);
% iterate over all points in the grid
for i=1:nx
    for j=1:ny
        % iterate over all panels
        
        for k=1:N
            if ()
                bool_mesh(i, j) = ~bool_mesh(i, j);
            end
            bool_mesh(i, j) = 
        end
    end
end

end

