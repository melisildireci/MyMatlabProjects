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

if length(stats)==3
tta(object,:)=[bc(1);bc(2)];
end

%a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), ' Y: ',num2str(round(bc(2)))));
%b=text(bc(3)+15,bc(2), strcat('X: ', num2str(round(bc(3)), ' Y: ',num2str(round(bc(2))))));
%set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12,'Color', 'yellow');
%set(b, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12,'Color', 'yellow');

end
hold on 
if length(stats)==3
%plot(tta(1:2,1),tta(1:2,2),'b-');
%plot(tta(3:-1:2,1),tta(3:-1:2,2),'r-');
    z=[]; %
x1=tta(1);
y1=tta(1,2);
x2=tta(2);
y2=tta(2,2);
x3=tta(3);
y3=tta(3,2);
    
for i=1:3

    z(end+1)=i;%
    if i>1 %birinci cisim belirleme y küüçük olaný aradýk
        if(tta(i-1:i-1,2)>tta(i:i,2))
            omuz=i;%
            as=find(z==omuz);%
            z(:,as)=[]%
            y1=tta(i:i,2);
            x1=tta(i:i,1);
            
        end
        if(tta(i-1:i-1,1)<tta(i:i,1)) %üçüncü cisim belirleme
            bilek=i;%
            bs=find(z==bilek);%
            z(:,bs)=[]%
            x3=tta(i:i,1);
            y3=tta(i:i,2);
        end
        if i==3%
            c=z()
            y2=tta(c:c,2);
            x2=tta(c:c,1);
            w=plot([x1;x2],[y1;y2],'b-');
            set(w,'LineWidth',10);
            t=plot([x2;x3],[y2;y3],'r-');
            set(t,'LineWidth',10);
        end
         Line_1 = [x2,y2,0] - [x1,y1,0];
         Line_2 = [x3,y3,0] - [x1,y1,0];
         Theta = atan2d(norm(cross(Line_1, Line_2)), dot(Line_1, Line_2));
         Theta= 180-Theta;
         if (Theta<=130)
             
             Theta= Theta-10;
         end
         %theta = Theta *(180/pi);
         %disp(Theta);
         %interString=sprintf("(%1.0f) degrees",Theta);
         %text(Line_1-10, Line_2+20 , interString, Color== 'r', FontSize==14, FontWeight=='bold');
         %text(x2-60,y2-30,[sprintf("%1.3f",Theta),"{\circ}"],Color=="y",FontSize==14,FontWeight=="bold");
%          a=text(tta(c:c,1),tta(c:c,2)+30,[sprintf("%1.3f",Theta),"{\circ}"],Color=="y",FontSize==14,FontWeight=="bold" );
%          set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12,'Color', 'yellow');
% ix= x2;
% iy=y2;
            c=z()
            y2=tta(c:c,2);
            x2=tta(c:c,1);
str = ['angle  = ',num2str(Theta)];
text(x2,y2, str,'HorizontalAlignment','right','FontSize',20);
        % Draw an "X" at the point of intersection
%         plot(inter_x,inter_y,"yx","LineWidth",2);
% 
%         text(inter_x-60,inter_y-30,[sprintf("%1.0f",theta),"{\circ}"], 'FontWeight', 'bold', 'FontSize', 12);
% 
%         interString = sprintf("(%2.1f,%2.1f)",inter_x,inter_y);
% 
%         text(inter_x-10, inter_y+20, interString,'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12,'Color', 'yellow');
    end
    
    
end
end
hold off
end
stop(vid);
flushdata(vid);