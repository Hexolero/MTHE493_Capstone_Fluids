function [ beta ] = BetaFromAlpha( alpha )
%% BetaFromAlpha for now, test.

% Algorithm is as follows:
% 1. choose beta_0 somehow
% 2. beta_k = 2(alpha_k - alpha_(k-1)) - beta_(k-1)

beta = zeros(size(alpha));
% the best starting point, assuming that our lambdas are likely continuous.
beta(1) = 2 * (alpha(2) - alpha(1));
% beta(1) currently 0
for k=2:numel(beta)
    beta(k) = 2*(alpha(k) - alpha(k-1)) - beta(k-1); 
end

% TEST/PLOTTING CODE

%lambda = [zeros(size(alpha)) 0];
%for k=1:numel(beta)
%    lambda(k) = alpha(k) - beta(k) / 2;
%end
%lambda(numel(lambda)) = beta(numel(beta)) + lambda(numel(lambda) - 1);
% figure
% hold on;
% plot(1:numel(lambda), lambda);
% ar = 1:numel(alpha);
% ar = ar + 1/2;
% br = ar;
% plot(ar, alpha);
% plot(br, beta);
