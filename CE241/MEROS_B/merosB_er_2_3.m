% Signals and Systems
% Fall Semester 2011-12
% Project Matlab
% 2nd Part // 2.3

clc, close all, clear all

% Comments for m-file
help merosB_er_2_3

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

% Transfer Function
sys = zpk(zer,pol,k);

% Impulse response of digital filter
[H,T] = impz(num,den);

figure(2);
stem(T,H);
title('Impulse Response');
xlabel('Samples');
ylabel('Amplitude');

% Creation of unit pulses (N = 1000 samples, Period T = 50 samples)
N = 1000;
T = 50;
[Upulse,Tpulse] = gensig('pulse',T,N); % Creation of Periodic Pulse

figure(3); 
stem(Upulse); 
title('Periodic Pulse');
xlabel('Samples');
ylabel('Amplitude');

% Output to such a stimulation (Frequency Response)
ypulse = conv(H,Upulse);

figure(4);
stem(ypulse);
title('System Output');
xlabel('Samples');
ylabel('Amplitude');
