clc, close all, clear all

l1=length('DIMITRIOS'); % 
l2=length('ARCHONTIS'); % 
 

ww1 = mod(10/11*(max(l1,l2))/(l1+l2),1);
w1 = pi*ww1;
 

ww2 = mod(ww1+1/4,1);
w2 = pi*ww2;

L=256; % 

n=0:1:L-1; % 
 

A1=1; 
 
A2=0.75;
 
x1=A1*cos(w1*n); % 
 
x2=A2*cos(w2*n); %
 
x0=x1+x2; % 
 
w=(ones(1,L)); % 

x=x1.*w+x2.*w; % 

N=256; % 

X=fft(x,N); %

% 
subplot(2,1,1)

% 
stem(n,x); % 
axis([0,255,-2,2]); % 
grid on % 
title('Arxiko Sima x[n]');
xlabel('Aksonas Timwn n');

k=0:1:N-1; % Είναι N = 256 Δείγματα.

% Έχοντας χωρισμένο το παράθυρο, χρησιμοποιώ το 2ο Παράθυρο.
subplot(2,1,2)

stem(k,abs(X)); % Εμφάνιση του Πλάτους του.
axis([0,255,0,130]); % Κλίμακα αξόνων
grid on % Σχεδιασμός γραμμών πλέγματος του γραφήματος.
title('DFT Deigmatwn');
xlabel('Aksonas Timwn k');
ylabel('Platos');
