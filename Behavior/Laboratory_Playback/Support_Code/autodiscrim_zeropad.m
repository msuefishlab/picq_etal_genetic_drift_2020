function [waveout,waveout2,npts]= autodiscrim_zeropad(wavein,wavein2)
length_o = length(wavein);
length_o2 = length(wavein2);
waveout=[];
waveout2=[];
if length_o2>length_o,
    waveout = [zeros(1,floor((length_o2-length_o)/2)) wavein zeros(1,ceil((length_o2-length_o)/2))];
    waveout2=wavein2;
elseif length_o2<length_o,
    waveout2 = [zeros(1,floor((length_o-length_o2)/2)) wavein2 zeros(1,ceil((length_o-length_o2)/2))];
    waveout=wavein;
else
    waveout=wavein;
    waveout2=wavein2;
end
length_o = length(waveout);
length_o2 = length(waveout2);
npts = length_o;