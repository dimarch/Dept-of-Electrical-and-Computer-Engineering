% PSIFIAKH EPEKSERGASIA SHMATOS
% EARINO EKSAMINO 2011/12
% ERGASIA MATlab

clc, close all, clear all

% m-file.
help erwtima_03

l1=length('DIMITRIOS'); % length name l1.
l2=length('ARCHONTIS'); % length surname l2.
 
% Calculation w1.
ww1 = mod(10/11*(max(l1,l2))/(l1+l2),1);
w1 = pi*ww1;
 
% Calculation w2. 
ww2 = mod(ww1+1/4,1);
w2 = pi*ww2;

L=512; % ����� ������� L = 512 ���������.

n=0:1:L-1; % ����� ��� n.
 
% ������ ��� ��������.
A1=1; 
 
A2=0.5;
 
x1=A1*cos(w1*n); % ����������� 1�� ��������.
 
x2=A2*cos(w2*n); % ����������� 2�� ��������.
 
x=x1+x2; % ����������� ������� x[n].
 
stem(x); % �������� ���������� ���� �������� �����.
grid on % ���������� ������� ��������� ��� ����������.
