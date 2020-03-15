function [ resu, resv ] = VelocityFreestreamVortices( freestream, gammas, origins, P )
%% VelocityFreestreamVorticies takes a freestream vector, a set of vortex
% strengths, a set of respective vortex origins, and returns the velocity
% that a point P would experience in the corresponding flow field.
resu = freestream(1);
resv = freestream(2);

% assumed that the number of origin points and gammas are equivalent
for i=1:numel(gammas)
    [u, v] = VelocityVortex(gammas(i), origins(i, :), P);
    resu = resu + u;
    resv = resv + v;
end
end

