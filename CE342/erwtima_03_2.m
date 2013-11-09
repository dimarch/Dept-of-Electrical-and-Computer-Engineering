% PSIFIAKH EPEKSERGASIA SHMATOS
% EARINO EKSAMINO 2011/12
% ERGASIA MATlab

clc, close all, clear all

% �������� ������� ��� ������� ��� m-file.
help erwtima_03_2

%Design of lowpass FIR filter with Hamming window

wp=0.2*pi;
ws=0.3*pi;
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


l1=length('DIMITRIOS'); % ����� �������� l1.
l2=length('ARCHONTIS'); % ����� �������� l2.
 
% ����������� �1.
ww1 = mod(10/11*(max(l1,l2))/(l1+l2),1);
w1 = pi*ww1;
 
% ����������� �2. 
ww2 = mod(ww1+1/4,1);
w2 = pi*ww2;
 
% breadth of cosines. 
A1=1; 
A2=0.5; 
 
x1=A1*cos(w1*n); % ����������� 1�� ��������.
 
x2=A2*cos(w2*n); % ����������� 2�� ��������.
 
x=x1+x2; % ����������� ������� x[n].

y=x1.*w_ham+x2.*w_ham; % ���� �������� y[n]
 
stem(y); % �������� ���������� ���� �������� �����.
grid on % ���������� ������� ��������� ��� ����������.
