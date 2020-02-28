%autosdicrim_wavehybridizer.m
%js
clear all
close all
numwaves = input('Enter the number of waveforms to be averaged/hybridized:   ');

srates=zeros(numwaves,1);
b=0;
expernames='';

for i=1:numwaves
    %%%%%%%%%%%%%%%%%%%%%%%CRUCIAL NOTE:  ALL STIM.WAV.MAT WAVES, as part
    %%%%%%%%%%%%%%%%%%%%%%%of their creation, should already be centered
    %%%%%%%%%%%%%%%%%%%%%%%and normalized. If the waves being entered are
    %%%%%%%%%%%%%%%%%%%%%%%not, a normalization & centering protocol
    %%%%%%%%%%%%%%%%%%%%%%%comparable to the one labeled below must be
    %%%%%%%%%%%%%%%%%%%%%%%added at indicated site
[expername, experpath] = uigetfile('*.stim.wav.mat', strcat('Open waveform ',num2str(i),'...'));
load (fullfile(experpath,expername), '-mat');

if (length(stimwave)~=length(stimwave(1,:))) %%josh addition to guar dimens
       stimwave=stimwave';
end

%ensure waves properly zeroed
stimwave=stimwave-mean(stimwave(1:(floor(end/10))));

if(i==1)
    srates(i)=srate;
    b=length(stimwave);
    stimwaves=zeros(numwaves,b);
    stimwaves(i,:)=stimwave;
    disp(strcat('Wave ',num2str(i),'/',num2str(numwaves),' successfully loaded.'))
else
    if(srate==srates(1)&&length(stimwave)==b)
        srates(i)=srate;
        stimwaves(i,:)=stimwave;
        disp(strcat('Wave ',num2str(i),'/',num2str(numwaves),' successfully loaded.'))
    elseif(srate==srates(1))%%same sample rate but diff length; zeropad
        lengthdiff=length(stimwave)-b;
        
        if(lengthdiff<0)
            size(zeros(1,floor((-lengthdiff)/2)))
            size(stimwave)
            size(zeros(1,ceil((-lengthdiff)/2)))
            stimwave1 = [zeros(1,floor((-lengthdiff)/2)) stimwave zeros(1,ceil((-lengthdiff)/2))];
            stimwaves(i,:)=stimwave1;
        else%%zeropad stimwaves
            stimwaves = [zeros(i-1,floor((lengthdiff)/2)) stimwaves zeros(i-1,ceil((lengthdiff)/2))];
            stimwaves(i,:)=stimwave;
            b=length(stimwave);
        end
        
        
    else
        disp(strcat('Srates:  ',num2str(srates(1)),' Current Srate (wave ',num2str(i),'): ',num2str(srate)))
        disp(strcat('Waves'' Length:  ',num2str(b),' Current Wave Length (wave ',num2str(i),'): ',num2str(length(stimwave))))
        error('Length or Rate Inconsistency. Will need to update program to account for this. Try resampling to adjust necessary waves')
        break;
    end
    
end
expernames=strvcat(expernames,expername);
end
stimwave=[];
srate=[];

%Normalization and centering (see below) must be added here if not already
%preformed (see above)

equal = input(strcat('You have loaded',num2str(numwaves),' waves. Would you like to weight them equally? (enter 1 for yes, 0 for no):   '));

if (equal==1)
    stimwave=mean(stimwaves);
    srate=srates(1);
    relativedec=zeros(numwaves,1);
    relativedec=relativedec+(1/numwaves)

else
    weights=zeros(numwaves,1);
    for i=1:numwaves
        weights(i) = input(strcat('Enter weight for wave number ',num2str(numwaves),':   '));
    end
    relativedec=weights./sum(weights)
    for i=1:numwaves
        weightedstimwaves(i,:) = stimwaves(i,:).*relativedec(i);
    end
    stimwave=mean(weightedstimwaves);
    srate=srates(1);
end

wave1=stimwave;
n_pts1=b;
s_rate1=srate;        
%normalize
        maxmin=max(wave1)-min(wave1);
        wave1=wave1./maxmin;
%lower wave to zero
    st=mean(wave1(200:250));
    wave1=wave1-st;  

%center waveform & return to orginal size
     if (length(wave1)~=length(wave1(1,:))) %%josh addition to guar dimens
       wave1=wave1';
 end
        [maxA,maxAind] = max((wave1));
        [minA,minAind]=min(wave1);
        if(maxAind>minAind)
            wave1=-wave1;
            [maxA,maxAind] = max((wave1));
            [minA,minAind]=min(wave1);
        end
        midAind = (length(wave1)/2);
        A_diff = (maxAind+minAind)/2 - midAind;
        if A_diff<0,
            wave1 = [zeros(1,2*abs(A_diff)) wave1];
        elseif A_diff>0,
            wave1 = [wave1 zeros(1,2*abs(A_diff))]; 
        end    
        
        newnpts=length(wave1)
        
       if (newnpts~=n_pts1)
           diffpts=newnpts-n_pts1;
           wave1=wave1(diffpts/2:end-diffpts/2);
       end
       if (length(wave1)>n_pts1)
           wave1=wave1(1:end-1);
       end

    stimwave=wave1;
       
     plot(stimwave,'k')  
    hold on   
     plot(stimwave,'m--')
    plot(stimwaves')
   titlestring='';
   for i=1:numwaves
       titlestring=strcat(titlestring,' W',num2str(i),'-',expernames(i,:),'-',num2str(relativedec(i)));
   end
   title(titlestring)
   expernames
   %lengend((strcat('Mean', expernames)))
   saver = input(strcat('Would you like to save this hybrid wave? (enter 1 for yes, 0 for no):   '));
   if(saver==1)
       titlestring(isspace(titlestring))='_';
       [FileName,PathName,FilterIndex] = uiputfile('*.mat','Select the save location and name');
       save(fullfile(PathName,FileName),'stimwave','srate')
   end
       
    