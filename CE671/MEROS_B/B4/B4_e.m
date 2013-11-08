close all; clear all; clc

% phonetic /e/

p=12; % filter order
pr11a=[0 0 0 0 0];
pr11e=[0 0 0 0 0];
pr11i=[0 0 0 0 0];

for file=11:1:15;
    file_name = strcat('e_',int2str(file),'_new.wav');
    [x,fs]=wavread(file_name);

xx=double(x);
file_length=length(xx);
y=filter([1 -0.95],1,xx);
M=441;
win=floor(file_length/M);
win_num=2*win-1;
R=(M-1)/2;
N=win*M;
W=hamming(M);
Z=zeros(N,1);
cnt2=1;
s=Z;

for index=1:R:N-M;
    ndx=index+1:index+M;
    s(ndx)=s(ndx) + W;
    wzp =Z; 
    wzp(ndx)=W;
    ham=conv(y,s(ndx));
    [e,G] = lpc(ham, p);
    if file==11
        parameter1(cnt2,:)=e;
    elseif file==12
        parameter2(cnt2,:)=e;
    elseif file==13
        parameter3(cnt2,:)=e;
    elseif file==14
        parameter4(cnt2,:)=e;
    else
        parameter5(cnt2,:)=e;
    end    
    cnt2=cnt2+1;
   
end

end


 parameter1(:,1)=[];
 
 parameter2(:,1)=[];

 parameter3(:,1)=[];
 
 parameter4(:,1)=[];

 parameter5(:,1)=[];
 
 
for file=11:15
    
fileID=fopen('a_mean_p12.txt');
fileID2=fopen('a_var_p12.txt');
mesi=fscanf(fileID,'%f');
mesi_timi=mesi(2:p+1);
var=fscanf(fileID2,'%f');
var_a=var(2:p+1);
fclose(fileID);
fclose(fileID2);
Kx=diag(var_a);
Kx_i=inv(Kx);

    if file==11
       parameter= parameter1;
    elseif file==12
       parameter= parameter2;
       
    elseif file==13
       parameter= parameter3;
    elseif file==14
       parameter= parameter4;
    else
       parameter= parameter5;
  end     
  
   win_num=length(parameter(:,1));
   
   for v=1:win_num     
   fw0=((parameter(v,:))-(mesi_timi.'));
   pin=transpose(fw0);
   ekthetis=(-1./2).*fw0*Kx_i*pin;
   arithmitis=exp(ekthetis);
   paronomastis=(((2.*pi).^(p./2)).*((det(Kx).^(1./2))));
   pr1a=(arithmitis./paronomastis);
   pr11a(file-10)=pr11a(file-10)+log(pr1a);
   end 
   
   
fileID=fopen('e_mean_p12.txt');
fileID2=fopen('e_var_p12.txt');
mesi=fscanf(fileID,'%f');
mesi_timi=mesi(2:p+1);
var=fscanf(fileID2,'%f');
var_e=var(2:p+1);
fclose(fileID);
fclose(fileID2);
Kx=diag(var_e);
Kx_i=inv(Kx);

   

   for v=1:win_num  
   fw0=((parameter(v,:))-(mesi_timi.'));
   pin=transpose(fw0);
   ekthetis=(-1./2).*fw0*Kx_i*pin;
   arithmitis=exp(ekthetis);
   paronomastis=(((2.*pi).^(p./2)).*((det(Kx).^(1./2))));
   pr1e=(arithmitis./paronomastis);
   pr11e(file-10)=pr11e(file-10)+log(pr1e);
   end 
   
fileID=fopen('i_mean_p12.txt');
fileID2=fopen('i_var_p12.txt');
mesi=fscanf(fileID,'%f');
mesi_timi=mesi(2:p+1);
var=fscanf(fileID2,'%f');
var_i=var(2:p+1);
fclose(fileID);
fclose(fileID2);
Kx=diag(var_i);
Kx_i=inv(Kx); 

   

   for v=1:win_num  
   fw0=((parameter(v,:))-(mesi_timi.'));
   pin=transpose(fw0);
   ekthetis=(-1./2).*fw0*Kx_i*pin;
   arithmitis=exp(ekthetis);
   paronomastis=(((2.*pi).^(p./2)).*((det(Kx).^(1./2))));
   pr1i=(arithmitis./paronomastis);
   pr11i(file-10)=pr11i(file-10)+log(pr1i);
   end 
   
   
end

   pinakas=[pr11a; pr11e; pr11i];
   [C,I]=max(pinakas);
   for i=1:5
      
       if I(1,i)==1;
           disp('Class a')
       elseif I(1,i)==2;
           disp('Class e')
       else I(1,i)==3;
           disp('Class i')
       end
       
   end
  
