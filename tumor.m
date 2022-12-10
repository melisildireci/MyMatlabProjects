clc;
clear all;
close all;


%% 1
I= imread('brain.png');
imshow(I);

%% 2 
inp = imdiffusefilt(I);

inp = uint8(inp);
inpyeni= imresize(inp,[256 256]);

figure;
imshow(inpyeni);
title('Filtered image','FontSize',20);

%% 3 tresholding

inpyeni_t = im2bw(inpyeni, 0.1);
imshow(inpyeni_t);


%% 4
label = bwlabel(inpyeni_t) % bwlabel iþlemi ile baðlý bileþenlerin (bozuk paralar) bilgileri bir deðiþkene atanýr.
stats = regionprops(inpyeni_t , 'Solidity' , 'Area', 'BoundingBox');
density=[stats.Solidity];
area=[stats.Area];
high_dense_area=density>0.6;
max_area=max(area(high_dense_area));
tumor_label=find(area==max_area);
tumor=ismember(label,tumor_label);


if max_area>100
   figure;
   imshow(tumor)
   title('tumor alone','FontSize',20);
else
    h = msgbox('No Tumor!!','status');
    %disp('no tumor');
    return;
end


%% 5
box = stats(tumor_label);
wantedBox = box.BoundingBox;
figure
imshow(inp);
title('Bounding Box','FontSize',20);
hold on;
rectangle('Position',wantedBox,'EdgeColor','y');
hold off;

