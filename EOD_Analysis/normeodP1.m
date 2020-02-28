function [nwave] = normeodP1(wave)
%%%%%%%%%%
%normeodp1.m
%normalizes a wave to 0 baseline voltage
%1.0 peak to peak voltage difference
%and centers the time base on P1
%%%%%%%%%%
baseline = mean(wave(1:100)); %changed to 100 JRG
wave = wave-baseline;
[ymax,ivmax] = max(wave);
[ymin,ivmin] = min(wave);
nwave = wave/(ymax-ymin);
%time = time - (time(ivmax));
