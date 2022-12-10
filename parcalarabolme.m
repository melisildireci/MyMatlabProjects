clear all;
close all;
clc;


%% RESMÝ PARÇALARA BÖLMEEEE

griGoruntu=imread('tire.tif');
 

 
parca1 = imcrop(griGoruntu,[0 0 480 180]);
 
parca2 = imcrop(griGoruntu,[0 180 480 360]);
 
figure,imshow(parca1);
 
figure,imshow(parca2);



%% 2.yol


Image = imread('peppers.png');
[Image_Height,Image_Width,Number_Of_Colour_Channels] = size(Image);

Block_Size = 50;
Number_Of_Blocks_Vertically = ceil(Image_Height/Block_Size);
Number_Of_Blocks_Horizontally = ceil(Image_Width/Block_Size);
Image_Blocks = struct('Blocks',[]);

Index = 1;
for Row = 1: +Block_Size: Number_Of_Blocks_Vertically*Block_Size
    for Column = 1: +Block_Size: Number_Of_Blocks_Horizontally*Block_Size
        
    Row_End = Row + Block_Size - 1;
    Column_End = Column + Block_Size - 1;
        
    if Row_End > Image_Height
       Row_End = Image_Height;
    end
    
    if Column_End > Image_Width
       Column_End = Image_Width;
    end
    
    Temporary_Tile = Image(Row:Row_End,Column:Column_End,:);
    
    %Storing blocks/tiles in structure for later use%
    Image_Blocks(Index).Blocks = Temporary_Tile;
    subplot(Number_Of_Blocks_Vertically,Number_Of_Blocks_Horizontally,Index); imshow(Temporary_Tile);
    Index = Index + 1;
    
    end  
end
