% Signals and Systems
% Fall Semester 2011-12
% Project Matlab
% 2nd Part // 2.4
% Removal poles from zeros

clc, close all, clear all

% Comments for m-file
help merosB_er_2_4_2-removal-poles-from-zeros

for a=1.2:-0.1:0.1;

% The zeros (numerator) | 1i = j
zer = 1.2*exp(1i*pi*[-0.35 0.35]'); 

% The poles (denominator) | 1i = j
pol = [0.65*exp(1i*2*pi*[-0.58 0.58]') ; a*exp(1i*pi*[-0.35 0.35]') ; -0.85*exp(1i*2*pi*[-0.56 0.56]')];

figure(1)

% Design of poles and zeros
zplane(zer,pol);
grid on 

pause (1) % Pause for 1 second
  
k = 1; 

% Finding Transfer Function
% num = coefficients of numerator
% den = coefficients of denominator
[num,den] = zp2tf(zer,pol,k)

% Transfer Function
sys = zpk(zer,pol,k); 

end
