% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	MPOV - uloha 1a - spektralni charakteristiky	
%
%
%	- soubor generuje na obrazovku obrazec Red, Green, Blue, Cyan,
%	  Magenta, Yellow, Black, White	
%	- ukazka vystupu je v souboru ostatni/vzor.bmp	
%
%	
%	verze: 9-2015 / midas.uamt.feec.vutbr.cz
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


close all
clear all
clc

height = 100;
width = 100;

% RED
r = 0; c = 0; %r = row, c = column
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),1) = 255;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),2) = 0;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),3) = 0;

% GREEN
r = 0; c = 1;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),1) = 0;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),2) = 255;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),3) = 0;

% BLUE
r = 0; c = 2;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),1) = 0;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),2) = 0;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),3) = 255;

% CYAN
r = 1; c = 0;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),1) = 0;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),2) = 255;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),3) = 255;

% MAGENTA
r = 1; c = 1;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),1) = 255;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),2) = 0;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),3) = 255;

% YELLOW
r = 1; c = 2;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),1) = 255;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),2) = 255;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),3) = 0;

% BLACK
r = 2; c = 0;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),1) = 0;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),2) = 0;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),3) = 0;

% WHITE
r = 2; c = 1;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),1) = 255;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),2) = 255;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),3) = 255;

% BLACK
r = 2; c = 2;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),1) = 0;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),2) = 0;
img((r*height + 1):((r+1)*height),(c*width + 1):((c+1)*width),3) = 0;



% vykresli vystup

figure;
imshow(img);