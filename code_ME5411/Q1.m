%% course me5411 Q1
clc;
clear;
close all;
%% Q1 contrast enhancement
%% Q1.1 display original image
% read the image
img = imread('charact2.bmp');
% display the image in figure 1
figure(1);
subplot(3,2,1);
imshow(img);
axis image;
% add title
title('Original Image');
%% Q1.2 contrast enhancement
%% Q1.2.1 Gray-Scale Transformation
img_mono = rgb2gray(img); % transform into monochrome images
colormap(gray); % set colormap
subplot(3,2,2);
imshow(img_mono);
title('Monochrome Image');
%% Q1.2.1.1 Negative Transformation
L = 256;
img_NT = L - 1 - img_mono; %negative transformation
subplot(3,2,3);
imshow(img_NT);
title('Monochrome Image after Negative Transformation')
%% Q1.2.1.2 Contrast Stretching
% use a piecewise linear function to do contrast stretching
[row, col] = size(img_mono); 
img_CS = zeros(size(img_mono)); % new a image
for i = 1:row
    for j = 1:col
        if img_mono(i,j) < 64 %pixel intesity between [0,64)
            img_CS(i,j) = 0.5 * img_mono(i,j);
        elseif img_mono(i,j) <192 %pixel intesity between [64,192)
            img_CS(i,j) = 32 + 1.5 * (img_mono(i,j) - 32);
        else %pixel intesity between [192,255]
            img_CS(i,j) = 224 + 0.5 * (img_mono(i,j) - 192);
        end
    end
end
subplot(3,2,4);
imshow(uint8(img_CS));
title('Monochrome Image after Contrast Stretching')
%% Q1.2.2 Histogram Equalization
img_HE = hist_eq(img_mono);
subplot(3,2,5);
imshow(img_HE);
title('Monochrome Image after Histogram Equalization');
%% Q1.2.3 Geometric Transformations
% Too many methods for geometric transformation
% Choose linear interpolation here
scale = 1.5; % choose a suitable scale factor
newrow = round(row * scale);
newcol = round(col * scale);
img_GT = zeros(newrow,newcol);

% bi-linear interpolation
for i = 1:newrow
    for j = 1:newcol
        % check the original position
        xo = i/scale;
        yo = j/scale;
        % find the near four points
        x1 = max(floor(xo),1);
        y1 = max(floor(yo),1);
        x2 = min(x1+1,row); % to avoid overflow
        y2 = min(y1+1,col);
        % interpolation weight
        a = xo - x1;
        b = yo - y1;
        % bi-linear interpolation function
        img_GT(i,j) = (1-a) * (1-b) * img_mono(x1,y1) + a * (1-b) * img_mono(x2,y1) + b * (1-a) * img_mono(x1,y2) + a * b * img_mono(x2,y2);
    end
end
img_GT = uint8(img_GT);
subplot(3,2,6);
imshow(img_GT);
title('Monochrome Image after Geometric Transformation');