% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	MPOV - uloha 9 - klasifikace objektu	
%
%
%	- otevre komunikaci s pripojenou kamerou
%	- naprogramujte segmentaci, popis a klasifikaci spojovaciho materialu
%
%	
%	verze: 9-2021 / vision.uamt.feec.vutbr.cz
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% uklid
clear all;
close all;
clc;

%% kamera
imaqreset;
pause(2);
kam = videoinput('winvideo',1);
kam.ReturnedColorSpace = 'rgb';
triggerconfig(kam,'manual');
param = getselectedsource(kam);
param.ExposureMode = 'manual';
param.Exposure = -5;
param.GainMode = 'manual';
param.Gain = 16;
param.WhiteBalanceMode = 'manual';
param.WhiteBalance = 5000;

% nahled videa pro nastaveni            
preview(kam);
pause(1);
pause;
closepreview(kam);
pause(1);

% ZACNETE PROGRAMOVAT ZDE >>>
% ... doplnte/upravte program tak, aby klasifikoval objekty do kategorii 

% ... porizeni snimku
imgRGB = getsnapshot(kam);

% zvolte si vhodny barevny model/slozku modelu pro segmentaci, napr.: HSV
% vytvorte binarni obraz, kde objekty jsou bile a pozadi cerne, napr.:
% H S B
upperlimit = [1,1,1];
lowerlimit = [0.8,0.5,0.1];
imgHSV = rgb2hsv(imgRGB);


figure(20)
plot(imhist(imgHSV))



hsvSegm = ~imbinarize(imgHSV(:,:,2));
se = strel(5);
imgBW_bwa = bwareaopen(hsvSegm, 100);
img_seg  = imfill(imgBW_bwa,'holes');
img_seg  = imclose(img_seg,se);
figure(1)
imshow(img_seg)


% u jednotlivych indexovanych objektu urcete vhodne parametry (priznaky)
% viz help regionprops
regs = regionprops(img_seg, 'Centroid', 'MajorAxisLength', 'PixelIdxList');

figure(2)
subplot(1, 2, 1); imshow(img_seg);
subplot(1, 2, 2); imshow(imgRGB);


% kategorie objektu
categories = [{'vrut kratky'} {'vrut dlouhy'} {'sroub kratky'} {'sroub dlouhy'} {'matka mala cerna'} {'matka male pozink'} {'matka velka'} {'podlozka'}];

% cyklus pres jednotlive objekty 
for i = [1 : length(regs)]
    % zobrazeni indexu objektu
    if(length(regs(i).PixelIdxList) > 1000)
        x = regs(i).Centroid(1);
        y = regs(i).Centroid(2);
        subplot(1, 2, 1); text(x, y, sprintf('%d', i), 'Color', 'g');
        
        % muzete si dopocitat i dalsi pomocne priznaky:

        cat = '.';

        % zde doplnte navrzeny klasifikator, napr. podminky s limitnimi
        % hodnotamy priznaku; snazte se vse navrhovat co nejrobustneji
        if(regs(i).MajorAxisLength > 200)
            cat = 'velky sroub'; % nebo cat = categories(x);
        end
         if(regs(i).MajorAxisLength > 58 && regs(i).MajorAxisLength < 70)
             cat = 'matka velka'; % nebo cat = categories(x);
         end
            if(regs(i).MajorAxisLength > 58 && regs(i).MajorAxisLength < 70)
             cat = 'matka velka nebo podlozka'; % nebo cat = categories(x);
         end
         if(regs(i).MajorAxisLength > 100 && regs(i).MajorAxisLength < 130)
            cat = 'maly sroub'; % nebo cat = categories(x);
         end
         if(regs(i).MajorAxisLength > 131 && regs(i).MajorAxisLength < 200)
            cat = 'vrut'; % nebo cat = categories(x);
         end
         if(regs(i).MajorAxisLength > 38 && regs(i).MajorAxisLength < 52)
             cat = 'matka mala nebo podlozka'; % nebo cat = categories(x);
         end% vypsani urcenych kategorii
        subplot(1, 2, 2);   text(x, y,  cat, 'Color', 'g');

        % vsechny sledovane informace (i vami urcene) o objektech si muzete 
        % zobrazit vedle struktury regs v pomocne strukture regs_params
        regs_params(i) = struct('Id', i, 'Category', cat);
    end
 end
  
