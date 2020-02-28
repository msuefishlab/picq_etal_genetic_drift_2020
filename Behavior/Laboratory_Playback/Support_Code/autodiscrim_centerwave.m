function [waveform_out]=autodiscrim_centerwave(waveform_in)

if (length(waveform_in)~=length(waveform_in(1,:))) %%josh addition to guar dimens
            waveform_in=waveform_in';
        end
        [maxA,maxAind] = max(abs(waveform_in));
        midAind = (length(waveform_in)/2);
        A_diff = maxAind - midAind;
        if A_diff<0,
            waveform_in = [zeros(1,2*abs(A_diff)) waveform_in];
        elseif A_diff>0,
            waveform_in = [waveform_in zeros(1,2*abs(A_diff))]; 
        end
 waveform_out=waveform_in;