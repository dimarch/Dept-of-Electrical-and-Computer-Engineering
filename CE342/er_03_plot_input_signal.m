% Digital Signal Processing
% EARINO EKSAMINO 2011/12
% Project MATlab

clc, close all, clear all

% Comments for m-file.
help er_03_plot_input_signal

l1 = length('DIMITRIOS'); % Length Name l1.
l2 = length('ARCHONTIS'); % Length Surname l2.
 
% Calculation of w1.
ww1 = mod(10/11*(max(l1,l2))/(l1+l2),1);
w1 = pi*ww1;
 
% Calculation of w2. 
ww2 = mod(ww1+1/4,1);
w2 = pi*ww2;

L = 512;     % length signal is 512. 

n = 0:1:L-1; % length of n

A1 = 1;      % Platos tou 1ou cos
 
A2 = 0.5;    % Platos tou 2ou cos
 
x1 = A1*cos(w1*n); % 1st cosine
 
x2 = A2*cos(w2*n); % 2nd cosine
 
x = x1+x2;   % The signal x[n]
 
stem(x);     % Plot in discrete time

grid on
