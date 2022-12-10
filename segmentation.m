clc;
clear all;
close all;

%% first: reading the image
I = imread('pcb.jpg');
imshow(I);
figure;
[x,y] = size(I);

%% 2
level= 0.5;
bw= im2bw(I, level);
imshow(bw);
figure(1);
imshowpair(I, bw,'montage');

%% ara

bw = imcomplement(bw);
imshow(bw)

%% 3


 
 %% 4
 
se =strel('disk', 0);
bw = imerode(bw, se);
imshow(bw);
figure(4);


%% 5



label= bwlabel(bw);
stats = regionprops(bw, 'Eccentricity', 'Area' , 'BoundingBox');


density=[stats.Eccentricity];
area=[stats.Area];
high_dense_area=density<0.5;
max_area=max(area(high_dense_area));
c_label=find(area==max_area);
lehim=ismember(label,c_label);

if max_area>10
   figure;
   imshow(lehim)
   title(' solder alone','FontSize',20);
else
    h = msgbox('No lehim!!','status');
    %disp('no tumor');
    return;
end


%% 5
box = stats(c_label);
box2= box.BoundingBox;


figure
imshow(bw);
title('Bounding Box','FontSize',20);
hold on;
rectangle('Position',box2,'EdgeColor','y');
hold off;

% idxOfSkittles = find(eccentricities);
% statsDefects = stats(idxOfSkittles);
% 
% figure, imshow(I);
% hold on;
% lenght(idxOfSkittles)= L;
% E = uint8(L);
% 
% for idx = 1:E
%     h = rectangle('Position', box2,  chr);
%     set(h, 'EdgeColor', [.75 0 0 ]);
%     hold on ;
%     
% end
% if idx>10
%     title(['istebuuu!!!!']);
% end
