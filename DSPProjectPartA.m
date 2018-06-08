%%%
%%% DSP TERM PROJECT - SPRING 2018
%%%         APRIL 30, 2018
%%%             PART A
%%%


% Initialize the program

clc
clear all;
close all;

% Variable Definitations

n = 0:20;
w = 0:0.05*pi:pi;
wn = w.*n;
test = cos(wn);

% Initial conditions

y = zeros(1, 21);
y(1) = 0.147*test(1);
y(2) = 0.147*test(1) + 1.4195*y(1);

% Pass through the filter

for index = 3:21
   y(index) = 0.147*test(index) - 1.4195*y(index - 1) + 0.74*y(index - 2);
end

% Figures

figure('Name','Input Signal','NumberTitle','off');

subplot(2,1,1)
plot1 = plot(w, test);
title('Input Signal \it{cos(\omegan)} - Time Domain ')
xlabel('Angular Frequency \omega')
ylabel('\it{cos(\omegan)}')

subplot(2,1,2)
plot(w, abs(fft(test)))
title('Input Signal \it{cos(\omegan)} - Frequency Domain')
xlabel('Angular Frequency \omega')
ylabel('Amplitude')


figure('Name','Output Signal','NumberTitle','off');

subplot(2,1,1)
plot(w, y)
title('Output Signal - Time Domain')
xlabel('Angular Frequency \omega')
ylabel({'y(n) = 0.147x(n)-','1.4195y(n-1)+','0.74y(n-2)'})

subplot(2,1,2)
plot(w, abs(fft(y)))
title('Output Signal - Frequency Domain')
xlabel('Angular Frequency \omega')
ylabel('Apmlitude')


figure('Name', 'Gain', 'NumberTitle', 'off');

plot(w, y./test)
title('Gain ^{V_{out}}/_{V_{in}} - Time Domain')
xlabel('Angular Frequency \omega')
ylabel('^{V_{out}}/_{V_{in}}')

figure('Name', 'Frequency Response', 'NumberTitle', 'off');
freqz(0.147, [1 -1.419 0.74])
