function [force torque] = ForceTorqueCalc (controlPoints, lambda, flowFieldFnHandle, stagPressure)
% ForceTorqueCalc calcualtes the resulting force and torques acting on the 
% body due to the pressures forces acting on the body
%   

%% STEP 0: Define variables used throughout program
% Number of panels in shape
N = size(controlPoints,1); 
% Desity of saltwater [kg/m^3]
RHO = 1020;
% Thickness of each panel [m](maybe should be a parameter that gets passed
% in?)
THICKNESS = 0.1;
% Center of mass of shape
COM = [sum(controlPoints(:,1)), sum(controlPoints(:,2))] / N;

%% STEP 1: Determine normal vectors for each panel
% Normal vector pointing outward from shape for each panel
normals = zeros(size(controlPoints));

for i=1:N
    % rotate B - A by 90 degrees
    normals(i, :) = ([0 -1; 1 0] * (controlPoints(mod(i, N) + 1, :) - controlPoints(i, :))')';
    normals(i, :) = normals(i, :) / norm(normals(i, :));
end

%% STEP 2: Calculate Midpoint and Length for each panel
% Coordinatees of the midpoint for each panel 
midpoints = zeros(size(controlPoints));
% The length of each panel
lengths = zeros(N,1);

for i=1:N
    midpoints(i,:) = (controlPoints(i) + controlPoints(mod(i,N)+1)) / 2;
    lengths(i) = vecnorm(controlPoints(i) - controlPoints(mod(i,N)+1));
end

%% STEP 3: Force due to pressure at each panel's midpoint
% Calcualte the force due to pressure acting at the midpoint of each panel
PressureForce = zeros(size(controlPoints));

for i=1:N
    % get x and y components of velocity at midpoint of panel using
    % TotalFlow function and then calcualte corresponding pressure force.
    % Note that pressure force acts in inward-direction to shape.
    [u,v] = TotalFlow( controlPoints, lambda, flowFieldFnHandle, midpoints(i,:));
    PressureForce(i,:) = -((stagPressure - 0.5* RHO * vecnorm([u,v])^2) * length(i) * THICKNESS) * normals(i,:);
end

%% STEP 4: Total force due to pressure acting at COM
force = sum(PressureForce);

%% STEP 5: Torque due to pressure acting on body







