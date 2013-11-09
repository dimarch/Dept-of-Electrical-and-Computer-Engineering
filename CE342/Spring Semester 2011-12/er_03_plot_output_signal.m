% Digital Signal Processing
% Spring Semester 2011-12
% Project MATlab

clc, close all, clear all

% Comments for m-file
help er_03_plot_output_signal

% Design of lowpass FIR filter with Hamming window

wp = 0.2*pi;       % digital Passband freq in Hz
ws = 0.3*pi;       % digital Stopband freq in Hz
tr_width = ws-wp;  % transition width
M = ceil(6.6*pi/tr_width)+1;

% disp(N)
n = [0:1:M-1];
wc = (ws+wp)/2;              % cutoff frequency of filter
hd = ideal_lp(wc,M);
w_ham = (hamming(M))';
h = hd.*w_ham;
[db,mag,phi,grd,w] = freqz_m(h,[1]);
delta_w = 2*pi/1000;
Rp = -(min(db(1:1:wp/delta_w+1)));        % actual pass band ripple
As = -round(max(db(ws/delta_w+1:1:501))); % Min stopband attenuation


l1 = length('DIMITRIOS'); % Length Name l1.
l2 = length('ARCHONTIS'); % Length Surname l2.
 
% Calculation of w1.
ww1 = mod(10/11*(max(l1,l2))/(l1+l2),1);
w1 = pi*ww1;
 
% Calculation of w2.
ww2 = mod(ww1+1/4,1);
w2 = pi*ww2;
 
A1 = 1;   % Platos tou 1ou cos
A2 = 0.5; % Platos tou 2ou cos
 
x1 = A1*cos(w1*n); % 1st cosine
x2 = A2*cos(w2*n); % 2st cosine

x = x1+x2;               %  The input signal x[n]
y = x1.*w_ham+x2.*w_ham; %  The output signal y[n]
 
stem(y); % Plot the output signal y[n] in discrete time
grid on 
