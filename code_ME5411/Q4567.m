%% course 5411 Q4-Q7
clc;
clear;
close all;
%% Get gray-scale image
img = imread('charact2.bmp');
img_mono = rgb2gray(img); % transform into monochrome image
%% Q4: Create a sub-image that includes the middle line – HD44780A00
% Divide the image into two parts
[height, width] = size(img_mono);
img_sub = img_mono(round(height/2):height,1:width);
% imwrite(img_sub, 'img_sub.bmp');  % save as *.bmp
figure(1);
subplot(2,1,1);
imshow(img_sub);
title("Sub-image");
%% Q5 Convert the sub-image into a binary image
% thresholding
img_bi = zeros(size(img_sub));
[row,col] = size(img_sub);
bar = 120;
for i = 1:row
    for j = 1:col
        if img_sub(i,j) > bar
            img_bi(i,j) = 255;
        else
            img_bi(i,j) = 0;
        end
    end
end
subplot(2,1,2);
imshow(img_bi);
title("Binary Image of Sub-Image");
%% Q6 Determine the outline(s) of characters in the image.
% edge detection
% the effect is too bad without constrast enhancement
img_sub_eq = hist_eq(img_sub);
% compare two operators here
% Laplacian Operator is more sensitive to noise
% Sobel works better in gray scale image(with noise)
% Laplacian works better in binary image
% (with sharp intensity changes and relatively low noise)
%% sobel operator
figure(2);

% choose best threshold 0.15
% edge1 = sobel(img_sub_eq,0.12);
% subplot(6,1,1);
% imshow(edge1);
% edge2 = sobel(img_sub_eq,0.13);
% subplot(6,1,2);
% imshow(edge2);
% edge3 = sobel(img_sub_eq,0.14);
% subplot(6,1,3);
% imshow(edge3);
% edge4 = sobel(img_sub_eq,0.15);
% subplot(6,1,4);
% imshow(edge4);
% edge5 = sobel(img_sub_eq,0.16);
% subplot(6,1,5);
% imshow(edge5);
% edge6 = sobel(img_sub_eq,0.17);
% subplot(6,1,6);
% imshow(edge6);

subplot(2,2,1);
edge1 = sobel(img_sub_eq,0.15);
imshow(edge1);
title('Detect Edge Using Gray Scale Image - Sobel Operator');
%% Laplacian Operator

% choose best threshold 0.07
% edge1 = Laplacian(img_sub_eq,0.06);
% subplot(6,1,1);
% imshow(edge1);
% edge2 = Laplacian(img_sub_eq,0.07);
% subplot(6,1,2);
% imshow(edge2);
% edge3 = Laplacian(img_sub_eq,0.08);
% subplot(6,1,3);
% imshow(edge3);
% edge4 = Laplacian(img_sub_eq,0.09);
% subplot(6,1,4);
% imshow(edge4);
% edge5 = Laplacian(img_sub_eq,0.10);
% subplot(6,1,5);
% imshow(edge5);
% edge6 = Laplacian(img_sub_eq,0.11);
% subplot(6,1,6);
% imshow(edge6);

edge2 = Laplacian(img_sub_eq,0.07);
subplot(2,2,2);
imshow(edge2);
title('Detect Edge Using Gray Scale Image - Laplacian Operator');
%% Detecting edge using binary image
% the threshold doesn't matter for binary image
edge3 = sobel(img_bi,0.1);
edge4 = Laplacian(img_bi,0.1);
subplot(2,2,3);
imshow(edge3);
title('Detect Edge Using Binary Image - Sobel Operator');
subplot(2,2,4);
imshow(edge4);
title('Detect Edge Using Binary Image - Laplacian Operator');
%% Q7
%% erode and dilate to get better effect
img_good = img_bi;
img_good = imerode(img_good,strel('rectangle',[5,1]));
% figure; imshow(img_good);
img_good = imdilate(img_good,strel('disk',3));
% figure; imshow(img_good);
% img_good = imerode(img_good,strel('square',1));
% figure; imshow(img_good);
% img_good = imdilate(img_good,strel('square',2));
% figure; imshow(img_good);
% img_good = imerode(img_good,strel('line',7,90));
% figure; imshow(img_good);
% img_good = imdilate(img_good,strel('disk',2));
% figure; imshow(img_good);
% img_good = imerode(img_good,strel('rectangle',[5,1]));
% figure; imshow(img_good);
% img_good = imdilate(img_good,strel('rectangle',[3,1]));
% figure; imshow(img_good);
%% deal with connected parts via batch point processing
% deal with 80
for i = 1: row
    img_good(i,593) = 0;
end
% deal with 00
for i = 1: row
    img_good(i,855) = 0;
end
% subplot(2,1,2);
% figure;imshow(img_good);
% title('Image without Undesired Connection')
%% delete useless small connected pixel
img_good = bwareaopen(img_good,196);
figure;
% subplot(2,1,1);
imshow(img_good);
% title('Image without Noise')
title('Improved Image');
%%
[label,num] = bwlabel(img_good);
figure;
chars = cell(1,num);
charspro = regionprops(label, 'BoundingBox');
for k=1:num
    kpro = charspro(k).BoundingBox;
    chars{k} = imcrop(img_good,kpro);
    subplot(1,num,k);
    imshow(chars{k});
    title(sprintf('Character No.%d',k));
    % imwrite(~chars{k}, sprintf('Character%d.bmp',k));  % save as *.bmp
end




