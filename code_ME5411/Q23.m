%% course 5411 Q2-Q3
clc;
clear;
close all;
%% Q2 apply averaging filters to the image
%% display original image
% input the image
img = imread('charact2.bmp');
%% Gray-Scale Transformation
img_mono = rgb2gray(img); % transform into monochrome image
colormap(gray); % set colormap
figure(1)
subplot(2,2,1);
imshow(img_mono);
title('Monochrome Image');
%% use average filter
img3 = avg_filter(img_mono,3);
img5 = avg_filter(img_mono,5);
img7 = avg_filter(img_mono,7);
%% show the images
subplot(2,2,2);
imshow(uint8(img3));
title('3*3 Averaging');
subplot(2,2,3);
imshow(uint8(img5));
title('5*5 Averaging');
subplot(2,2,4);
imshow(uint8(img7));
title('7*7 Averaging');
%% Q3 high-pass filter in frequency domain
% use ideal high-pass filter
% filter size is larger than original image to avoid confounding effects
[row, col] = size(img_mono); 
u = -row:row-1; %filter row: row*2
v = -col:col-1; %filter col: col*2
[U,V] = meshgrid(v,u); % matrix U,V are (#u dim)*(#v dim), U each row is u, V each column is v
D = sqrt(U.^2+V.^2); % D(i,j) is the distance between (u(i),v(j)) and the centre
%% set up high-pass filter
D0 = 10; % set cut-off frequency
H = double(D>D0); % ideal high-pass filter
%% Frourier Transformation
img_FT = fft2(img_mono, size(H,1),size(H,2)); % FFT,expand the image to the size of filter
img_FT = fftshift(img_FT); % shift zero frequency to the center
%% Apply the filter
img_HPF = img_FT .* H;
%% inverse FFT
img_HP = ifft2(ifftshift(img_HPF));
img_HP = real(img_HP);
%% shrink into original image size
img_HP = img_HP(1:row,1:col);
%% show the result of high-pass filtering
figure(2)
% show monochrome image
subplot(2,2,1);
imshow(img_mono);
title('Monochrome Image');
% show monochrome image after hign-pass filtering
subplot(2,2,2);
imshow(img_HP);
title('Monochrome Image after High-Pass Filtering');
% show frequency domain of monochrome image
subplot(223);
imagesc(log(1 + abs(img_FT)));
title('Frequency Domain of Monochrome Image');
% show frequency domain of monochrome image after hign-pass filtering
subplot(224);
imagesc(log(1 + abs(img_HPF)));
title('Frequency Domain of Monochrome Image after High-Pass Filtering');
%% Comparison of Spatial and Frequency domain methods
figure(3)
subplot(3,1,1);
imshow(img_mono);
title('Monochrome Image');
subplot(3,1,2);
imshow(uint8(img5));
title('Spatial Domain Method (5*5 Averaging)');
subplot(3,1,3);
imshow(img_HP);
title('Frequency Domain Method');

