%% histogram equalization
function [im_out, H, Hc, T] = hist_eq(im)
% input: im [m*n] image
% output: im_out [m*n] equalized image
% H:[1*256] histogram of input image
% Hc: [1*256] cumulative histogram of the input function
% T: [1*256] transformation function of the intensity

%assume gray level of 255
levels = 256;

%index start from 1 instead of 0
imp = uint8(im) + 1;

%histogram of input image
H = zeros(1,levels);
for i = 1:size(im,1)
    for j = 1:size(im,2)
        H(imp(i,j)) = H(imp(i,j)) + 1;
    end
end
%% form the cumulative image histogram Hc
Hc = zeros(size(H));
Hc(1) = H(1);
for i = 2:size(Hc,2)
    Hc(i) = Hc(i-1) + H(i);
end
%% create look-up table normalizing the cumulative histogram to have integer
T = round((levels-1)/(size(im,1)*size(im,2))*Hc);
%% apply the look-up table to each level in the input and write a new image
im_out = zeros(size(im));
im_out = T(imp);
%% convert the pixels of the output image into unsigned 8-bit integers
im_out = uint8(im_out);
