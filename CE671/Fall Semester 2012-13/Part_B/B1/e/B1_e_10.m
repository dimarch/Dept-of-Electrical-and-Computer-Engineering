close all; clear all; clc

% Functions required: zerocross, sgn, winconv.
%%
input_file_name = 'e_10.wav';
[x,Fs] = wavread(input_file_name); % speech
x=x(:,1); % get the first channel
x = x.';

%%

%LENGTH (IN SEC) OF INPUT WAVEFILE,
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
winamp = [30,30]*(1/winlen);

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

%{
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

%}

%%

%function_main of voiced/unvoiced detection

%func_vd_msf, func_vd_zc is called in this m file

% INITIALIZATION:

f=1;
b=1;        %index no. of starting data point of current frame
fsize = 30e-3;    %frame size

%=number data points in each framesize of "x"
frame_length = round(Fs .* fsize);  % 22000 * 0,0300 = 660
N= frame_length - 1;  %N+1 = frame length = number of data points in %each framesize

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

thresh_zc = (( ( sum(zc)./length(zc) ) - min(zc) ) .*  (0.5) ) + min(zc);
voiced_zc = zc < thresh_zc;

thresh_pitch = (( (sum(pitch_plot)./length(pitch_plot)) - min(pitch_plot)) .* (0.5) ) + min(pitch_plot);
voiced_pitch =  pitch_plot > thresh_pitch;

for b=1:(length(x) - frame_length),
    if voiced_msf(b) .* voiced_pitch(b) == 1,
        voiced(b) = 1;
    else
        voiced(b) = 0;
    end
end

%%
figure(1);
plot(x);
hold on;
plot(voiced,'r.-'); title('voiced detection for the /e/ No10');
legend('signal','voiced=1, unvoiced/silence=0');
grid on;
%%

% The voiced speech
startpos_voiced = 20060;
endpos_voiced = 23717;

ss1 = x(startpos_voiced:endpos_voiced); % The segment of the voiced speech

%{
 [y1, Fs1] = wavread(input_file_name, [startpos_voiced endpos_voiced]);
 y1=y1(:,1); % get the first channel
 y1 = y1.';

 sound(y1, Fs1);
%}

wavwrite(ss1,Fs,16,'e_10_new.wav'); % write the new voiced speech only

