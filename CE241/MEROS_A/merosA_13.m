clc, close all, clear all


l1=length('DIMITRIOS'); % ����� �������� l1.
l2=length('ARCHONTIS'); % ����� �������� l2.
 
% ����������� �1.
ww1 = mod(10/11*(max(l1,l2))/(l1+l2),1);
w1 = pi*ww1;
 
% ����������� �2. 
ww2 = mod(ww1+1/4,1);
w2 = pi*ww2;

L=512; % ����� ������� L = 512 ���������.

N=256; % ����� ��������� ���/���� Fourier.
 
n=0:1:L-1; % ����� ��� n.

mesosorosw1w2=(w1+w2)/2; % ���� ���� �1 ��� �2

d=abs((mesosorosw1w2-w1))/10;

a=[w1:d:mesosorosw1w2;w2:-d:mesosorosw1w2];
 
% ������ ��� ��������.
A1=1; 
 
A2=0.75;

for i=1:10; 
    
x1=A1*cos(a(1,i)*n); % ����������� 1�� �������� �� �� ��� �1.
 
x2=A2*cos(a(2,i)*n); % ����������� 2�� �������� �� �� ��� �2.
 
w=(ones(1,L)); % ���������� ��� w[n].

x=x1.*w+x2.*w; % ���� �������� x[n].

X=fft(x,N); % ����������� DFT

k=0:1:N-1; % ����� N = 256 ��������.

stem(k,abs(X)); % �������� ���������� ���� �������� �����.

grid on % ���������� ������� ���������.
pause (1) % Pause for 1 second
end
