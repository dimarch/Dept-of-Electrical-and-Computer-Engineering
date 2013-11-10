% Signals and Systems
% Fall Semester 2011-12
% Project Matlab
% 2nd Part // 2.1

clc, close all, clear all

% Comments for m-file
help merosB_er_2_1

% The zeros (numerator) | 1i = j
zer = 1.2*exp(1i*pi*[-0.35 0.35]'); 

% The poles (denominator) | 1i = j
pol = [0.65*exp(1i*2*pi*[-0.58 0.58]') ; 0.78*exp(1i*pi*[-0.35 0.35]') ; -0.85*exp(1i*2*pi*[-0.56 0.56]')];

figure(1);

% Design of poles and zeros
zplane(zer,pol);

grid on

k = 1; % gain

% Finding Transfer Function
% num = coefficients of numerator
% den = coefficients of denominator
[num,den] = zp2tf(zer,pol,k) 

sys = zpk(zer,pol,k);

sys1 = tf(sys) % Transfer Function

% Amplitude
w = 0:pi/255:pi;
H1 = freqz(num,den,w);
m1 = abs(H1);

figure(2);
 
subplot(211);
plot(w/pi,m1);       % Plot Amplitude
title('Magnitude');

% Phase
ph1 = angle(H1).*180/pi;

figure(2); 

subplot(212);
plot(w/pi,ph1);      % Plot Phase
title('Phase');

% Impulse response
[H,T]=impz(num,den); % Impulse response of digital filter

figure(3);
stem(T,H);
title('Impulse Response');
xlabel('Samples');
ylabel('Amplitude');

% Step Response
[H2,T2] = stepz(num,den); % Step response of digital filter

figure(4);
stem(T2,H2); 
title('Step Response');
xlabel('Samples');
ylabel('Amplitude');

% Filter Visualization Tool
% FVTool is a Graphical User Interface (GUI) that allows you to analyze digital filters.
fvtool(num,den) 
