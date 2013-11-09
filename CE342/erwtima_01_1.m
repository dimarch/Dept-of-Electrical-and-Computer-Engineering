% PSIFIAKH EPEKSERGASIA SHMATOS
% EARINO EKSAMINO 2011/12
% ERGASIA MATlab
% FIR Filtro 'Parathiro Hamming'
% Specifications: low pass, wp = 0.2*pi, ws = 0.3*pi, Rp = 0.25db, As = 50db

clc, close all, clear all

% Comments in m-file. 
help erwtima_01_1

%Design of lowpass FIR filter with Hamming window
% Digital Filter Specifications:
wp=0.2*pi;  % digital Passband freq in Hz
ws=0.3*pi;  % digital Stopband freq in Hz 
Rp = 0.25;  % Passband ripple in dB 
As = 50;    % Stopband attenuation in dB
tr_width=ws-wp;           % transition width
M=ceil(6.6*pi/tr_width)+1;
%disp(N)
n=[0:1:M-1];
wc=(ws+wp)/2;              % cutoff frequency of filter
hd=ideal_lp(wc,M);
w_ham=(hamming(M))';
h=hd.*w_ham;
[db,mag,phi,grd,w]=freqz_m(h,[1]);
delta_w=2*pi/1000;
Rp=-(min(db(1:1:wp/delta_w+1))); % actual pass band ripple
As=-round(max(db(ws/delta_w+1:1:501))); % Min stopband attenuation
 
%Plots 

subplot(231)
plot(w/pi,mag);
grid
title('Magnitude response')
xlabel('frequency in pi')
ylabel('magnitude')


subplot(232)
plot(w/pi,db);
grid
title('Magnitude response in dB')
xlabel('frequency in pi')
ylabel('dB')

subplot(233)
plot(n,h);
grid
title('Actual impulse response')
xlabel('n')
ylabel('h(n)')

subplot(234)
plot(w/pi,phi/pi);
grid
title('Phase response in dB')
xlabel('frequency in pi')
ylabel('phi/pi')

subplot(235)
plot(w/pi,grd);
grid
title('Group Delay in dB')
xlabel('frequency in pi')
ylabel('phi/pi')
