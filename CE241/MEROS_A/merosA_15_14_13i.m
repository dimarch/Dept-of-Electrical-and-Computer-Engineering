

clc, close all, clear all

% Εμφάνιση σχολίων και αναφορά στο m-file.
help merosA_15_14_13i

l1=length('DIMITRIOS'); % Μήκος Ονόματος l1.
l2=length('ARCHONTIS'); % Μήκος Επιθέτου l2.
 
% Υπολογισμός ω1.
ww1 = mod(10/11*(max(l1,l2))/(l1+l2),1);
w1 = pi*ww1;
 
% Υπολογισμός ω2. 
ww2 = mod(ww1+1/4,1);
w2 = pi*ww2;

L=512; % Μήκος Σήματος L = 512 Δειγμάτων.

n=0:1:L-1; % Μήκος του n.

mesosorosw1w2=(w1+w2)/2; % Μέση τιμή ω1 και ω2

d=abs((mesosorosw1w2-w1))/10;

a=[w1:d:mesosorosw1w2;w2:-d:mesosorosw1w2]; 
 
% Πλάτοι των ημιτόνων.
A1=1; 
 
A2=0.75;
 
for i=1:10
x1=A1*cos(a(1,i)*n); % Σχηματισμός 1ου Ημιτόνου
 
x2=A2*cos(a(2,i)*n); % Σχηματισμός 2ου Ημιτόνου
 
x0=x1+x2; % Σχηματισμός Σήματος x[n] χωρίς το w[n].
 
w=hamming(L); % Δημιουργία του w[n].

x=x1.*w'+x2.*w'; % Σήμα ανάλυσης x[n].

N=512; % Μήκος Διακριτού Μετ/σμού Fourier.

X=fft(x,N); % Υπολογισμός DFT

k=0:1:N-1; % Είναι N = 512 Δείγματα.

stem(k,abs(X)); % Εμφάνιση του Πλάτους του.
grid on % Σχεδιασμός γραμμών πλέγματος του γραφήματος.
title('DFT Δειγμάτων');
xlabel('Αξονας τιμών k');
ylabel('Πλάτος');
pause (1) % Pause for 1 second

 end
