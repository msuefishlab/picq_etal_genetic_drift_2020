%modified from eod2mat--by Dr. C. Hopkins
function [wavex]=autodiscrim_createx(y, phi)
%s=get(handles.edit1,'String');
%phase=str2num(s);
if (phi <-360 | phi >360) 
    set(handles.testprogress,'String','ABORTED');
    error ('Phase angle not between -360 and +360')
end
%PHASESHIFTEOD      phase shift an eod waveform, y, by an amount phi (in degrees)
%   y2=phaseshifteod(y,phi)
%   for vectors, phaseshift(y,phi) computes a new vector which is phase
%   shifted by angle, phi, in degrees.  
%   Default value of phi is 0 degrees.
%   First the FFT is computed for y;  phi is added to
%   the positive frequencies, phi is subtracted from the negative frequencies
%   before the inverse fourier transform is calculated. 
%   C. D. Hopkins (July 10, 2010)

y=y';%%%%%%%%%%%%%%%%josh addition

n=length(y);
%do the fft
Y = fft(y);
%get the mag and angle
M = abs(Y);    %magnitude of wave spectrum
A=angle(Y);  %phase angle of wave spectrum 
shft = phi*2*pi/360;
%DC component
AN(1)=A(1);  %new angle
%f=fmax component
n/2+1
AN(n/2+1)=A(n/2+1); %new angle
%positive frequencies (index=2:n/2) then negative frrequencies
AN(2:(n/2)) = A(2:(n/2))+shft;  %add the phase angle from all of the positive frequencies.
AN((n/2+2):n) = A((n/2+2):n) - shft ;

%rebuild the complex spectrum
YN=M.*exp(i*AN');  %new wave fft
%inverse transform
wavex = real(ifft(YN));

