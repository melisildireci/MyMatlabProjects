clc
clear all
close all
warning off;
I=(imread('fingerprint.jpg'));
imshow(I);
title('Original Image');


SE = strel('disk',5);

%% closing yöntemi
c = imclose(I,SE);
figure;
imshow(c);


%% dilate
e =imdilate(I,SE);
figure;
imshow(e);



%% erode


erosion= imerode(I,SE);
figure;
imshow(erosion);






%% B=imopen(I,SE);
figure;
imshow(B);
title('Image After Opening');