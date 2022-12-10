%% clean
clc;
clear all;
close all;
%% first
vid = videoinput('winvideo',2); %ana kamera

% This sets the properties of the video object
set(vid, 'FramesPerTrigger', Inf); %videomuzu set yapmamýz lazým 
set(vid, 'ReturnedColorspace', 'rgb'); %rgb olarak okuyoruz
vid.FrameGrabInterval = 5;

start(vid);

%% second
while(vid.FramesAcquired<=100) %200 frame da devam edecek

% Get the snapshot of the current frame
data = getsnapshot(vid); %her frame okuduktan sonra resme çevirmek için ss gibi


Igray = rgb2gray(data);
BW = edge(Igray,'canny');
% We can see that the image is noisy. We will clean it up with a few
% morphological operations
Ibw = im2bw(Igray); 
se = strel('line',1,100);
cleanI = imdilate(~Ibw,se);
figure, imshow(cleanI);
 %Perform a Hough Transform on the image 
% The Hough Transform identifies lines in an image 
[H,theta,rho] = hough(cleanI);
peaks  = houghpeaks(H,10);
lines = houghlines(Ibw,theta,rho,peaks);
% Highlight (by changing color) the lines found by MATLAB
hold on
for k = 1:numel(lines)
    x1 = lines(k).point1(1);
    y1 = lines(k).point1(2);
    x2 = lines(k).point2(1);
    y2 = lines(k).point2(2);
    plot([x1 x2],[y1 y2],'Color','g','LineWidth', 2)
end
hold off
% Identify the angles of the lines. 
% The following command shows the angle of the 2nd line found by the Hough
% Transform
lines(1).theta
lines(2).theta
end
stop(vid);
flushdata(vid);
