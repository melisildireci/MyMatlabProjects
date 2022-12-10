clc;
clear all;
close all;



%% whitenoise olusturalým
a = randi(255, 1000,1000);
b = double(a);
ort = 0
for t = 1:1000000
    ort = ort+b(t);
end
b = uint8(b);
imshow(b, [1000,1000]);
ort = round(ort/1000000);
ort


