% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	MPOV - uloha 6 - defektoskopie
%
%	- program otevre kameru a v nekonecne smycce while sbira snimky dokud
%     neni stisknuta klavesa Esc
%   - upravte program tak, aby na sejmutem snimku nalezl lahev, zobrazil
%     vektory b1 a b2 a zaroven osu lahve
%	
%	verze: 9-2015 / midas.uamt.feec.vutbr.cz
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function ex06_uloha()

%% uklid
clear all;
close all;
clc;

%% kamera
imaqreset;
pause(2);
kam = videoinput('winvideo',1);
kam.ReturnedColorSpace = 'grayscale';
triggerconfig(kam,'manual');
param = getselectedsource(kam);
param.ExposureMode = 'manual';
param.Exposure = -10;
param.Gain = 260;

%% parametry
global AppRunning;
AppRunning = 1;

%% rozhrani
ScreenSize = get(0,'ScreenSize');
figure('Position',[10 10 ScreenSize(3)-20 ScreenSize(4)-100],'Color',[0.3 0.3 0.3],'KeyPressFcn',@MyKeyPressed);
hold on;

%% smycka zpracovani obrazu
start(kam);
pause(1);
while (AppRunning == 1)
    %% porizeni snimku
    img = getsnapshot(kam);
    %img = flipud(img(1:2:end,1:2:end));
    [SY, SX] = size(img);
    SY = uint16(SY);
    SX = uint16(SX);
    
       
    % Read the original image
    % Convert to grayscale if necessary
    if size(img, 3) == 3
        img_gray = rgb2gray(img);
    else
        img_gray = img;
    end
    % Specify xmin and xmax positions
    xmin = 700; % Updated xmin position
    xmax = 1100; % Updated xmax position
    % Define the step size for drawing vertical lines
    step = 10;
    all_left_points = cell(1, floor((xmax - xmin) / step) + 1);
    all_right_points = cell(1, floor((xmax - xmin) / step) + 1);

    conv_mask = [1 1 1 0 -1 -1 -1];
    % Draw additional vertical lines with a step size of 10 pixels
    edgesID = 1;
    for x = xmin:step:xmax
        convolution = conv(double(img_gray(:,x)), conv_mask, 'same');
        [minV, minI] = min(convolution);
        [maxV, maxI] = max(convolution);
        b1(:,edgesID) = [minI, x];
        b2(:,edgesID) = [maxI, x];
        % Find edges for the current vertical line
        edgesID = edgesID+1;
    end
    % Display b1 and b2

   
    
    %% vykresleni vysledku
    imshow(img), title(['Osa lahve [',num2str(SX),'x',num2str(SY),'], Esc = Exit'],'Color',[1 1 0],'FontSize',16);
    
    %figure;
    %imshow(img_gray);
    hold on;
    for i = 1:length(b1)
        if ~isempty(b1(:,i))
            plot(b1(2, i), b1(1, i), 'go', 'MarkerSize', 5); % Green for b1
        end
        if ~isempty(b2(:,i))
            plot(b2(2, i), b2(1, i), 'bo', 'MarkerSize', 5); % Blue for b2
        end
        mid_val(i) = b1(1,i) + (b2(1,i)-b1(1,i))/2;
    end
    P = polyfit(xmin:step:xmax, mid_val, 1);
    x_line = 0:step:1280;
    y_line = P(1)*x_line + P(2);
    plot(x_line, y_line);
    title('Intersections: Green (b1) and Blue (b2)');
    hold off;
    pause(5);
    
    %% priprava dalsi iterace
    pause(0.1);
end;
stop(kam);
close all;


function MyKeyPressed(src, event) %#ok<INUSL>
%% stisk klavesy
global AppRunning;
switch event.Key
    case 'escape'
        AppRunning = 0;
end;