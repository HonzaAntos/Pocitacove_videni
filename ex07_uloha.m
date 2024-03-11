% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	MPOV - uloha 7 - kalibrace mikroskopu	
%
%
%	- program otevre komunikaci s kamerou, sejme obraz horizontalnich
%	  a vertikalnich car, vypocte fyzickou velikost pixelu.
%	- aplikaci rozsirte o moznost ziskat dva body kliknute uzivatelem
%	  (funkce ginput) a zmerte tuto realnou velikost v mm	
%
%	
%	verze: 9-2023 / midas.uamt.feec.vutbr.cz
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% uklid
clear all;
close all;
clc;

% kamera
imaqreset;
pause(2);
kam = videoinput('dcam', 1, 'Y8_1024x768');
triggerconfig(kam,'manual');
param = getselectedsource(kam);
param.ShutterControl = 'absolute';
param.GainMode = 'manual';
param.Gain = 500;
param.AutoExposure = 800;
pocet_car = 5;
pocet_car_v_mm = 2.5;
% nahled videa pro nastaveni
preview(kam);
pause(1);
pause;
closepreview(kam);
pause(1);

% ZACNETE PROGRAMOVAT ZDE >>>
% ... doplnte program tak, aby sejmul obraz s kalibracnimi
% carami vertikalnimi a horizontalnimi, vypoctete dalsi udaje

% ... porizeni snimku
for l=1:2
img = getsnapshot(kam);
% ... podvzorkovani
img = img(1:2:end,1:2:end,:);
% ... vyrez obrazu s carami
vyber = ex07_vyber(img);
% ... zobrazeni vyberu
imshow(vyber)
BW = edge(vyber, 'roberts', 0.05);


[H, Thetha, Rho] = hough(BW);
P = houghpeaks(H,pocet_car*2);
imshow(imadjust(rescale(H)),'XData',Thetha,'YData',Rho,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
plot(Thetha(P(:,2)),Rho(P(:,1)),'s','color','red');
hold off
Psort = sort(P(:,1), 'ascend');
j = 1;
k = 1;
for i=1:length(Psort)-1
    line_l(i) = Psort(i+1) - Psort(i);
end

line_l_avg = mean(line_l);
mm_in_px(l) = (1/(pocet_car_v_mm * 2))/line_l_avg;
end

img = getsnapshot(kam);
% ... podvzorkovani
img = img(1:2:end,1:2:end,:);
% ... vyrez obrazu s carami
vyber = ex07_vyber(img);
% ... zobrazeni vyberu
imshow(vyber)
distance = (sqrt((length(vyber(:,1)) * mm_in_px(1))^2 + (length(vyber(1,:)) * mm_in_px(2))^2));

%ukonecni kamery
stop(kam);
delete(kam);
