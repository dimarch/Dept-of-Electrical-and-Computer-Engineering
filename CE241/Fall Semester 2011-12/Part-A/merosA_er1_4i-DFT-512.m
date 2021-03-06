% Signals and Systems
% Fall Semester 2011-12
% Project Matlab
% 1st Part // 1.4
% Question 1.2 | N=512 L=256

clc, close all, clear all

% Comments for m-file
help merosA_er1_4i-DFT-512

l1 = length('DIMITRIOS'); % Length Name l1.
l2 = length('ARCHONTIS'); % Length Surname l2.
 
% Calculation of w1
ww1 = mod(10/11*(max(l1,l2))/(l1+l2),1);
w1 = pi*ww1;
 
% Calculation of w2
ww2 = mod(ww1+1/4,1);
w2 = pi*ww2;

L = 256;            % length signal is 256

n = 0:1:L-1;        % length of n
 
A1 = 1;
A2 = 0.75;
 
x1 = A1*cos(w1*n);  % 1st cosine
 
x2 = A2*cos(w2*n);  % 2nd cosine
 
x0 = x1+x2;         % Signal x[n] without w[n]
 
w = (ones(1,L));    % Create window w[n]

x = x1.*w+x2.*w;    % The input signal x[n]

N = 512;            % Length of Discrete Fourier Transform

X = fft(x,N);       % DFT calculation

subplot(2,1,1)

% The init signal x[n]
stem(n,x);
axis([0,255,-2,2]); % axis range
grid on
title('Init signal x[n]');
xlabel('axis of n value');

k = 0:1:N-1;

subplot(2,1,2)

stem(k,abs(X));
axis([0,511,0,130]); % axis range
grid on 
title('DFT of the Samples');
xlabel('axis of k value');
ylabel('amplitude');
