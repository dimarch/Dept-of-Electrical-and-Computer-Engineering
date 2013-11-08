% sizeinfo = wavread('meros1.wav', 'size');
% tot_samples = sizeinfo(1);

[y, fs] = wavread('meros1.wav');

% length of the analysis window, 30ms * 18,000 = 540 sample/frame
% round(0.03*fs);

%% VOICED SOUND 30ms
startpos_voiced = 24 * round(0.03*fs); % 12960
endpos_voiced = startpos_voiced + round(0.03*fs); % 13500

ss6 = y(startpos_voiced:endpos_voiced);

%% UNVOICED SOUND 30ms
startpos_unvoiced = 28 * round(0.03*fs); % 15120
endpos_unvoiced = startpos_unvoiced + round(0.03*fs); % 15660

ss7 = y(startpos_unvoiced:endpos_unvoiced);

%% 

[y1, Fs1] = wavread('meros1.wav', [startpos_voiced endpos_voiced]);
y1=y1(:,1); % get the first channel
y1 = y1.';
[y2, Fs2] = wavread('meros1.wav', [startpos_unvoiced endpos_unvoiced]);
y2=y2(:,1); % get the first channel
y2 = y2.';

%% PLAY THE SOUNDS

% sound(y1, Fs1);
% sound(y2, Fs2);

%%

figure(10);
subplot(2,1,1);
plot(ss6);
legend('Voiced Speech')
grid on;
subplot(2,1,2);
plot(ss7);
legend('Unvoiced Speech')
grid on;

%% DFT of voiced signal

figure(11);
subplot(2,1,1);
stem(ss6);
title('The sampled voiced signal');
xlabel('Time'), ylabel('Amplitude');
grid on;

VOICED_DFT=fft(ss6); % Compute DFT for signal ss6 (voiced)
N=(fs/2)*linspace(-1,1,length(ss6));

subplot(2,1,2)
stem(N,fftshift(abs(VOICED_DFT)));
title('Sampled voiced signal at frequency-domain');
xlabel('Frequency'), ylabel('Amplitude');
grid on;

%% DFT of unvoiced signal

figure(12);
subplot(2,1,1);
stem(ss7);
title('The sampled unvoiced signal');
xlabel('Time'), ylabel('Amplitude');
grid on;

UNVOICED_DFT=fft(ss7); % Compute DFT for signal ss7 (unvoiced)
N=(fs/2)*linspace(-1,1,length(ss7));

subplot(2,1,2)
stem(N,fftshift(abs(UNVOICED_DFT)));

title('Sampled unvoiced signal at frequency-domain');
xlabel('Frequency'), ylabel('Amplitude');
grid on;

%% VOICED SOUND / LPC ANALYSIS

% Order values to test
orders = [8, 12, 16];
l_ord = length(orders);

% Calculate the windowed speech spectrum
S_V = abs(VOICED_DFT);
figure(13);
subplot(l_ord + 2,1,1);

plot(ss6); 
xlim([0 length(ss6)]); % limit x
title('LP Analysis VOICED SOUND for various model orders')

subplot(l_ord + 2,1,2);
plot(20*log10(S_V(1:541)), 'g');
xlim([0 length(ss6)]); % limit x
legend('Speech Spectrum');
title('Spectrum of the voiced signal')

for o=orders
    [lpcoefs, e_v] = lpc(ss6, o);
    % Estimated signal
    estss6 = filter([0 -lpcoefs(2:end)], 1, ss6);
    % Prediction error
    er_ss6 = ss6 - estss6;
    %Prediction error energy
    erEn = sum(er_ss6.^2);

    % Frequency response of the model
    [H, W] = freqz(sqrt(erEn), lpcoefs(1:end), 541);

    subplot(l_ord + 2,1,find(orders==o) + 2);
    plot(linspace(0,541,541), 20*log10(abs(H)));
    xlim([0 length(ss6)]); % limit x
    title(['LP Analysis for model order = ', int2str(o)])
    
    
    legend(['p = ',int2str(o)]);
end


%% UNVOICED SOUND / LPC ANALYSIS


% Order values to test
orders = [8, 12, 16];
l_ord = length(orders);

% Calculate the windowed speech spectrum
S_UN = abs(UNVOICED_DFT);
figure(14);
subplot(l_ord + 2,1,1);

plot(ss7); 
xlim([0 length(ss7)]); % limit x
title('LP Analysis UNVOICED SOUND for various model orders')

subplot(l_ord + 2,1,2);
plot(20*log10(S_UN(1:541)), 'g');
xlim([0 length(ss7)]); % limit x
legend('Speech Spectrum');
title('Spectrum of the unvoiced signal')

for o=orders
    [lpcoefs, e_un] = lpc(ss7, o);
    % Estimated signal
    estss7 = filter([0 -lpcoefs(2:end)], 1, ss7);
    % Prediction error
    er_ss7 = ss6 - estss7;
    % Prediction error energy
    erEn = sum(er_ss7.^2);

    % Frequency response of the model
    [H, W] = freqz(sqrt(erEn), lpcoefs(1:end), 541);

    subplot(l_ord + 2,1,find(orders==o) + 2);
    plot(linspace(0,541,541), 20*log10(abs(H)));
    xlim([0 length(ss7)]); % limit x
    title(['LP Analysis for model order = ', int2str(o)])
    
   
    legend(['p = ',int2str(o)]);
end


%% VOICED SOUND / LPC ANALYSIS

% 8th order filter 
voiced_8_lpcoefs = lpc(ss6,8);  % 8th order filter (8 coefficients)
voiced_8_est_x = filter([0 -voiced_8_lpcoefs(1:end)],1,ss6); % Estimated signal
voiced_8_predictor_error = ss6 - voiced_8_est_x;  % Prediction error
figure(15)
subplot(3,1,1)
plot(voiced_8_predictor_error);
xlim([0 length(ss6)]); % Limit x
grid on;
title('Prediction error signal - 8th order filter - Voiced Sound ')

% 12th order filter 
voiced_12_lpcoefs = lpc(ss6,12);  % 12th order filter (12 coefficients)
voiced_12_est_x = filter([0 -voiced_12_lpcoefs(1:end)],1,ss6); % Estimated signal
voiced_12_predictor_error = ss6 - voiced_12_est_x;  % Prediction error
subplot(3,1,2)
plot(voiced_12_predictor_error);
xlim([0 length(ss6)]); % Limit x
grid on;
title('Prediction error signal - 12th order filter - Voiced Sound ')

% 16th order filter 
voiced_16_lpcoefs = lpc(ss6,16);  % 16th order filter (16 coefficients)
voiced_16_est_x = filter([0 -voiced_16_lpcoefs(1:end)],1,ss6); % Estimated signal
voiced_16_predictor_error = ss6 - voiced_16_est_x;  % Prediction error
subplot(3,1,3)
plot(voiced_16_predictor_error);
xlim([0 length(ss6)]); % Limit x
grid on;
title('Prediction error signal - 16th order filter - Voiced Sound')


%% UNVOICED SOUND / LPC ANALYSIS

% 8th order filter 
unvoiced_8_lpcoefs = lpc(ss7,8);  % 8th order filter (8 coefficients)
unvoiced_8_est_x = filter([0 -unvoiced_8_lpcoefs(1:end)],1,ss7); % Estimated signal
unvoiced_8_predictor_error = ss7 - unvoiced_8_est_x;  % Prediction error
figure(16)
subplot(3,1,1)
plot(unvoiced_8_predictor_error);
xlim([0 length(ss7)]); % Limit x
grid on;
title('Prediction error signal - 8th order filter - Unvoiced Sound')

% 12th order filter 
unvoiced_12_lpcoefs = lpc(ss7,12);  % 12th order filter (12 coefficients)
unvoiced_12_est_x = filter([0 -unvoiced_12_lpcoefs(1:end)],1,ss7); % Estimated signal
unvoiced_12_predictor_error = ss7 - unvoiced_12_est_x;  % Prediction error
subplot(3,1,2)
plot(unvoiced_12_predictor_error);
xlim([0 length(ss7)]); % Limit x 
grid on;
title('Prediction error signal - 12th order filter - Unvoiced Sound')

% 16th order filter 
unvoiced_16_lpcoefs = lpc(ss7,16);  % 16th order filter (16 coefficients)
unvoiced_16_est_x = filter([0 -unvoiced_16_lpcoefs(1:end)],1,ss7); % Estimated signal
unvoiced_16_predictor_error = ss7 - unvoiced_16_est_x;  % Prediction error
subplot(3,1,3)
plot(unvoiced_16_predictor_error);
xlim([0 length(ss7)]); % Limit x
grid on;
title('Prediction error signal - 16th order filter - Unvoiced Sound')
