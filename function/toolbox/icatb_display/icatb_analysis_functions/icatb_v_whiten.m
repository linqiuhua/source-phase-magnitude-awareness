function [newVectors, whiteningMatrix, dewhiteningMatrix] = icatb_v_whiten(data, V, Lambda, doTranspose);
% [newVectors, whiteningMatrix, dewhiteningMatrix] = icatb_v_whiten(data, V, Lambda);


if exist('doTranspose', 'var')
    if strcmp(doTranspose, 'transpose')
        data = data';
    end
end

% Calculate the whitening and dewhitening matrices (these handle
% dimensionality simultaneously).
%whiteningMatrix = inv(sqrtm(Lambda))* V';
% lm = real(sqrtm(Lambda)); for n=1:length(lm);  if lm(n,n)<1e-50, lm(n,n) = imag(sqrtm(Lambda(n,n))); end, end
whiteningMatrix = real(sqrtm(Lambda)) \ V'; % Use gaussian elimination approach to solve the equations
dewhiteningMatrix = V * sqrtm(Lambda);

% Project to the eigenvectors of the covariance matrix.
% Whiten the samples and reduce dimension simultaneously.
fprintf('Whitening...\n');

%newVectors =  whiteningMatrix*data;
newVectors = data * whiteningMatrix.';
dewhiteningMatrix = (pinv(whiteningMatrix.')).';
newVectors = newVectors.';
