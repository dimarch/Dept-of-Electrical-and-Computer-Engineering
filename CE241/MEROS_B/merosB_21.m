
clc, close all, clear all

% Εμφάνιση σχολίων και αναφορά στο m-file.
help merosB_21

% Τα μηδενικά (Αριθμητής) // 1i = j//
zer=1.2*exp(1i*pi*[-0.35 0.35]'); 

% Οι πόλοι (Παρονομαστής) // 1i = j//
pol=[0.65*exp(1i*2*pi*[-0.58 0.58]') ; 0.78*exp(1i*pi*[-0.35 0.35]') ; -0.85*exp(1i*2*pi*[-0.56 0.56]')];

figure(1); % Γράφημα Νο.1
zplane(zer,pol); % Σχεδιασμός πόλων και μηδενικών

grid on % Σχεδιασμός γραμμών πλέγματος του γραφήματος.

k=1; % Σταθερά κέρδους

% Εύρεση της Συνάρτησης Μεταφοράς
% num = Συντελεστές Αριθμητή
% den = Συντελεστές Παρονομαστή
[num,den]=zp2tf(zer,pol,k) 

sys = zpk(zer,pol,k);

sys1 = tf(sys) % Παράγω την συνάρτηση μεταφοράς.

% Πλάτος
w=0:pi/255:pi;
H1=freqz(num,den,w);
m1=abs(H1);
figure(2); % Γράφημα Νο.2
% Χωρίζω το παράθυρο της εικόνας σε 2 μέρη και χρησιμοποιώ το 1ο Παράθυρο.
subplot(211);
plot(w/pi,m1);% Σχεδιασμός Πλάτους
title('Magnitute');

% Φάση
ph1=angle(H1).*180/pi;
figure(2); % Γράφημα Νο.2
% Έχοντας χωρισμένο το παράθυρο, χρησιμοποιώ το 2ο Παράθυρο.
subplot(212);
plot(w/pi,ph1); % Σχεδιασμός Φάσης
title('Phase');

% Κρουστική Απόκριση
[H,T]=impz(num,den); % Impulse response of digital filter
figure(3);  % Γράφημα Νο.3
stem(T,H); % Γράφημα στον διακριτό χρόνο
title('Impulse Response');
xlabel('Samples');
ylabel('Amplitude');

% Βηματική Απόκριση
[H2,T2]=stepz(num,den); % Impulse response of digital filter
figure(4);  % Γράφημα Νο.4
stem(T2,H2); % Γράφημα στον διακριτό χρόνο
title('Step Response');
xlabel('Samples');
ylabel('Amplitude');

% Filter Visualization Tool
% FVTool is a Graphical User Interface (GUI) that allows you to analyze
% digital filters.
fvtool(num,den) 