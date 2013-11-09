
clc, close all, clear all

% �������� ������� ��� ������� ��� m-file.
help merosB_21

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
[num,den]=zp2tf(zer,pol,k) 

sys = zpk(zer,pol,k);

sys1 = tf(sys) % ������ ��� ��������� ���������.

% ������
w=0:pi/255:pi;
H1=freqz(num,den,w);
m1=abs(H1);
figure(2); % ������� ��.2
% ������ �� �������� ��� ������� �� 2 ���� ��� ����������� �� 1� ��������.
subplot(211);
plot(w/pi,m1);% ���������� �������
title('Magnitute');

% ����
ph1=angle(H1).*180/pi;
figure(2); % ������� ��.2
% ������� ��������� �� ��������, ����������� �� 2� ��������.
subplot(212);
plot(w/pi,ph1); % ���������� �����
title('Phase');

% ��������� ��������
[H,T]=impz(num,den); % Impulse response of digital filter
figure(3);  % ������� ��.3
stem(T,H); % ������� ���� �������� �����
title('Impulse Response');
xlabel('Samples');
ylabel('Amplitude');

% �������� ��������
[H2,T2]=stepz(num,den); % Impulse response of digital filter
figure(4);  % ������� ��.4
stem(T2,H2); % ������� ���� �������� �����
title('Step Response');
xlabel('Samples');
ylabel('Amplitude');

% Filter Visualization Tool
% FVTool is a Graphical User Interface (GUI) that allows you to analyze
% digital filters.
fvtool(num,den) 