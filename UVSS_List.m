function [ u_list, v_list ] = UVSS_List( A, B, x_mesh, y_mesh )
%% UVSS_List takes the geometry of a source sheet and a list of points to
% evaluate the flow generated by an untreated (density 1) source sheet with
% this geometry.
% returns the flow in x,y row pairs as a 2-column matrix.
% NB: x_mesh and y_mesh are generated by meshgrid(x_range, y_range)
% also note this won't do any input checking so don't pass silly args

u_list = zeros(size(x_mesh));
v_list = zeros(size(x_mesh));

[nx, ~] = size(x_mesh);
[ny, ~] = size(y_mesh);
for i=1:nx
    for j=1:ny
        [u_list(i, j), v_list(i, j)] = UntreatedVelocitySS(A, B, [x_mesh(i, j), y_mesh(i, j)]);
    end
end

