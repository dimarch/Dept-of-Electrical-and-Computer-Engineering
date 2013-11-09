

clc, close all, clear all

% �������� ������� ��� ������� ��� m-file.
help merosB_24iii

for a=1.2:-0.1:0.78;
% �� �������� (���������) // 1i = j//
zer=a*exp(1i*pi*[-0.35 0.35]'); 

% �� ����� (������������) // 1i = j//
pol=[0.65*exp(1i*2*pi*[-0.58 0.58]') ; 0.78*exp(1i*pi*[-0.35 0.35]') ; -0.85*exp(1i*2*pi*[-0.56 0.56]')];

figure(1) % ������� ��.1
zplane(zer,pol); % ���������� ����� ��� ���������
grid on % ���������� ������� ��������� ��� ����������.

pause (1) % Pause for 1 second
  
k=1; % ������� �������

% ������ ��� ���������� ���������
% num = ����������� ��������
% den = ����������� �����������
[num,den]=zp2tf(zer,pol,k); 

sys = zpk(zer,pol,k); % ���������� ���������
end
