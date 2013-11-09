

clc, close all, clear all

% Εμφάνιση σχολίων και αναφορά στο m-file.
help merosB_23

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
[num,den]=zp2tf(zer,pol,k); 

sys = zpk(zer,pol,k); % Συνάρτησης Μεταφοράς

% Κρουστική Απόκριση
[H,T]=impz(num,den); % Impulse response of digital filter
figure(2);  % Γράφημα Νο.2
stem(T,H); % Γράφημα στον διακριτό χρόνο
title('Impulse Response');
xlabel('Samples');
ylabel('Amplitude');

% Δημιουργία παλμοσειράς μοναδιαίων παλμών (N = 1000 δείγματα, Περίοδο Τ = 50 δείγματα.
N=1000;
T=50;
[Upulse,Tpulse]=gensig('pulse',T,N); % Δημιουργία Περιοδικού Παλμού.
figure(3);  % Γράφημα Νο.3
stem(Upulse); % Γράφημα στον διακριτό χρόνο.
title('Periodic Pulse');
xlabel('Samples');
ylabel('Amplitude');

% Η Έξοδος σε μια τέτοια διέγερση (Απόκριση Συχνότητας).
ypulse=conv(H,Upulse);
figure(4);  % Γράφημα Νο.4
stem(ypulse); % Γράφημα στον διακριτό χρόνο της x[n]. (Σήμα Θορύβου).
title('Έξοδος Συστήματος');
xlabel('Samples');
ylabel('Amplitude');
