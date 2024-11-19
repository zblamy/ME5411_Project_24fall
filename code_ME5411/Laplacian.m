%% use sobel operator to detect edges
function [im_out] = Laplacian(im,gradient_threshold)
% gradient_threshold is the threshold to detect edge, should be suitable
% sobel operator provides both a differencing and a smoothing effect
% sobel operator can change according to different need
% 3*3 Laplacian operator
lap =[0 -1 0; -1 4 -1; 0 -1 0];
% apply the operator to detect edges
gradient = conv2(im,lap,'same');
% normalize gradients into range [0,1]
gradient = gradient/max(gradient(:));
% get the edges
im_out = gradient > gradient_threshold;