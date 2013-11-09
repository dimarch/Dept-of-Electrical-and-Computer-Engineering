

clc, close all, clear all

% �������� ������� ��� ������� ��� m-file.
help merosB_23

% �� �������� (���������) // 1i = j//
zer=1.2*exp(1i*pi*[-0.35 0.35]'); 

% �� ����� (������������) // 1i = j//
pol=[0.65*exp(1i*2*pi*[-0.58 0.58]') ; 0.78*exp(1i*pi*[-0.35 0.35]') ; -0.85*exp(1i*2*pi*[-0.56 0.56]')];

figure(1); % ������� ��.1
zplane(zer,pol); % ���������� ����� ��� ���������

grid on % ���������� ������� ��������� ��� ����������.

k=1; % ������� �������

% ������ ��� ���������� ���������
% num = ����������� ��������
% den = ����������� �����������
[num,den]=zp2tf(zer,pol,k); 

sys = zpk(zer,pol,k); % ���������� ���������

% ��������� ��������
[H,T]=impz(num,den); % Impulse response of digital filter
figure(2);  % ������� ��.2
stem(T,H); % ������� ���� �������� �����
title('Impulse Response');
xlabel('Samples');
ylabel('Amplitude');

% ���������� ����������� ���������� ������ (N = 1000 ��������, ������� � = 50 ��������.
N=1000;
T=50;
[Upulse,Tpulse]=gensig('pulse',T,N); % ���������� ���������� ������.
figure(3);  % ������� ��.3
stem(Upulse); % ������� ���� �������� �����.
title('Periodic Pulse');
xlabel('Samples');
ylabel('Amplitude');

% � ������ �� ��� ������ �������� (�������� ����������).
ypulse=conv(H,Upulse);
figure(4);  % ������� ��.4
stem(ypulse); % ������� ���� �������� ����� ��� x[n]. (���� �������).
title('������ ����������');
xlabel('Samples');
ylabel('Amplitude');
