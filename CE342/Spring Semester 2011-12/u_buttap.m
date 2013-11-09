function [b,a] = u_buttap(N,Omegac); 
[z,p,k] = buttap(N); 
    p = p*Omegac; 
    k = k*Omegac^N; 
    B = real(poly(z)); 
    b0 = k; 
    b = k*B; 
    a = real(poly(p)); 
