%
%   stim1playback_novel_playrec_mobile.m
%       Generates stimulus and records responses for stim1playback_novel_mobile.m
%

%% Clear data
eodtimes = [];
cla(handles.axes_responseplot)

%% Load circuit and start to run
RM1 = actxcontrol('RPco.x',[5 5 26 26]);
RM1.ConnectRM1('USB', 1);
if isdir('N:\')==1,
    RM1.LoadCOF('N:\MATLAB\Mobile Processor\stim1playback_novel_playrec_mobile.rcx');
elseif isdir ('C:\Documents and Settings\All Users\Documents\Matlab\Mobile Processor\')==1,
    RM1.LoadCOF('C:\Documents and Settings\All Users\Documents\Matlab\Mobile Processor\stim1playback_novel_playrec_mobile.rcx');
else
    RM1.LoadCOF('C:\Users\Bruce Carlson\Documents\MATLAB\Mobile Processor\stim1playback_novel_playrec_mobile.rcx');
end
srate = RM1.GetSFreq;
RM1.Run;
pause(10)    % pausing to avoid effect of transient noise at circuit startup

%% Check for errors
status = double(RM1.GetStatus);     % Gets the status
if bitget(status,1)==0;             % Checks for connection
    disp('Error connecting to RM1'); return;
elseif bitget(status,2)==0;     % Checks for errors in loading circuit
    disp('Error loading circuit'); return;
elseif bitget(status,3)==0      % Checks for errors in running circuit
    disp('Error running circuit'); return;
end

%% Determine types of pulses
pulse_type_array = get(handles.popupmenu_Apulsetype, 'String');
pulsetype_A = char(pulse_type_array(get(handles.popupmenu_Apulsetype, 'Value')));
pulse_type_array = get(handles.popupmenu_Bpulsetype, 'String');
pulsetype_B = char(pulse_type_array(get(handles.popupmenu_Bpulsetype, 'Value')));

%% Generate Stimulus Waveform A
switch pulsetype_A
    case 'Load Waveform File'
        pulsedur_A = [];
        set(handles.edit_Apulsedur,'String',pulsedur_A)
        if srate==srate_wavstim_A,
            pulsewaveform_A = 10*(stimwave_A./(max(stimwave_A)-min(stimwave_A)));
        else
            pulsewaveform_A = resample(stimwave_A,round(srate/10),round(srate_wavstim_A/10));
            pulsewaveform_A = 10*(pulsewaveform_A./(max(pulsewaveform_A)-min(pulsewaveform_A)));
        end
    case 'No Waveform'
        pulsedur_A = [];
        set(handles.edit_Apulsedur,'String',pulsedur_A)
        pulsewaveform_A = 0;
    otherwise
        pulsedur_A = str2num(get(handles.edit_Apulsedur,'String'));
        if isempty(pulsedur_A)==1,
            set(handles.togglebutton_playrec,'ForegroundColor',[1 1 1]);
            set(handles.togglebutton_playrec,'Value',0);
            error('Enter A Pulse Duration!!!');
        end
        [pulsewaveform_A] = genstimwaveform(pulsetype_A,pulsedur_A,srate);
end
pulse_pol_array = get(handles.popupmenu_Apulsepol, 'String');
pulsepol_A = char(pulse_pol_array(get(handles.popupmenu_Apulsepol, 'Value')));
switch pulsepol_A
    case 'Reversed'
        pulsewaveform_A = -pulsewaveform_A;
end

%% Generate Stimulus Waveform B
switch pulsetype_B
    case 'Load Waveform File'
        pulsedur_B = [];
        set(handles.edit_Bpulsedur,'String',pulsedur_B)
        if srate==srate_wavstim_B,
            pulsewaveform_B = 10*(stimwave_B./(max(stimwave_B)-min(stimwave_B)));
        else
            pulsewaveform_B = resample(stimwave_B,round(srate/10),round(srate_wavstim_B/10));
            pulsewaveform_B = 10*(pulsewaveform_B./(max(pulsewaveform_B)-min(pulsewaveform_B)));
        end
    case 'No Waveform'
        pulsedur_B = [];
        set(handles.edit_Bpulsedur,'String',pulsedur_B)
        pulsewaveform_B = 0;
    otherwise
        pulsedur_B = str2num(get(handles.edit_Bpulsedur,'String'));
        if isempty(pulsedur_B)==1,
            set(handles.togglebutton_playrec,'ForegroundColor',[1 1 1]);
            set(handles.togglebutton_playrec,'Value',0);
            error('Enter Novel Pulse Duration!!!');
        end
        [pulsewaveform_B] = genstimwaveform(pulsetype_B,pulsedur_B,srate);
end
pulse_pol_array = get(handles.popupmenu_Bpulsepol, 'String');
pulsepol_B = char(pulse_pol_array(get(handles.popupmenu_Bpulsepol, 'Value')));
switch pulsepol_B
    case 'Reversed'
        pulsewaveform_B = -pulsewaveform_B;
end

%% Center waveforms on peaks
switch pulsetype_A
    case 'Load Waveform File'
        [maxA,maxAind] = max(abs(pulsewaveform_A));
        midAind = (length(pulsewaveform_A)/2);
        A_diff = maxAind - midAind;
        if A_diff<0,
            pulsewaveform_A = [zeros(1,2*abs(A_diff)) pulsewaveform_A];
        elseif A_diff>0,
            pulsewaveform_A = [pulsewaveform_A zeros(1,2*abs(A_diff))];
        end
end
switch pulsetype_B
    case 'Load Waveform File'
        [maxB,maxBind] = max(abs(pulsewaveform_B));
        midBind = (length(pulsewaveform_B)/2);
        B_diff = maxBind - midBind;
        if B_diff<0,
            pulsewaveform_B = [zeros(1,2*abs(B_diff)) pulsewaveform_B];
        elseif B_diff>0,
            pulsewaveform_B = [pulsewaveform_B zeros(1,2*abs(B_diff))];
        end
end

%% Zero pad shorter of 2 waveforms and get total number of sample points
length_A = length(pulsewaveform_A);
length_B = length(pulsewaveform_B);
if length_B>length_A,
    pulsewaveform_A = [zeros(1,floor((length_B-length_A)/2)) pulsewaveform_A zeros(1,ceil((length_B-length_A)/2))];
elseif length_B<length_A,
    pulsewaveform_B = [zeros(1,floor((length_A-length_B)/2)) pulsewaveform_B zeros(1,ceil((length_A-length_B)/2))];
end
length_A = length(pulsewaveform_A);
length_B = length(pulsewaveform_B);
pulsenpts = length_A;

%% Set attenuation
pulseatt = str2num(get(handles.edit_pulseatt,'String'));
if isempty(pulseatt)==1,
    set(handles.togglebutton_playrec,'ForegroundColor',[1 1 1]);
    set(handles.togglebutton_playrec,'Value',0);
    error('Enter Pulse Attenuation!!!');
elseif pulseatt<20,
    set(handles.togglebutton_playrec,'ForegroundColor',[1 1 1]);
    set(handles.togglebutton_playrec,'Value',0);
    error('Pulse Amplitude Cannot Exceed 1V!!!')
else
    pulsewaveform_A = (10^(-pulseatt/20)).*(pulsewaveform_A);
    pulsewaveform_B = (10^(-pulseatt/20)).*(pulsewaveform_B);
end

%% Assign pulses to background/novel
pulse_train_array = get(handles.popupmenu_pulsetrain, 'String');
pulsetrain = char(pulse_train_array(get(handles.popupmenu_pulsetrain, 'Value')));
switch pulsetrain
    case 'Select'
        set(handles.togglebutton_playrec,'ForegroundColor',[1 1 1]);
        set(handles.togglebutton_playrec,'Value',0);
        error('Choose Train Type!!!');
    case 'A Train'
        pulsewaveform_back = pulsewaveform_A;
        pulsetype_back = pulsetype_A;
        pulsedur_back = pulsedur_A;
        pulsepol_back = pulsepol_A;
        pulsewaveform_novel = pulsewaveform_A;
        pulsetype_novel = pulsetype_A;
        pulsedur_novel = pulsedur_A;
        pulsepol_novel = pulsepol_A;
    case 'B Train'
        pulsewaveform_back = pulsewaveform_B;
        pulsetype_back = pulsetype_B;
        pulsedur_back = pulsedur_B;
        pulsepol_back = pulsepol_B;
        pulsewaveform_novel = pulsewaveform_B;
        pulsetype_novel = pulsetype_B;
        pulsedur_novel = pulsedur_B;
        pulsepol_novel = pulsepol_B;
    case 'A Train/B Insert'
        pulsewaveform_back = pulsewaveform_A;
        pulsetype_back = pulsetype_A;
        pulsedur_back = pulsedur_A;
        pulsepol_back = pulsepol_A;
        pulsewaveform_novel = pulsewaveform_B;
        pulsetype_novel = pulsetype_B;
        pulsedur_novel = pulsedur_B;
        pulsepol_novel = pulsepol_B;
    case 'B Train/A Insert'
        pulsewaveform_back = pulsewaveform_B;
        pulsetype_back = pulsetype_B;
        pulsedur_back = pulsedur_B;
        pulsepol_back = pulsepol_B;
        pulsewaveform_novel = pulsewaveform_A;
        pulsetype_novel = pulsetype_A;
        pulsedur_novel = pulsedur_A;
        pulsepol_novel = pulsepol_A;
end

%% Get total number of pulses
totalpulsenum = str2num(get(handles.edit_totalpulsenum,'String'));
if isempty(totalpulsenum)==1,
    set(handles.togglebutton_playrec,'ForegroundColor',[1 1 1]);
    set(handles.togglebutton_playrec,'Value',0);
    error('Enter Total Pulse Number!!!');
end

%% Determine which pulse to make novel
novelpulsenum = str2num(get(handles.edit_novelpulsenum,'String'));
if isempty(novelpulsenum)==1,
    set(handles.togglebutton_playrec,'ForegroundColor',[1 1 1]);
    set(handles.togglebutton_playrec,'Value',0);
    error('Enter Novel Pulse Number!!!');
end
if novelpulsenum>totalpulsenum,
    set(handles.togglebutton_playrec,'ForegroundColor',[1 1 1]);
    set(handles.togglebutton_playrec,'Value',0);
    error('Novel Pulse Number Cannot be Greater than Total Pulse Number!!!');
end

%% Get pulse intervals
pulseint = str2num(get(handles.edit_pulseint,'String'));
if isempty(pulseint)==1,
    set(handles.togglebutton_playrec,'ForegroundColor',[1 1 1]);
    set(handles.togglebutton_playrec,'Value',0);
    error('Enter Pulse Interval!!!');
end

%% Get burst intervals
burstint = str2num(get(handles.edit_burstint,'String'));

%% Create pulse interval sequence
if isempty(burstint)==1,
    stimints = [0 genstimsequence('Constant Interval',totalpulsenum,pulseint)];
    novelstart = novelpulsenum;
    novelend = novelpulsenum;
else
    stimints = 0;
    burstseq = [repmat(pulseint,1,9)];
    for i=1:totalpulsenum-1,
        stimints = [stimints burstseq burstint];
    end
    stimints = [stimints burstseq];
    novelstart = ((novelpulsenum-1)*10)+1;
    novelend = novelpulsenum*10;
end
stimints_current = stimints;

%% Get input variables
prestimdur = str2num(get(handles.edit_prestimdur,'String'));
pststimdur = str2num(get(handles.edit_pststimdur,'String'));
sdur = (prestimdur + pststimdur + (sum(stimints_current)/1000))*1000;
trialint = str2num(get(handles.edit_trialint, 'String'));
thold = str2num(get(handles.edit_threshold, 'String'));
setnumreps = str2num(get(handles.edit_setnumreps, 'String'));
if ((isempty(setnumreps)==1)|(setnumreps==0)),
    setnumreps = Inf;
end
if trialint<(prestimdur + pststimdur + (sum(stimints_current)/1000)),
    trialint = prestimdur + pststimdur + (sum(stimints_current)/1000);
    set(handles.edit_trialint, 'String', num2str(trialint));
end

%% Set number of sample points
npts = ceil((sdur*srate)/1000);                         % number of points in sample

%% Record Data
if all(bitget(RM1.GetStatus,1:3))
    
    % Send information to RM1
    RM1.SetTagVal('threshold',thold);
    RM1.SetTagVal('prestimdur',(prestimdur*1000)-1);
    RM1.WriteTagV('stimints',0,stimints);
    RM1.SetTagVal('numints',length(stimints));
    RM1.SetTagVal('novelstart',novelstart);
    RM1.SetTagVal('novelend',novelend);
    RM1.SetTagVal('bufsize',pulsenpts);
    RM1.WriteTagV('waveback', 0, pulsewaveform_back);
    RM1.WriteTagV('wavenovel', 0, pulsewaveform_novel);

    % Run
    numreps = 0;
    while stim_run == 1,
        
        % Increment the number of repetitions
        numreps = numreps+1;
     
        % Trigger stimulation
        RM1.SoftTrg(1);
        
        % Collect data
        curindex=RM1.GetTagVal('curindex');
        eodtimes_currep=double(RM1.ReadTagVEX('eodtimes', 0, curindex, 'I32', 'I32', 1))./srate;
        while ((max(eodtimes_currep)<(prestimdur + pststimdur + (sum(stimints_current)/1000)))|isnan(eodtimes_currep)==1),
            curindex=RM1.GetTagVal('curindex');
            eodtimes_currep=double(RM1.ReadTagVEX('eodtimes', 0, curindex, 'I32', 'I32', 1))./srate;
        end
        eodtimes_currep = eodtimes_currep - prestimdur;
        if numreps==1,
            eodtimes = eodtimes_currep;
        else
            [a,b] = size(eodtimes);
            c = length(eodtimes_currep);
            if c<b,
                eodtimes_currep(c+1:b)= NaN;
            elseif c>b,
                eodtimes(1:a,b+1:c) = NaN;
            end
            eodtimes(numreps,:) = eodtimes_currep;
        end

        % Plot the response
        stim1playback_plot

        % Determine whether to continue
        pause(0.01)
        if numreps==setnumreps,
            set(handles.togglebutton_playrec,'Value',0);
            set(handles.togglebutton_playrec,'ForegroundColor',[1 1 1]);
        end
        button_state = get(handles.togglebutton_playrec,'Value');
        if button_state==get(handles.togglebutton_playrec,'Min'),
            stim_run = 0;
        else
            pause(trialint-(prestimdur + pststimdur + (sum(stimints_current)/1000)))
        end
    end
    
    zoom reset
    zoom on
    
    % Stop
    RM1.Halt;
    
    % Play Beep
    tone_time = [0:1/srate:0.02];
    end_tone = sin(2*pi*1000*tone_time);
    sound(end_tone,srate)
end