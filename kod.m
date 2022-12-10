clc;
clear all;
close all;

vid = videoinput('winvideo');

% This sets the properties of the video object
set(vid, 'FramesPerTrigger', Inf);
set(vid, 'ReturnedColorspace', 'rgb');
vid.FrameGrabInterval = 5;

%start the video aquisition here
start(vid)

while(vid.FramesAcquired<=200)

% Get the snapshot of the current frame
data = getsnapshot(vid);

% Now to track green objects in real time
% we have to subtract the red component
% from the grayscale image to extract the red components in the image.
diff_im1 = imsubtract(data(:,:,1), rgb2gray(data));
%Use a median filter to filter out noise
diff_im1 = medfilt2(diff_im1, [3 3]);


% Convert the resulting grayscale image into a binary image.
diff_im1 = im2bw(diff_im1,0.18);

% Remove all those pixels less than 300px
diff_im1 = bwareaopen(diff_im1,300);
% Label all the connected components in the image.
bw =bwlabel(diff_im1, 8);
% bw =bwlabel(diff_im, 8);

% Here we do the image blob analysis.
% We get a set of properties for each labeled region.
stats = regionprops(bw, 'BoundingBox', 'Centroid');
% Display the image
imshow(data)

hold on
%This is a loop to bound the red objects in a rectangular box.
for object = 1:length(stats)
bb = stats(object).BoundingBox;
bc = stats(object).Centroid;
rectangle('Position',bb,'EdgeColor','r','LineWidth',3)
% rectangle('Position',pos,'EdgeColor','r',Curvative',[1 1])
plot(bc(1),bc(2), '-m+')
plot(bc(3),bc(2), '-m+')

tta(object,:)=[bc(1);bc(2)];
tta(object,:)=[bc(3);bc(2)];


a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), ' Y: ',num2str(round(bc(2)))));
b=text(bc(3)+15,bc(2), strcat('X: ', num2str(round(bc(3)), ' Y: ',num2str(round(bc(2))))));
set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12,'Color', 'yellow');
set(b, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12,'Color', 'yellow');

end
hold on 
if length(stats)>1
plot(tta(1:2,1),tta(1:2,2),'b-');
plot(tta(1:2,3),tta(1:2,2),'b-');

end
hold off
end




%Line_1 = [x2,y2,0] - [x1,y1,0];
%Line_2 = [x3,y3,0] - [x1,y1,0];
%Theta = atan2d(norm(cross(Line_1, Line_2)), dot(Line_1, Line_2));