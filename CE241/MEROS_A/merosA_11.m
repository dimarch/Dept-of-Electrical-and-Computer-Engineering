% MATlab Project
% Part A // 1.1

clc, close all, clear all

help merosA_11

l1=length('DIMITRIOS'); % Mikos Onomatos l1.
l2=length('ARCHONTIS'); % Mikos Epithetou l2.
 
% Compute w1.
ww1 = mod(10/11*(max(l1,l2))/(l1+l2),1);
w1 = pi*ww1;
 
% Compute w2. 
ww2 = mod(ww1+1/4,1);
w2 = pi*ww2;

L=512;

n=0:1:L-1; % Mikos tou n
 
% Platoi Hmitonwn.
A1=1; 
 
A2=0.75;
 
x1=A1*cos(w1*n); % Sximatismos 1ou Hmitonou
 
x2=A2*cos(w2*n); % Sximatismos 1ou Hmitonou
 
x0=x1+x2; %
 
w=(ones(1,L)); % 

x=x1.*w+x2.*w; %

y=xcorr(x); % 

stem(y); % 
grid on %
title('Autosysxetisi simatos x[n]');
