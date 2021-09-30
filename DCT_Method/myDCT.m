function[]=myDCT()  %my compression function

%read the original  file and convert it to a variable
[x, f] =audioread('original.m4a');

%chosing a block size 
windowSize = 8192;

%changing compression  percentages
samplesHalf = windowSize / 2;
samplesQuarter = windowSize / 4;
samplesEighth = windowSize / 8;

%initializing compressed matrices
xCompressed2 = [];
xCompressed4 = [];
xCompressed8 = [];

%actual compression processing
for i=1:windowSize:length(x)-windowSize
    windowDCT = dct(x(i:i+windowSize-1));
    xCompressed2(i:i+windowSize-1) = idct(windowDCT(1:samplesHalf), windowSize);
    xCompressed4(i:i+windowSize-1) = idct(windowDCT(1:samplesQuarter), windowSize);
    xCompressed8(i:i+windowSize-1) = idct(windowDCT(1:samplesEighth), windowSize);
end

%plotting signals
figure(1)
h1 = subplot(2,1,1);
plot(x), title('Original ');
subplot(2,1,2)
plot(xCompressed2), title('Compression Factor 2'), axis(axis(h1));
pause(2);
figure(2)
h2 = subplot(2,1,1);
plot(xCompressed4), title('Compression Factor 4'), axis(axis(h2));
subplot(2,1,2)
plot(xCompressed8), title('Compression Factor 8'), axis(axis(h2));

%playing files
%original audio
sound(x,f,16);
pause(10);
%compressed signal 1 
sound(xCompressed2,f,16);
pause(10);
%compressed signal 2 
sound(xCompressed4,f,16);
pause(10);
%compressed signal 3
sound(xCompressed8,f,16);
pause(10);

%saving audio files
audiowrite('Compressed file factor 2.m4a',xCompressed2,f);
audiowrite('Compressed file factor 4.m4a',xCompressed4,f);
audiowrite('Compressed file factor 8.m4a',xCompressed8,f);








end