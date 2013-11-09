% PSIFIAKH EPEKSERGASIA SHMATOS
% EARINO EKSAMINO 2011/12
% ERGASIA MATlab
% FIR Filtro 'Parathiro Kaiser'

clc, close all, clear all

help erwtima_01_2

%Design of lowpass FIR filter with Kaiser window

wp=0.2*pi;
ws=0.3*pi;
Rp = 0.25;  % Passband ripple in dB 
As=50;
tr_width=ws-wp;           % transition width
M=ceil((As-7.95)/(14.36*tr_width/(2*pi))+1)+1;
%disp(M)
n=[0:1:M-1];
alpha=0.1102*(As-8.7);  % parameter alpha of Kaiser window
wc=(ws+wp)/2;              % cutoff frequency of filter
hd=ideal_lp(wc,M);
w_kai=(kaiser(M,alpha))';
h=hd.*w_kai;
%Modified freqz command
[db,mag,phi,grd,w]=freqz_m(h,[1]);
delta_w=2*pi/1000;
Rp=-(min(db(1:1:wp/delta_w+1))); % actual pass band ripple
As=-round(max(db(ws/delta_w+1:1:501))); % Min stopband attenuation
%display stopband attenuation

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
