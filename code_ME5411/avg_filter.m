function [im_out] = avg_filter(im,filter_size)
% create a average filter
mean_filter = ones(filter_size)/(filter_size^2);
% applt the filter
im_out = conv2(im,mean_filter,'same');
im_out = uint8(im_out);