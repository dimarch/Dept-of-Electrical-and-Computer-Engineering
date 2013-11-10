% Signals and Systems
% Fall Semester 2011-12
% Project Matlab
% 1st Part // 1.5
% Question 1.4 --> Question 1.3 | N=1024 L=512

clc, close all, clear all

% Comments for m-file
help merosA_er1_5iiiiiii-DFT-1024

l1 = length('DIMITRIOS'); % Length Name l1.
l2 = length('ARCHONTIS'); % Length Surname l2.
 
% Calculation of w1
ww1 = mod(10/11*(max(l1,l2))/(l1+l2),1);
w1 = pi*ww1;
 
% Calculation of w2
ww2 = mod(ww1+1/4,1);
w2 = pi*ww2;

L=512; % ����� ������� L = 512 ���������.

n=0:1:L-1; % ����� ��� n.

mesosorosw1w2=(w1+w2)/2; % ���� ���� �1 ��� �2

d=abs((mesosorosw1w2-w1))/10;

a=[w1:d:mesosorosw1w2;w2:-d:mesosorosw1w2]; 

A1 = 1;             % Amplitude
A2 = 0.75;          % Amplitude

for i = 1:10; 
    
x1=A1*cos(a(1,i)*n);% 1st cosine with new w1
 
x2=A2*cos(a(2,i)*n);% 2nd cosine with new w2
 
w=hamming(L);       % Create window w[n]

x=x1.*w'+x2.*w';    % The input signal x[n]

N = 1024;           % Length of Discrete Fourier Transform

X = fft(x,N);       % DFT calculation

k = 0:1:N-1;

stem(k,abs(X));     % Plot the input signal x[n] in discrete time
grid on
title('DFT of the Samples');
xlabel('axis of k value');
ylabel('amplitude');

pause (1)           % Pause for 1 second

 end
