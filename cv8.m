% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    MPOV - uloha 8a - pasivni triangulace
%
%
%    - kalibrace kamer, zjisteni parametru 
%
%
%    verze: 9-2019 / midas.uamt.feec.vutbr.cz

%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% uklid
clear all;
close all;
clc;

%% index kamery
cam_ID1 = 1;
cam_ID2 = 2;

%% video stream
camera1 = videoinput('winvideo',cam_ID1);
camera1.ReturnedColorSpace = 'grayscale';
prop1  = getselectedsource(camera1);
prop1.ExposureMode = 'manual';
prop1.Exposure = -3;
prop1.Gain = 260;


camera2 = videoinput('winvideo',cam_ID2);
camera2.ReturnedColorSpace = 'grayscale';
prop2  = getselectedsource(camera2);
prop2.ExposureMode = 'manual';
prop2.Exposure = -3;
prop2.Gain = 260;

%% nahledy z kamer

preview(camera1);
preview(camera2);
pause(1);
pause

len = 221.5;
X1 = 55.4;
x_s_carou1 = 640;
f1 = (x_s_carou1/X1)*len;
bx = 29.5;

%% porizeni snimku

img1 = getsnapshot(camera1);

img2 = getsnapshot(camera2);
%     figure(3)
imshow(img1);
%     hold on
%     plot(length(img1(1,:))/2, length(img1(:,1))/2, 'rx', 'MarkerSize', 10);
%     hold off
%     title('Kamera 1')
[x1_points, y1_points] = ginput(12);
%     figure(4)
imshow(img2);
%     hold on
%     plot(length(img2(1,:))/2, length(img2(:,1))/2, 'rx', 'MarkerSize', 10);
%     hold off
%     title('Kamera 2')
[x2_points, y2_points] = ginput(12);

%% ukonceni prace s kamerami
closepreview(camera1);
closepreview(camera2);
figure(5);
k = 1;
for j=1:3
    for i=1:4
        X(k) = x2_points(k)*(bx/(x2_points(k) - x1_points(k)));
        Y(k) = y2_points(k)*(bx/(x2_points(k) - x1_points(k)));
        Z(k) = f1*(bx/(x2_points(k) - x1_points(k)));
        k = k + 1;
    end
    fill3(X(k-4:k-1), Y(k-4:k-1), Z(k-4:k-1),'o');
    hold on
end

vzdal = sqrt((X(8)-X(5))^2 + (Y(8)-Y(5))^2 + (Z(8)-Z(5))^2);


