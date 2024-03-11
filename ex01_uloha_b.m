close all
clear all
clc

% Load the CSV file
data = readmatrix('filter_test.csv');  % Replace 'spectral_data.csv' with your CSV file's path

% Extract wavelength and intensity columns
wavelengths = data(:, 1);
intensity = data(:, 2);

% Find the peaks in the intensity data
[peaks, peak_locs] = findpeaks(intensity, wavelengths);

% Find index of dominant wavelength from dataset
[dominant_intensity, dominant_index] = max(intensity);
dominant_wavelength = wavelengths(dominant_index);

% Find the two points where intensity drops to half of the maximum
half_max_intensity = dominant_intensity / 2;
left_half_max_index = find(intensity(1:dominant_index) <= half_max_intensity, 1, 'last');
right_half_max_index = dominant_index + find(intensity(dominant_index:end) <= half_max_intensity, 1) - 1;

% Calculate the FWHM
FWHM = wavelengths(right_half_max_index) - wavelengths(left_half_max_index);

% Calculate relative asymmetry
a = abs(dominant_index - left_half_max_index);
b = abs(right_half_max_index - dominant_index);
asymmetry = (a - b)/(min(a,b));

% Create the spectral graph
figure;
plot(wavelengths, intensity, 'b', 'LineWidth', 2);
xlabel('Wavelength (nm)');
ylabel('Intensity');
title('Spectral Graph');
grid on;

% Plot the dominant wavelength as a red dot and add vertical red line
hold on;
plot(dominant_wavelength, dominant_intensity, 'ro', 'MarkerSize', 10);
hold on;
xline(dominant_wavelength,'-r');

% Plot the FWHM as a green shaded area
hold on;
fill([wavelengths(left_half_max_index:right_half_max_index), fliplr(wavelengths(left_half_max_index:right_half_max_index))], ...
    [intensity(left_half_max_index:right_half_max_index), fliplr(intensity(left_half_max_index:right_half_max_index))], 'g', 'FaceAlpha', 0.5);

% Add a horizontal line at half the intensity of the dominant wavelength
hold on;
yline(half_max_intensity, '--b', 'Half Max Intensity');

% Add legends
legend('Spectral Data', 'Dominant Wavelength','Dominant Wavelength Line', 'FWHM', '','Half Max Intensity');

% Display the dominant wavelength and FWHM values and asymmetry and index of the dominant wavelength
fprintf('___________________________________\n');
fprintf('Index of Dominant Wavelength: %d\n', dominant_index);
fprintf('Dominant Wavelength: %.1f nm\n', dominant_wavelength);
fprintf('FWHM: %.1f nm\n', FWHM);
fprintf('Asymmetry: %.2f \n', asymmetry);
fprintf('___________________________________\n');
