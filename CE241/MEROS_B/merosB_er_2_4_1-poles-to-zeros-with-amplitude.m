% Signals and Systems
% Fall Semester 2011-12
% Project Matlab
% 2nd Part // 2.4
% Moving poles to zeros
% Diagram of amplitude response

clc, close all, clear all

% Comments for m-file
help merosB_er_2_4_1-poles-to-zeros-with-amplitude

for a = 0.1:0.1:1.2;

% The zeros (numerator) | 1i = j
zer = 1.2*exp(1i*pi*[-0.35 0.35]'); 

% The poles (denominator) | 1i = j
pol = [0.65*exp(1i*2*pi*[-0.58 0.58]') ; a*exp(1i*pi*[-0.35 0.35]') ; -0.85*exp(1i*2*pi*[-0.56 0.56]')];

figure(1)

subplot(211);
% Design of poles and zeros
zplane(zer,pol);
grid on 
  
k = 1;

% Finding Transfer Function
% num = coefficients of numerator
% den = coefficients of denominator
[num,den] = zp2tf(zer,pol,k)

% Amplitude
w = 0:pi/255:pi;
H1 = freqz(num,den,w);
m1 = abs(H1);

figure(1);

subplot(212);
plot(w/pi,m1);
title('Amplitude Response');

pause (1) % Pause for 1 second

end
