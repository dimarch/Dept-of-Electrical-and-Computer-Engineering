

clc, close all, clear all

% �������� ������� ��� ������� ��� m-file.
help merosA_14i

l1=length('DIMITRIOS'); % ����� �������� l1.
l2=length('ARCHONTIS'); % ����� �������� l2.
 
% ����������� �1.
ww1 = mod(10/11*(max(l1,l2))/(l1+l2),1);
w1 = pi*ww1;
 
% ����������� �2. 
ww2 = mod(ww1+1/4,1);
w2 = pi*ww2;

L=256; % ����� ������� L = 256 ���������.

n=0:1:L-1; % ����� ��� n.
 
% ������ ��� ��������.
A1=1; 
 
A2=0.75;
 
x1=A1*cos(w1*n); % ����������� 1�� ��������
 
x2=A2*cos(w2*n); % ����������� 2�� ��������
 
x0=x1+x2; % ����������� ������� x[n] ����� �� w[n].
 
w=(ones(1,L)); % ���������� ��� w[n].

x=x1.*w+x2.*w; % ���� �������� x[n].

N=512; % ����� ��������� ���/���� Fourier.

X=fft(x,N); % ����������� DFT

% ������ �� �������� ��� ������� �� 2 ���� ��� ����������� �� 1� ��������.
subplot(2,1,1)

% ������ ���� x[n].
stem(n,x); % �������� ���������� ���� �������� �����.
axis([0,255,-2,2]); % ������� ������
grid on % ���������� ������� ��������� ��� ����������.
title('������ ���� x[n]');
xlabel('������ ����� n');

k=0:1:N-1; % ����� N = 512 ��������.

% ������� ��������� �� ��������, ����������� �� 2� ��������.
subplot(2,1,2)

stem(k,abs(X)); % �������� ��� ������� ���.
axis([0,511,0,130]); % ������� ������
grid on % ���������� ������� ��������� ��� ����������.
title('DFT ���������');
xlabel('������ ����� k');
ylabel('������');
