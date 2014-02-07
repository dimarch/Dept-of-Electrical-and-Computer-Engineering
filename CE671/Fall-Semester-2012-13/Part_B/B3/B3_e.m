
% phonetic /e/

p=12;
Sf=zeros(1,p+1);
Sf2=zeros(1,p+1);
windows=0;
fw0=zeros(1,p+1);


for file=1:1:10;
    file_name = strcat('e_',int2str(file),'_new.wav');
    [y1,fs]=wavread(file_name);

file_length=length(y1);
y=filter([1 -0.95],1,y1);
M=441;
win_num=floor(file_length/M);
R=(M-1)/2;
N=win_num*M;
W=hamming(M);
Z=zeros(N,1);
%plot(Z,'-k');
%hold on;


s=Z;
i=1;

for index=1:R:N-M;
    ndx=index+1:index+M;
    s(ndx)=s(ndx) + W;
    wzp =Z; 
    wzp(ndx)=W;
    ham=conv(y,s(ndx));
    [e,G] = lpc(ham, p);
%     e = filter(e,1,wzp(ndx)); % Computer residual error signal
%     G = sqrt(G);
%     e = e/G;
    parameter(i,:)=e;
    i=i+1;
    %  plot(wzp,'--ok');
   
end
  Sf=Sf+sum(parameter);
  windows=Sf(1,1);
  Sf2=Sf2+sum(parameter.^2);

  e_12=strcat('e',int2str(file),'_p12.txt');
  FID=fopen(e_12,'w');
  fprintf(FID,' %f',e);
  fclose(FID);
	

ndx=880;
ham2=conv(s(ndx),y);

Fs = 22000;   % Sampling Frequency (Hz)

figure(2);

subplot(3,1,1);
t=1:file_length;


plot(t,ham2);
title('phonetic /e/');
xlabel('samples'); ylabel('ham2'); 
grid on;
    
end


x = fft(ham2);

% Get response until Fs/2 (for frequency from Fs/2 to Fs, response is repeated)
x = x(1:floor(length(x)/2));

% Plot magnitude vs. frequency
subplot(3,1,2);
m = abs(x);
f = (0:length(x)-1).*(Fs/2)./length(x);


plot(f,m);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

k=440;
%Vector e1 with elements of e + zeros
e1=zeros(1,(k-p-1));
e2=[e,e1];

%Dimiourgia all-pole transfer function
m1=0 : length(e2)-1;
k1=1:k;
w1=pi*k1/k;
num=1/k;

den=1-(e2*exp(-j*m1'*w1));
%Transfer Function
H=num./den;
%Metro tis Synartisis Metaforas
magH=abs(H);

%Sxediasmos Transfer Function



subplot(3,1,3);
plot(w1/pi,magH);
ylabel('Magnitute');
xlabel('Frequency');
grid on;

mesi_timi=Sf./(windows);
var_e=(Sf2./windows)-((mesi_timi).^2);

e_mean=strcat('e_mean','_p12.txt');
FID=fopen(e_mean,'w');
fprintf(FID,' %f',mesi_timi);
fclose(FID);
	
e_var=strcat('e_var','_p12.txt');
FID=fopen(e_var,'w');
fprintf(FID,' %f',var_e);
fclose(FID);