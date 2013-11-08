% /a/ /e/ /i/
max_dim=0;
InputC = input('Enter Symbol for input No(a,e,i)-','s');
for j=1:15

input_file_name = strcat(InputC,'_', int2str(j),'_new.wav');% signal
%input_file_name = eval(char(InputIn));

%input_file_name = 'a_1_new.wav';
%input_file_name = 'e_1_new.wav';
%input_file_name = 'i_1_new.wav';

[x,Fs] = wavread(input_file_name); % speech
x=x(:,1); % get the first channel
x = x.';
%%

% The signal is windowed
    winLen = 440; % 22000 * 0.02 (20ms)
    winOverlap = 220;
    wHamm = hamming(winLen);
    
    preemph = [1 0.95];
    filtered = filter(1,preemph,x);
    
    % Framing and windowing the signal without for loops.
    sigFramed = buffer(filtered, winLen, winOverlap, 'nodelay');
    
  
    % apply hamming
    for i=1:size(sigFramed,2)
        sigFramed(:,i)=sigFramed(:,i).*wHamm;
    end
    if size(sigFramed,2)> max_dim
        max_dim=size(sigFramed,2);
    end

%%
% Lpc autocorrelation method
order = 12;

% LPC function of MATLAB is used
eval(['[lpcoefs_' InputC int2str(j) ', errorPow] = lpc(sigFramed, order);']);

end
