

clc, close all, clear all

% �������� ������� ��� ������� ��� m-file.
help merosA_15_11

l1=length('DIMITRIOS'); % ����� �������� l1.
l2=length('ARCHONTIS'); % ����� �������� l2.
 
% ����������� �1.
ww1 = mod(10/11*(max(l1,l2))/(l1+l2),1);
w1 = pi*ww1;
 
% ����������� �2. 
ww2 = mod(ww1+1/4,1);
w2 = pi*ww2;

L=512; % ����� ������� L = 512 ���������.

n=0:1:L-1; % ����� ��� n.
 
% ������ ��� ��������.
A1=1; 
 
A2=0.75;
 
x1=A1*cos(w1*n); % ����������� 1�� ��������
 
x2=A2*cos(w2*n); % ����������� 2�� ��������
 
x0=x1+x2; % ����������� ������� x[n] ����� �� w[n].
 
w=hamming(L); % ���������� ��� w[n].

x=x1.*w'+x2.*w'; % ���� �������� x[n].

y=xcorr(x); % ����������� xcorr

stem(y); % �������� ���������� ���� �������� �����.
grid on % ���������� ������� ��������� ��� ����������.
title('������������� ������� x[n]');
