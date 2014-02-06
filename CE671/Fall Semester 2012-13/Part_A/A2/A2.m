clear all; close all; clc;

% Copyright 2012-2013 Dimitris Archontis.
%%
input_file_name = 'meros1.wav';
[y,fs] = wavread(input_file_name); % read the file 

%%
y=y(:,1); % get the first channel
y = y.'; 
% soundsc(y,fs); % play of wav file

%%
xmax = max(abs(y)); % find the maximum value
y = y/xmax; % scalling the signal

% time & discretisation parameters
N = length(y);
t=(0:N-1)/fs;       

%%
% plot of the waveform
figure(1)
plot(t,y)
xlim([0 max(t)])
ylim([-1.1*max(abs(y)) 1.1*max(abs(y))])
grid on
set(gca, 'FontName', 'Arial', 'FontSize', 15)
xlabel('Time, s')
ylabel('Normalized amplitude')
title('The signal in the time domain')

%%
% Hamming Window with 10msec 
figure(2)
M = round(0.01*fs);  % length of the analysis window, 10 ms -> 10ms * 18,000 = 180 sample/frame
w = 0.54 - 0.46 * cos(2*pi*(0:M-1)/(M-1)); % Hamming Window
shift = round(0.05*fs);
w0=sigshift(w,M,shift);
spectrogram(y,w0,170,1024,fs, 'yaxis')

h = colorbar;
set(h, 'FontName', 'Verdana', 'FontSize', 15)
ylabel(h, 'Magnitude, dB');
set(gca, 'FontName', 'Verdana', 'FontSize', 15)
xlabel('Time, sec')
ylabel('Frequency, Hz')
title('Spectrogram of the signal with Hamming Window 10msec')

%%
% Hamming Window with 100msec
figure(3)
M1 = round(0.1*fs);  % length of the analysis window, 100 ms -> 100ms * 18,000 = 1800 sample/frame
w1 = 0.54 - 0.46 * cos(2*pi*(0:M1-1)/(M1-1)); % Hamming Window
w2=sigshift(w1,M,shift);
spectrogram(y,w2,1700,2048,fs,'yaxis')

h = colorbar;
set(h, 'FontName', 'Verdana', 'FontSize', 15)
ylabel(h, 'Magnitude, dB');
set(gca, 'FontName', 'Verdana', 'FontSize', 15)
xlabel('Time, sec')
ylabel('Frequency, Hz')
title('Spectrogram of the signal with Hamming Window 100msec')
