% Functions required: zerocross, sgn, winconv.
%%
input_file_name = 'meros1.wav';
[x,Fs] = wavread(input_file_name); % speech
x=x(:,1);
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

%function_main of voiced/unvoiced detection

%function [voiced, pitch_plot] = f_VOICED(x, fs, fsize);

%func_vd_msf, func_vd_zc is called in this m file

% INITIALIZATION:

f=1;
b=1;        %index no. of starting data point of current frame
fsize = 30e-3;    %frame size

%=number data points in each framesize of "x"
frame_length = round(Fs .* fsize);   
N= frame_length - 1;        %N+1 = frame length = number of data points in 
                            %each framesize

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

thresh_pitch = (( (sum(pitch_plot)./length(pitch_plot)) - min(pitch_plot)) .* (1.2) ) + min(pitch_plot);
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

% PITCH ESTIMATION

P = zeros(size(pitch_plot));  % Make another array to fill up
for ii = 1:numel(pitch_plot)
    if pitch_plot(ii)>thresh_pitch && pitch_plot(ii)<170
       P(ii) = pitch_plot(ii);
    end
end
for ii = 23000:numel(pitch_plot)    
       P(ii) = 0;    
end


%%
figure(9);
subplot(3,1,1),plot(x);
hold on;
plot(voiced,'r.-'); title('voiced/unvoiced detection');
subplot(3,1,2),plot(P,'r.-'); title('pitch-plot');grid on;

subplot(3,1,3),plot(pitch_plot,'r.-'); title('pitch-plot');
grid on;

[value, location] = max(P(:));

sprintf('The max value of peak is  %3.2f ', value)
 

