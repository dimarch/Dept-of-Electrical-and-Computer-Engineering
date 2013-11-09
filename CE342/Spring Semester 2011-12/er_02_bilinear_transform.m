% Digital Signal Processing
% Spring Semester 2011-12
% Project Matlab
% IIR Filter 'bilinear transform'

clc, close all, clear all

% Comments for m-file
help er_02_bilinear_transform

% Digital Filter Specifications: 
wp = 0.2*pi; % digital Passband freq in Hz 
ws = 0.3*pi; % digital Stopband freq in Hz 
Rp = 0.25;   % Passband ripple in dB 
As = 50;     % Stopband attenuation in dB 

% Analog Prototype Specifications: Inverse mapping for frequencies

Td = 1; Fd = 1/Td;          % Set Td=1 
Wp = (2/Td)*tan(wp/2);      % Prewarp Prototype Passband freq 
Ws = (2/Td)*tan(ws/2);      % Prewarp Prototype Stopband freq 
ep = sqrt(10^(Rp/10)-1);    % Passband Ripple parameter 
Ripple = sqrt(1/(1+ep*ep)); % Passband Ripple 
Attn = 1/(10^(As/20));      % Stopband Attenuation

% Analog Butterworth Prototype Filter Calculation: 
[cs,ds] = afd_butt(Wp,Ws,Rp,As);

% Bilinear transformation: 
[b,a] = bilinear(cs,ds,Td);

% plot

figure(1); subplot(1,1,1)
[db,mag,pha,grd,w] = freqz_m(b,a);

subplot(2,2,1); 
plot(w/pi,mag); 
title('Magnitude Response') 
xlabel('Frequency in pi units');
ylabel('|H|'); 
axis([0,1,0,1.1]) 
grid

subplot(2,2,3); 
plot(w/pi,db); 
title('Magnitude in dB');
axis([0,1,-100,5]);
grid

subplot(2,2,2); 
plot(w/pi,pha/pi);
title('Phase Response')
axis([0,1,-1,1]);
grid

subplot(2,2,4); 
plot(w/pi,grd); 
title('Group Delay')
axis([0,1,0,10])
grid

% Check if the initial digital specifications are met
Hw1w2=freqz(b,a,[Ws Wp]); 
10*log10(abs(Hw1w2).^2)
