%%%
%%% DSP TERM PROJECT - SPRING 2018
%%%         APRIL 30, 2018
%%%            PART B
%%%

% Initialize the program
clc;
clear all;
close all;
load speech_scmb_1;

% Variable Definitations
% x is the given scrabmeld voice signal (folded)

voice = x;
n = 1:1103547;
w = n;

% Define a cosine carrier with frequency of
% 0.15pi and multiply it with the original 
% voice signal to refold the spectrum

carrier = cos(0.15*pi*n);
carrier = carrier';
v = voice.*carrier;

% Pass the unfolded signal through low pass filter

lpf1 = zeros(1103547, 1);
for xd = 2:1103547
   lpf1(xd)=0.1717*v(xd)+0.8283*lpf1(xd-1);
end

% Second stage low pass filter

lpf2 = lpf1;
for xd = 2:1103547
   lpf2(xd)=0.1717*v(xd)+0.8283*lpf2(xd-1);
end

% Third stage low pass filter

lpf3 = lpf2;
for xd = 2:1103547
   lpf3(xd)=0.1717*v(xd)+0.8283*lpf3(xd-1);
end

% Intialize the audio player with suitable parameters

z = lpf3;
Fs = 44100;
gt = 1.755*100000;
nm = (norm(z)^2);
gain = sqrt(gt/nm);
zz = z*gain;
player = audioplayer(zz, Fs);

% Play the signal
play(player);

% Plot the given scrambled signal in time domain
subplot(4,1,1)
plot(n, voice)
title('Given scrambled voice signal in time domain')
xlabel('n')
ylabel('amplitude')

% Plot the given scrambled signal in frequency domain

subplot(4,1,2)
plot(w, fft(voice))
title('Given scrambled voice signal in frequency domain')
xlabel('\omega')
ylabel('amplitude')

% Plot the processed voice signal in time domain

subplot(4,1,3)
plot(n,lpf3)
title('Descrambled voice signal in time domain after filterization')
xlabel('n')
ylabel('amplitude')

% Plot the processed voice signal in frequency domain

subplot(4,1,4)
plot(w, fft(lpf3))
title('Descrambled voice signal in frequency domain after filterization')
xlabel('\omega')
ylabel('amplitude')