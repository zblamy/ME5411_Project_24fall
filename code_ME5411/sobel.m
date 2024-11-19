%% use sobel operator to detect edges
function [im_out] = sobel(im,gradient_threshold)
% gradient_threshold is the threshold to detect edge, should be suitable
% sobel operator provides both a differencing and a smoothing effect
% sobel operator can change according to different need
% 3*3 sobel operator
sobel_x = [-1 -2 -1; 0 0 0; 1 2 1];
% 5*5 sobel operator
% sobel_x = [1 2 0 -2 -1;
%            4 8 0 -8 -4;
%            6 12 0 -12 -6;
%            4 8 0 -8 -4;
%            1 2 0 -2 -1];
sobel_y = sobel_x';
% apply the operator to detect edges in different directions
gradient_x = conv2(im,sobel_x,'same');
gradient_y = conv2(im,sobel_y,'same');
% calculate total gradient
gradient = sqrt(gradient_x.^2+gradient_y.^2);
% normalize gradients into range [0,1]
gradient = gradient/max(gradient(:));
% get the edges
im_out = gradient > gradient_threshold;