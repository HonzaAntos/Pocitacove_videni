% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	MPOV - uloha 1c - spektralni charakteristiky
%
%
%	- otevre komunikaci s pripojenou kamerou
%
%	
%	verze: 9-2023 / vision.uamt.feec.vutbr.cz
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% uklid
clear all;
close all;
clc;

% kamera
imaqreset;
pause(2);
kam = videoinput('winvideo',1);
kam.ReturnedColorSpace = 'rgb';
%kam.ReturnedColorSpace = 'grayscale';
triggerconfig(kam,'manual');
param = getselectedsource(kam);
param.ExposureMode = 'manual';
param.Exposure = -6;
param.Gain = 800;

% nahled videa pro nastaveni
preview(kam);
pause(1);
pause;
closepreview(kam);
pause(1);

figure
img = getsnapshot(kam);
subplot(2,3,1); imshow(img);
subplot(2,3,2); imshow(rgb2hsv(img));
subplot(2,3,3); imshow(rgb2gray(img));
subplot(2,3,4); imshow(img(:,:,1));
subplot(2,3,5); imshow(img(:,:,2));
subplot(2,3,6); imshow(img(:,:,3));
