% Computation of Short-Time ZCR and Short-time Energy of a speech signal.
%
% Functions required: zerocross, sgn, winconv.
%%
input_file_name = 'meros1.wav';
[x,Fs] = wavread(input_file_name); % speech
x=x(:,1);
x = x.';

%%
% LENGTH (IN SEC) OF INPUT WAVEFILE
t=length(x)./Fs;
sprintf('Processing the wavefile "%s"', input_file_name)
sprintf('The wavefile is  %3.2f  seconds long', t)

N = length(x); % signal length
n = 0:N-1;
ts = n*(1/Fs); % time for signal

%%
% define the window
wintype = 'hamming';
winlen = 201;
winamp = [0.5,30]*(1/winlen);

%%
% find the zero-crossing rate
zc = zerocross(x,wintype,winamp(1),winlen);

%%
% find the energy
E = energy(x,wintype,winamp(2),winlen);

%%
% time index for the ST-ZCR and STE
out = (winlen-1)/2:(N+winlen-1)-(winlen-1)/2;
t = (out-(winlen-1)/2)*(1/Fs);

%%
figure(4);

% Short-time Energy
subplot(2,1,1),plot(ts,x);
hold on;
plot(t,E(out),'r','Linewidth',2); xlabel('Time (sec)');
title('Short-time Energy');
legend('signal','Short-time Energy');

%%
% Short-Time Zero Crossing Rate
subplot(2,1,2),plot(ts,x);
hold on;
plot(t,zc(out),'r','Linewidth',2); xlabel('Time (sec)');
title('Short-time Zero Crossing Rate');
legend('signal','Short-Time Zero Crossing Rate');

%%

% Three voiced segments, of different length.
ss1 = x(5063:5700);
ss2 = x(5063:5620);
ss3 = x(5063:5500);

%%

% Calculation of the short time autocorrelation
[ac1, lags1] = xcorr(ss1);
[ac2, lags2] = xcorr(ss2);
[ac3, lags3] = xcorr(ss3);

%%

figure(5);

subplot(3,1,1);
plot(lags1, ac1);
legend('Window Length: 638 Samples')
title('Short-Time Autocorrelation Function')
grid on;

subplot(3,1,2);
plot(lags2, ac2);
xlim([lags1(1) lags1(end)]);
legend('Window Length: 558 Samples')
grid on;

subplot(3,1,3);
plot(lags3, ac3);
xlim([lags1(1) lags1(end)]);
legend('Window Length: 438 Samples')
xlabel('Lag in samples')
grid on;

%%

% An unvoiced speech segment.
ss4 = x(14200:14937);
[ac4, lags4] = xcorr(ss4);

%%
% A Silence segment.
ss5 = x(30000:30637);
[ac5, lags5] = xcorr(ss5);

%%

figure(6);

subplot(3,2,1);
plot(ss1);
legend('Voiced Speech')

subplot(3,2,2);
plot(lags1, ac1);
xlim([lags1(1) lags1(end)]);
legend('Autocorrelation of Voiced Speech')
grid on;

subplot(3,2,3);
plot(ss4);
legend('Unvoiced Speech')
subplot(3,2,4);
plot(lags4, ac4);
xlim([lags1(1) lags1(end)]);
legend('Autocorrelation of Unvoiced Speech')
grid on;

subplot(3,2,5);
plot(ss5);
legend('Silence')

subplot(3,2,6);
plot(lags5, ac5);
xlim([lags1(1) lags1(end)]);
legend('Autocorrelation of Silence')
grid on;



%%

figure(7);
subplot(3,1,1);
plot(ss1);
legend('Voiced Speech')
grid on;

subplot(3,1,2);
plot(ss4);
legend('Unvoiced Speech')
grid on;

subplot(3,1,3);
plot(ss5);
legend('Silence')
grid on;

%%

%function_main of voiced/unvoiced detection

%function [voiced, pitch_plot] = f_VOICED(x, fs, fsize);

%func_vd_msf, func_vd_zc is called in this m file

% INITIALIZATION:

f=1;
b=1;        % index no. of starting data point of current frame
fsize = 30e-3;    % frame size

% number data points in each framesize of "x"
frame_length = round(Fs .* fsize);  % 18000 * 0,0300 = 540
N= frame_length - 1;  % N+1 = frame length = number of data points in %each framesize

%FRAME SEGMENTATION:
for b=1 : frame_length : (length(x) - frame_length),
    y1=x(b:b+N);     %"b+N" denotes the end point of current frame.
                %"y" denotes an array of the data points of the current 
                %frame
    y = filter([1 -.9378], 1, y1);  %pre-emphasis filter

    msf(b:(b + N)) = func_vd_msf (y);
    zc(b:(b + N)) = func_vd_zc (y);
    pitch_plot(b:(b + N)) = func_pitch (y,Fs);
end

thresh_msf = (( (sum(msf)./length(msf)) - min(msf)) .* (0.67) ) + min(msf);
voiced_msf =  msf > thresh_msf;     %=1,0

thresh_zc = (( ( sum(zc)./length(zc) ) - min(zc) ) .*  (1.5) ) + min(zc);
voiced_zc = zc < thresh_zc;

thresh_pitch = (( (sum(pitch_plot)./length(pitch_plot)) - min(pitch_plot)) .* (0.5) ) + min(pitch_plot);
voiced_pitch =  pitch_plot > thresh_pitch;

for b=1:(length(x) - frame_length),
    if voiced_msf(b) .* voiced_pitch(b) .* voiced_zc(b) == 1,
%     if voiced_msf(b) + voiced_pitch(b) > 1,
        voiced(b) = 1;
    else
        voiced(b) = 0;
    end
end

%%
figure(8);
plot(x);
hold on;
plot(voiced,'r.-'); title('voiced/unvoiced detection');
legend('signal','voiced=1, unvoiced=0');
