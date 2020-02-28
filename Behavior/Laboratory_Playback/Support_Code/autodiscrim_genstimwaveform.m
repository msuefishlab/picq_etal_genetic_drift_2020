function [pulsewaveform_out]=autodiscrim_genstimwaveform(stimwv,srate_wavestim,srate,reversed,no_wave)
      if no_wave==1
        pulsewaveform = 0;
      else
        %%%%%%%%%%%%%%%%%%%%%first normalizes%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        maxmin=max(stimwv)-min(stimwv);
        stimwv=stimwv./maxmin;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
        if srate==srate_wavestim,
            pulsewaveform = 10*(stimwv);
        else
            pulsewaveform = resample(stimwv,round(srate),round(srate_wavestim));
           pulsewaveform = 10*(pulsewaveform);
        end
   
      end
       if reversed==1 
        pulsewaveform = -pulsewaveform;
       end
  waveform_in=pulsewaveform;      
      
 %%center waveform     
 if (length(waveform_in)~=length(waveform_in(1,:))) %%josh addition to guar dimens
       waveform_in=waveform_in';
 end
        %[maxA,maxAind] = max(abs(waveform_in));%B
        [maxA,maxAind] = max((waveform_in));%J
        [minA,minAind] = min((waveform_in));%J
        midAind = (length(waveform_in)/2);
        %A_diff = maxAind - midAind;%B
        A_diff = (maxAind+minAind)/2 - midAind;%J
        if A_diff<0,
            waveform_in = [zeros(1,2*abs(A_diff)) waveform_in];
        elseif A_diff>0,
            waveform_in = [waveform_in zeros(1,2*abs(A_diff))]; 
        end     

        
        
pulsewaveform_out=waveform_in;