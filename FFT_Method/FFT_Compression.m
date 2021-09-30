
%read (import) the original  file and convert it to a variable
[x,fs]= audioread('original_file.m4a');
%signal at a specified level 
N=length(x); %time*fs;
time=N/fs;
t=linspace(0,time,N);
%plotting the original signal in time domain
figure(1);
plot(t,x);
grid;
xlabel('time');
ylabel('Amplitude');
% play original file
sound(x,fs,16); 

% wait 10 seconds
pause(10);

%  fft convert the signal form time domain to frequency domain
X_K=fft2(x);
f=linspace(0,fs,N);

%plotting the signal in frequency domain
figure(2);
plot(f,X_K);
grid;
title('Amplitude spectrum pf x(t)');
xlabel('frequency(Hz)');
ylabel(' |x(f)|');


%quantization (decomposition of signal)& compressing and getting rid of noise
for thresh = 0.3 * 0.1 * max(abs(X_K(:))); 
ind = abs(X_K)>thresh;
xFilt=X_K.*ind;
count=N-sum(ind(:));
percent = 100-count/N*100; % how many frequencies remaining

%  ifft convert the signal form frequency domain to time domain
xFF=ifft2(xFilt);

end
%plotting the signal after compressing
figure(3), plot(t,xFF,'color', 'b');
xlabel('time');
ylabel('Amplitude');
grid;

%playin the signal after compressing
sound(xFF,fs,16);

%saving the compressed file
audiowrite('compressed_file_FFT.m4a',xFF,fs);





