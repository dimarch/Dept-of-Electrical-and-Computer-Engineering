% Signals and Systems
% Fall Semester 2011-12
% Project Matlab
% 1st Part // 1.1

clc, close all, clear all

% Comments for m-file
help merosA_er1_1

l1 = length('DIMITRIOS'); % Length Name l1.
l2 = length('ARCHONTIS'); % Length Surname l2.
 
% Calculation of w1
ww1 = mod(10/11*(max(l1,l2))/(l1+l2),1);
w1 = pi*ww1;
 
% Calculation of w2
ww2 = mod(ww1+1/4,1);
w2 = pi*ww2;

L=512;            % length signal is 512

n=0:1:L-1;        % length of n
 
A1=1;
A2=0.75;
 
x1=A1*cos(w1*n);  % 1st cosine
x2=A2*cos(w2*n);  % 2nd cosine
 
x0=x1+x2;         % Signal x[n] without w[n]
 
w=(ones(1,L));    % Create signal w[n]

x=x1.*w+x2.*w;    % The input signal x[n]

y=xcorr(x);

stem(y);          % Plot the input signal x[n] in discrete time
grid on
title('Autocorrelation of input signal x[n]');
