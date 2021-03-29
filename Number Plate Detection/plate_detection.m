clear all;
close all;
im = imread('Number Plates/image5.jpg'); %Read the image
imshow(im)
imgray = rgb2gray(im); %rgb to grayscale conversion
imbin = imbinarize(imgray); %grayscale to binary conversion
im = edge(imgray, 'prewitt'); %Edge Detection using Prewitt method.
figure, imshow(im)
%Below steps are to find the location of number plate
Iprops=regionprops(im,'BoundingBox','Area', 'Image');
area = Iprops.Area;
count = numel(Iprops);
maxa= area;
boundingBox = Iprops.BoundingBox;

for i=1:count
   if maxa<Iprops(i).Area
       maxa=Iprops(i).Area;
       boundingBox=Iprops(i).BoundingBox;
   end
end  

im = imcrop(imbin, boundingBox);
figure, imshow(im)
im = bwareaopen(~im, 500);
 [h, w] = size(im);
 
figure, imshow(im) %Shows the image of number plate

%Below steps are to identify the letters on number plates
Iprops=regionprops(im,'BoundingBox','Area', 'Image');
count = numel(Iprops);
noPlate=[];

for i=1:count
   ow = length(Iprops(i).Image(1,:));
   oh = length(Iprops(i).Image(:,1));
   if ow<(h/2) && oh>(h/3)
       letter=Letter_Identification(Iprops(i).Image);
       noPlate=[noPlate letter];
   end
end
noPlate