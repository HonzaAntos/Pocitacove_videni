% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	MPOV - uloha 5 - ostreni objektivu	
%
%
%	- otevre komunikaci s pripojenou kamerou, otevre komunikaci
%	  se zarizenim CanonEF po seriove lince
%	- naprogramujte automaticke ostreni pomoci hledani globalniho
%	  maxima jakosti obrazu	
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
kam.ReturnedColorSpace = 'grayscale';
triggerconfig(kam,'manual');
param = getselectedsource(kam);
param.ExposureMode = 'manual';
param.Exposure = -2;
param.GainMode = 'manual';
param.Gain = 200;

% nahled videa pro nastaveni
preview(kam);
pause(1);
pause;
closepreview(kam);
pause(1);


% ZACNETE PROGRAMOVAT ZDE >>>
% ... doplnte otevreni seriove linky
s = serial('COM3');
fopen(s);
% smycka zpracovani obrazu
figure, hold on;
start(kam);
% ZACNETE PROGRAMOVAT ZDE >>>
% ... upravte pocet kroku
lfpVal = 4;
outpMatrix = cell(10,1);

for n = 1:10
    lfpString = "lfp" + num2str(dec2hex(lfpVal, 4));
    fprintf(s, '\002x%s\003x', lfpString);
    lfpVal = lfpVal + 102;
    pause(3);
    % ... nastaveni zaostreni - doplnte...
    
    % porizeni snimku
    img = getsnapshot(kam);
    % ... podvzorkovani
    img = img(1:4:end,1:4:end,:);
    % vykresleni vysledku
    imshow(img);
    outpMatrix{n} = img;
    pause(0.1);
    img = im2double(img);
    middle = length(img(:,1))/2;
    for j=1:50
        jIndex = j - 25;
        k = 1;
        for i=1:length(img(1,:))-7
            minMax(k) = img(middle+jIndex,i:i+6) * [-1,-1,-1,0,1,1,1]';
            k = k+1;
        end
        locMax(n,j) = max(minMax);
        locMin(n,j) = min(minMax);
    end
    % ... vyhodnoceni ostrosti/jakosti obrazu - doplnte...
    globMinMax(n) = abs(max(locMax(n,:))) + abs(min(locMin(n,:)));
end
figure(2);
plot(globMinMax);
[M,I] = max(globMinMax);
lfpVal = 4 + 102 * I-1;
lfpString = "lfp" + num2str(dec2hex(lfpVal, 4));
fprintf(s, '\002x%s\003x', lfpString);
pause(3);
imgO = getsnapshot(kam);
figure(3)
imshow(imgO);
% ZACNETE PROGRAMOVAT ZDE >>>
% ... vykreslete prubeh ostrosti/jakosti obrazu
% ... zaostrete na globalni maximum
% ... uzavrete seriovou linku


% uzavreni kamery
fclose(s);
stop(kam);
delete(kam);