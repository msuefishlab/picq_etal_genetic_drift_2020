%
%   autodiscrim_mobile.m
%       Generates stimulus and records responses for stim1playback_novel_mobile.m
%       adapted from stim1playback_novel_playrec_mobile from Dr. B. Carlson

%% Clear data
eodtimes = [];
%cla(handles.axes_responseplot)

%% Load circuit and start to run
RM1 = actxcontrol('RPco.x',[5 5 26 26]);
RM1.ConnectRM1('USB', 1);
%if isdir('N:\')==1,
%    RM1.LoadCOF('N:\Matlab\Mobile Processor\stim1playback_novel_playrec_mobile.rcx');
%else
%    RM1.LoadCOF('C:\Documents and Settings\Carlson Lab\My Documents\Matlab\Mobile Processor\stim1playback_novel_playrec_mobile.rcx');
%RM1.LoadCOF('E:\Documents and Settings\Carl\My Documents\MATLAB\work-josh\stim1playback_novel_playrec_mobile.rcx');
RM1.LoadCOF('C:\Documents and Settings\Hopkins\My Documents\MATLAB\work-josh\autodiscrim_mobile.rcx');
%end
srate = RM1.GetSFreq;
RM1.Run;
pause(10)    % pausing to avoid effect of transient noise at circuit startup

%% Check for errors
status = double(RM1.GetStatus);     % Gets the status;  changed to lowercase
if bitget(status,1)==0;             % Checks for connection
    disp('Error connecting to RM1');set(handles.testprogress,'String','ABORTED'); return;
elseif bitget(status,2)==0;     % Checks for errors in loading circuit
    disp('Error loading circuit');set(handles.testprogress,'String','ABORTED'); return;
elseif bitget(status,3)==0      % Checks for errors in running circuit
    disp('Error running circuit');set(handles.testprogress,'String','ABORTED'); return;
end

% %% Determine types of pulses
% pulse_type_array = get(handles.popupmenu_Apulsetype, 'String');
% pulsetype_A = char(pulse_type_array(get(handles.popupmenu_Apulsetype, 'Value')));
% pulse_type_array = get(handles.popupmenu_Bpulsetype, 'String');
% pulsetype_B = char(pulse_type_array(get(handles.popupmenu_Bpulsetype, 'Value')));


%%Piled files
%pulsewaveform_1
%pulsewaveform_2
%puslewaveform_1x
%pulsedur_1
%pulsedur_2
%pulsedur_1x



   %%use these to assign all wave patterns because nesting waves not suitable for matrix







%% Generate Stimulus Waveforms  [pulsewaveform_out]=autodiscrim_genstimwaveform(stimwv,srate_wavestim,srate,reversed,no_wave)
%+center the waves+ normalize (to height of 10)
pulsewaveform_A1=autodiscrim_genstimwaveform(stimwave_A1,srate_wavestim_A1,srate,reversed(1),no_wave(1));
pulsewaveform_A2=autodiscrim_genstimwaveform(stimwave_A2,srate_wavestim_A2,srate,reversed(2),no_wave(2));

pulsewaveform_B1=autodiscrim_genstimwaveform(stimwave_B1,srate_wavestim_B1,srate,reversed(3),no_wave(3));
pulsewaveform_B2=autodiscrim_genstimwaveform(stimwave_B2,srate_wavestim_B2,srate,reversed(4),no_wave(4));

pulsewaveform_C1=autodiscrim_genstimwaveform(stimwave_C1,srate_wavestim_C1,srate,reversed(5),no_wave(5));
pulsewaveform_C2=autodiscrim_genstimwaveform(stimwave_C2,srate_wavestim_C2,srate,reversed(6),no_wave(6));

pulsewaveform_D1=autodiscrim_genstimwaveform(stimwave_D1,srate_wavestim_D1,srate,reversed(7),no_wave(7));
pulsewaveform_D2=autodiscrim_genstimwaveform(stimwave_D2,srate_wavestim_D2,srate,reversed(8),no_wave(8));

pulsewaveform_E1=autodiscrim_genstimwaveform(stimwave_E1,srate_wavestim_E1,srate,reversed(9),no_wave(9));
pulsewaveform_E2=autodiscrim_genstimwaveform(stimwave_E2,srate_wavestim_E2,srate,reversed(10),no_wave(10));

pulsewaveform_F1=autodiscrim_genstimwaveform(stimwave_F1,srate_wavestim_F1,srate,reversed(11),no_wave(11));
pulsewaveform_F2=autodiscrim_genstimwaveform(stimwave_F2,srate_wavestim_F2,srate,reversed(12),no_wave(12));

if (version==1||version==2)
pulsewaveform_A3=autodiscrim_genstimwaveform(stimwave_A3,srate_wavestim_A3,srate,reversed(13),no_wave(13));
pulsewaveform_A4=autodiscrim_genstimwaveform(stimwave_A4,srate_wavestim_A4,srate,reversed(14),no_wave(14));

pulsewaveform_B3=autodiscrim_genstimwaveform(stimwave_B3,srate_wavestim_B3,srate,reversed(15),no_wave(15));
pulsewaveform_B4=autodiscrim_genstimwaveform(stimwave_B4,srate_wavestim_B4,srate,reversed(16),no_wave(16));

pulsewaveform_C3=autodiscrim_genstimwaveform(stimwave_C3,srate_wavestim_C3,srate,reversed(17),no_wave(17));
pulsewaveform_C4=autodiscrim_genstimwaveform(stimwave_C4,srate_wavestim_C4,srate,reversed(18),no_wave(18));

pulsewaveform_D3=autodiscrim_genstimwaveform(stimwave_D3,srate_wavestim_D3,srate,reversed(19),no_wave(19));
pulsewaveform_D4=autodiscrim_genstimwaveform(stimwave_D4,srate_wavestim_D4,srate,reversed(20),no_wave(20));

pulsewaveform_E3=autodiscrim_genstimwaveform(stimwave_E3,srate_wavestim_E3,srate,reversed(21),no_wave(21));
pulsewaveform_E4=autodiscrim_genstimwaveform(stimwave_E4,srate_wavestim_E4,srate,reversed(22),no_wave(22));

pulsewaveform_F3=autodiscrim_genstimwaveform(stimwave_F3,srate_wavestim_F3,srate,reversed(23),no_wave(23));
pulsewaveform_F4=autodiscrim_genstimwaveform(stimwave_F4,srate_wavestim_F4,srate,reversed(24),no_wave(24)); 
else
pulsewaveform_A3=[];
pulsewaveform_A4=[];
pulsewaveform_B3=[];
pulsewaveform_B4=[];
pulsewaveform_C3=[];
pulsewaveform_C4=[];
pulsewaveform_D3=[];
pulsewaveform_D4=[];
pulsewaveform_E3=[];
pulsewaveform_E4=[];
pulsewaveform_F3=[];
pulsewaveform_F4=[];
end
pulsewaveform_A1(1:2)
numel(pulsewaveform_A1)
%% Zero pad shorter of paired waveforms (1 vs. 2) and get total number of
% sample points  [length_o,length_o2,waveout,waveout2,npts]= autodiscrim_zeropad(wavein,wavein2)
pulsenpts=[];

%1=2
[pulsewaveform_A1,pulsewaveform_A2,pulsenpts(1)]= autodiscrim_zeropad(pulsewaveform_A1,pulsewaveform_A2);
[pulsewaveform_B1,pulsewaveform_B2,pulsenpts(2)]= autodiscrim_zeropad(pulsewaveform_B1,pulsewaveform_B2);
[pulsewaveform_C1,pulsewaveform_C2,pulsenpts(3)]= autodiscrim_zeropad(pulsewaveform_C1,pulsewaveform_C2);
[pulsewaveform_D1,pulsewaveform_D2,pulsenpts(4)]= autodiscrim_zeropad(pulsewaveform_D1,pulsewaveform_D2);
[pulsewaveform_E1,pulsewaveform_E2,pulsenpts(5)]= autodiscrim_zeropad(pulsewaveform_E1,pulsewaveform_E2);
[pulsewaveform_F1,pulsewaveform_F2,pulsenpts(6)]= autodiscrim_zeropad(pulsewaveform_F1,pulsewaveform_F2);



if (version==1||version==2)
%3=4
[pulsewaveform_A3,pulsewaveform_A4,pulsenpts(7)]= autodiscrim_zeropad(pulsewaveform_A3,pulsewaveform_A4);
[pulsewaveform_B3,pulsewaveform_B4,pulsenpts(8)]= autodiscrim_zeropad(pulsewaveform_B3,pulsewaveform_B4);
[pulsewaveform_C3,pulsewaveform_C4,pulsenpts(9)]= autodiscrim_zeropad(pulsewaveform_C3,pulsewaveform_C4);
[pulsewaveform_D3,pulsewaveform_D4,pulsenpts(10)]= autodiscrim_zeropad(pulsewaveform_D3,pulsewaveform_D4);
[pulsewaveform_E3,pulsewaveform_E4,pulsenpts(11)]= autodiscrim_zeropad(pulsewaveform_E3,pulsewaveform_E4);
[pulsewaveform_F3,pulsewaveform_F4,pulsenpts(12)]= autodiscrim_zeropad(pulsewaveform_F3,pulsewaveform_F4);
%1<=2=3>=4
[pulsewaveform_A3,pulsewaveform_A2,pulsenpts(7)]= autodiscrim_zeropad(pulsewaveform_A3,pulsewaveform_A2);
[pulsewaveform_B3,pulsewaveform_B2,pulsenpts(8)]= autodiscrim_zeropad(pulsewaveform_B3,pulsewaveform_B2);
[pulsewaveform_C3,pulsewaveform_C2,pulsenpts(9)]= autodiscrim_zeropad(pulsewaveform_C3,pulsewaveform_C2);
[pulsewaveform_D3,pulsewaveform_D2,pulsenpts(10)]= autodiscrim_zeropad(pulsewaveform_D3,pulsewaveform_D2);
[pulsewaveform_E3,pulsewaveform_E2,pulsenpts(11)]= autodiscrim_zeropad(pulsewaveform_E3,pulsewaveform_E2);
[pulsewaveform_F3,pulsewaveform_F2,pulsenpts(12)]= autodiscrim_zeropad(pulsewaveform_F3,pulsewaveform_F2);
%1=2=3>=4
[pulsewaveform_A1,pulsewaveform_A2,pulsenpts(1)]= autodiscrim_zeropad(pulsewaveform_A1,pulsewaveform_A2);
[pulsewaveform_B1,pulsewaveform_B2,pulsenpts(2)]= autodiscrim_zeropad(pulsewaveform_B1,pulsewaveform_B2);
[pulsewaveform_C1,pulsewaveform_C2,pulsenpts(3)]= autodiscrim_zeropad(pulsewaveform_C1,pulsewaveform_C2);
[pulsewaveform_D1,pulsewaveform_D2,pulsenpts(4)]= autodiscrim_zeropad(pulsewaveform_D1,pulsewaveform_D2);
[pulsewaveform_E1,pulsewaveform_E2,pulsenpts(5)]= autodiscrim_zeropad(pulsewaveform_E1,pulsewaveform_E2);
[pulsewaveform_F1,pulsewaveform_F2,pulsenpts(6)]= autodiscrim_zeropad(pulsewaveform_F1,pulsewaveform_F2);
%1=2=3=4
[pulsewaveform_A3,pulsewaveform_A4,pulsenpts(7)]= autodiscrim_zeropad(pulsewaveform_A3,pulsewaveform_A4);
[pulsewaveform_B3,pulsewaveform_B4,pulsenpts(8)]= autodiscrim_zeropad(pulsewaveform_B3,pulsewaveform_B4);
[pulsewaveform_C3,pulsewaveform_C4,pulsenpts(9)]= autodiscrim_zeropad(pulsewaveform_C3,pulsewaveform_C4);
[pulsewaveform_D3,pulsewaveform_D4,pulsenpts(10)]= autodiscrim_zeropad(pulsewaveform_D3,pulsewaveform_D4);
[pulsewaveform_E3,pulsewaveform_E4,pulsenpts(11)]= autodiscrim_zeropad(pulsewaveform_E3,pulsewaveform_E4);
[pulsewaveform_F3,pulsewaveform_F4,pulsenpts(12)]= autodiscrim_zeropad(pulsewaveform_F3,pulsewaveform_F4);
end

pulsenpts







% pause()
% pause()


if(mod(pulsenpts(1),2)~=0)
    pulsewaveform_A1=pulsewaveform_A1(1:end-1);
    pulsewaveform_A2=pulsewaveform_A2(1:end-1);
    pulsewaveform_A3=pulsewaveform_A3(1:end-1);
    pulsewaveform_A4=pulsewaveform_A4(1:end-1);
    pulsenpts(1)=pulsenpts(1)-1;
    pulsenpts(7)=pulsenpts(7)-1;
end
if(mod(pulsenpts(2),2)~=0)
    pulsewaveform_B1=pulsewaveform_B1(1:end-1);
    pulsewaveform_B2=pulsewaveform_B2(1:end-1);
    pulsewaveform_B3=pulsewaveform_B3(1:end-1);
    pulsewaveform_B4=pulsewaveform_B4(1:end-1);
    pulsenpts(2)=pulsenpts(2)-1;
    pulsenpts(8)=pulsenpts(8)-1;
end
if(mod(pulsenpts(3),2)~=0)
    pulsewaveform_C1=pulsewaveform_C1(1:end-1);
    pulsewaveform_C2=pulsewaveform_C2(1:end-1);
    pulsewaveform_C3=pulsewaveform_C3(1:end-1);
    pulsewaveform_C4=pulsewaveform_C4(1:end-1);
    pulsenpts(3)=pulsenpts(3)-1;
    pulsenpts(9)=pulsenpts(9)-1;
end
if(mod(pulsenpts(4),2)~=0)
    pulsewaveform_D1=pulsewaveform_D1(1:end-1);
    pulsewaveform_D2=pulsewaveform_D2(1:end-1);
    pulsewaveform_D3=pulsewaveform_D3(1:end-1);
    pulsewaveform_D4=pulsewaveform_D4(1:end-1);
    pulsenpts(4)=pulsenpts(4)-1;
    pulsenpts(10)=pulsenpts(10)-1;
end
if(mod(pulsenpts(5),2)~=0)
    pulsewaveform_E1=pulsewaveform_E1(1:end-1);
    pulsewaveform_E2=pulsewaveform_E2(1:end-1);
    pulsewaveform_E3=pulsewaveform_E3(1:end-1);
    pulsewaveform_E4=pulsewaveform_E4(1:end-1);
    pulsenpts(5)=pulsenpts(5)-1;
    pulsenpts(11)=pulsenpts(11)-1;
end
if(mod(pulsenpts(6),2)~=0)
    pulsewaveform_F1=pulsewaveform_F1(1:end-1);
    pulsewaveform_F2=pulsewaveform_F2(1:end-1);
    pulsewaveform_F3=pulsewaveform_F3(1:end-1);
    pulsewaveform_F4=pulsewaveform_F4(1:end-1);
    pulsenpts(6)=pulsenpts(6)-1;
    pulsenpts(12)=pulsenpts(12)-1;
end
minpts=min(pulsenpts)
[pulsewaveform_A1,pulsewaveform_A2,pulsewaveform_A3,pulsewaveform_A4,pulsenpts(1)]=autodiscrim_equalength(pulsewaveform_A1,pulsewaveform_A2,pulsewaveform_A3,pulsewaveform_A4,minpts);
pulsenpts(7)=pulsenpts(1);
[pulsewaveform_B1,pulsewaveform_B2,pulsewaveform_B3,pulsewaveform_B4,pulsenpts(2)]=autodiscrim_equalength(pulsewaveform_B1,pulsewaveform_B2,pulsewaveform_B3,pulsewaveform_B4,minpts);
pulsenpts(8)=pulsenpts(2);
[pulsewaveform_C1,pulsewaveform_C2,pulsewaveform_C3,pulsewaveform_C4,pulsenpts(3)]=autodiscrim_equalength(pulsewaveform_C1,pulsewaveform_C2,pulsewaveform_C3,pulsewaveform_C4,minpts);
pulsenpts(9)=pulsenpts(3);
[pulsewaveform_D1,pulsewaveform_D2,pulsewaveform_D3,pulsewaveform_D4,pulsenpts(4)]=autodiscrim_equalength(pulsewaveform_D1,pulsewaveform_D2,pulsewaveform_D3,pulsewaveform_D4,minpts);
pulsenpts(10)=pulsenpts(4);
[pulsewaveform_E1,pulsewaveform_E2,pulsewaveform_E3,pulsewaveform_E4,pulsenpts(5)]=autodiscrim_equalength(pulsewaveform_E1,pulsewaveform_E2,pulsewaveform_E3,pulsewaveform_E4,minpts);
pulsenpts(11)=pulsenpts(5);
[pulsewaveform_F1,pulsewaveform_F2,pulsewaveform_F3,pulsewaveform_F4,pulsenpts(6)]=autodiscrim_equalength(pulsewaveform_F1,pulsewaveform_F2,pulsewaveform_F3,pulsewaveform_F4,minpts);
pulsenpts(12)=pulsenpts(6);

pulsenpts

%% Set attenuation
pulseatt = str2num(get(handles.att,'String'));
if isempty(pulseatt)==1,
    set(handles.testprogress,'String','ABORTED');
    error('Enter Pulse Attenuation!!!');
elseif pulseatt<20,
    set(handles.testprogress,'String','ABORTED');
    error('Pulse Amplitude Cannot Exceed 1V!!!')
else
    %%MODIFY TO ATTENUATE ALL WAVEFORMS
    pulsewaveform_A1 = (10^(-pulseatt/20)).*(pulsewaveform_A1);
    pulsewaveform_A2 = (10^(-pulseatt/20)).*(pulsewaveform_A2);
    pulsewaveform_B1 = (10^(-pulseatt/20)).*(pulsewaveform_B1);
    pulsewaveform_B2 = (10^(-pulseatt/20)).*(pulsewaveform_B2);
    pulsewaveform_C1 = (10^(-pulseatt/20)).*(pulsewaveform_C1);
    pulsewaveform_C2 = (10^(-pulseatt/20)).*(pulsewaveform_C2);
    pulsewaveform_D1 = (10^(-pulseatt/20)).*(pulsewaveform_D1);
    pulsewaveform_D2 = (10^(-pulseatt/20)).*(pulsewaveform_D2);
    pulsewaveform_E1 = (10^(-pulseatt/20)).*(pulsewaveform_E1);
    pulsewaveform_E2 = (10^(-pulseatt/20)).*(pulsewaveform_E2);
    pulsewaveform_F1 = (10^(-pulseatt/20)).*(pulsewaveform_F1);
    pulsewaveform_F2 = (10^(-pulseatt/20)).*(pulsewaveform_F2);
    if (version==1||version==2)
    pulsewaveform_A3 = (10^(-pulseatt/20)).*(pulsewaveform_A3);
    pulsewaveform_A4 = (10^(-pulseatt/20)).*(pulsewaveform_A4);
    pulsewaveform_B3 = (10^(-pulseatt/20)).*(pulsewaveform_B3);
    pulsewaveform_B4 = (10^(-pulseatt/20)).*(pulsewaveform_B4);
    pulsewaveform_C3 = (10^(-pulseatt/20)).*(pulsewaveform_C3);
    pulsewaveform_C4 = (10^(-pulseatt/20)).*(pulsewaveform_C4);
    pulsewaveform_D3 = (10^(-pulseatt/20)).*(pulsewaveform_D3);
    pulsewaveform_D4 = (10^(-pulseatt/20)).*(pulsewaveform_D4);
    pulsewaveform_E3 = (10^(-pulseatt/20)).*(pulsewaveform_E3);
    pulsewaveform_E4 = (10^(-pulseatt/20)).*(pulsewaveform_E4);
    pulsewaveform_F3 = (10^(-pulseatt/20)).*(pulsewaveform_F3);
    pulsewaveform_F4 = (10^(-pulseatt/20)).*(pulsewaveform_F4);
    end
end

numel(pulsewaveform_A1)

%%Generate phase shifted wave 1   function [wavex]=autodiscrim_createx(wave1, phase)
phase=90;
pulsewaveform_Ax=autodiscrim_createx(pulsewaveform_A1, phase)';
pulsewaveform_Bx=autodiscrim_createx(pulsewaveform_B1, phase)';
pulsewaveform_Cx=autodiscrim_createx(pulsewaveform_C1, phase)';
pulsewaveform_Dx=autodiscrim_createx(pulsewaveform_D1, phase)';
pulsewaveform_Ex=autodiscrim_createx(pulsewaveform_E1, phase)';
pulsewaveform_Fx=autodiscrim_createx(pulsewaveform_F1, phase)';



%   figure(2)
%   plot((1:pulsenpts(1))*1000/srate-.5*pulsenpts(1)*1000/srate,pulsewaveform_A1,'r',((1:pulsenpts(1))*1000/srate-.5*pulsenpts(1)*1000/srate),pulsewaveform_A2,'g',(1:pulsenpts(7))*1000/srate-.5*pulsenpts(7)*1000/srate,pulsewaveform_A3,'k',((1:pulsenpts(7))*1000/srate-.5*pulsenpts(7)*1000/srate),pulsewaveform_A4,'m',((1:pulsenpts(1))*1000/srate-.5*pulsenpts(1)*1000/srate),pulsewaveform_Ax,'r--')
%   figure(3)
%  plot((1:pulsenpts(2))*1000/srate-.5*pulsenpts(2)*1000/srate,pulsewaveform_B1,'r',((1:pulsenpts(2))*1000/srate-.5*pulsenpts(2)*1000/srate),pulsewaveform_B2,'g',(1:pulsenpts(8))*1000/srate-.5*pulsenpts(8)*1000/srate,pulsewaveform_B3,'k',((1:pulsenpts(8))*1000/srate-.5*pulsenpts(8)*1000/srate),pulsewaveform_B4,'m',((1:pulsenpts(2))*1000/srate-.5*pulsenpts(2)*1000/srate),pulsewaveform_Bx,'r--')
%   figure(4)
%  plot((1:pulsenpts(3))*1000/srate-.5*pulsenpts(3)*1000/srate,pulsewaveform_C1,'r',((1:pulsenpts(3))*1000/srate-.5*pulsenpts(3)*1000/srate),pulsewaveform_C2,'g',(1:pulsenpts(9))*1000/srate-.5*pulsenpts(9)*1000/srate,pulsewaveform_C3,'k',((1:pulsenpts(9))*1000/srate-.5*pulsenpts(9)*1000/srate),pulsewaveform_C4,'m',((1:pulsenpts(3))*1000/srate-.5*pulsenpts(3)*1000/srate),pulsewaveform_Cx,'r--')
%   figure(5)
%  plot((1:pulsenpts(4))*1000/srate-.5*pulsenpts(4)*1000/srate,pulsewaveform_D1,'r',((1:pulsenpts(4))*1000/srate-.5*pulsenpts(4)*1000/srate),pulsewaveform_D2,'g',(1:pulsenpts(10))*1000/srate-.5*pulsenpts(10)*1000/srate,pulsewaveform_D3,'k',((1:pulsenpts(10))*1000/srate-.5*pulsenpts(10)*1000/srate),pulsewaveform_D4,'m',((1:pulsenpts(4))*1000/srate-.5*pulsenpts(4)*1000/srate),pulsewaveform_Dx,'r--')
%   figure(6)
%  plot((1:pulsenpts(5))*1000/srate-.5*pulsenpts(5)*1000/srate,pulsewaveform_E1,'r',((1:pulsenpts(5))*1000/srate-.5*pulsenpts(5)*1000/srate),pulsewaveform_E2,'g',(1:pulsenpts(11))*1000/srate-.5*pulsenpts(11)*1000/srate,pulsewaveform_E3,'k',((1:pulsenpts(11))*1000/srate-.5*pulsenpts(11)*1000/srate),pulsewaveform_E4,'m',((1:pulsenpts(5))*1000/srate-.5*pulsenpts(5)*1000/srate),pulsewaveform_Ex,'r--')
%   figure(7)
%  plot((1:pulsenpts(6))*1000/srate-.5*pulsenpts(6)*1000/srate,pulsewaveform_F1,'r',((1:pulsenpts(6))*1000/srate-.5*pulsenpts(6)*1000/srate),pulsewaveform_F2,'g',(1:pulsenpts(12))*1000/srate-.5*pulsenpts(12)*1000/srate,pulsewaveform_F3,'k',((1:pulsenpts(12))*1000/srate-.5*pulsenpts(12)*1000/srate),pulsewaveform_F4,'m',((1:pulsenpts(6))*1000/srate-.5*pulsenpts(6)*1000/srate),pulsewaveform_Fx,'r--')
% % % 
% figure(8)
%  plot((1:pulsenpts(1))*1000/srate-.5*pulsenpts(1)*1000/srate,pulsewaveform_A1,'r',((1:pulsenpts(1))*1000/srate-.5*pulsenpts(1)*1000/srate),pulsewaveform_A2,'r.')
% hold on
% plot((1:pulsenpts(2))*1000/srate-.5*pulsenpts(2)*1000/srate,pulsewaveform_B1,'g',((1:pulsenpts(2))*1000/srate-.5*pulsenpts(2)*1000/srate),pulsewaveform_B2,'g.')
% plot((1:pulsenpts(3))*1000/srate-.5*pulsenpts(3)*1000/srate,pulsewaveform_C1,'k',((1:pulsenpts(3))*1000/srate-.5*pulsenpts(3)*1000/srate),pulsewaveform_C2,'k.')
% plot((1:pulsenpts(4))*1000/srate-.5*pulsenpts(4)*1000/srate,pulsewaveform_D1,'m',((1:pulsenpts(4))*1000/srate-.5*pulsenpts(4)*1000/srate),pulsewaveform_D2,'m.')
% plot((1:pulsenpts(5))*1000/srate-.5*pulsenpts(5)*1000/srate,pulsewaveform_E1,'y',((1:pulsenpts(5))*1000/srate-.5*pulsenpts(5)*1000/srate),pulsewaveform_E2,'y.')
% plot((1:pulsenpts(6))*1000/srate-.5*pulsenpts(6)*1000/srate,pulsewaveform_F1,'b',((1:pulsenpts(6))*1000/srate-.5*pulsenpts(6)*1000/srate),pulsewaveform_F2,'b.')
% hold off

srate
pulsenpts
% figure(2)
%  plot((1:pulsenpts(1))*1000/srate-.5*pulsenpts(1)*1000/srate,pulsewaveform_A1,'r',((1:pulsenpts(1))*1000/srate-.5*pulsenpts(1)*1000/srate),pulsewaveform_Ax,'b')
% pause
disp('Waveforms generated.');
%% Get total number of pulses
totalpulsenum = str2num(get(handles.totalbnum,'String'));
if isempty(totalpulsenum)==1,
    set(handles.testprogress,'String','ABORTED');
    error('Enter Total Pulse Number!!!');
end

%% Determine which pulse to make novel
novelpulsenum = str2num(get(handles.nvbnum,'String'));
if isempty(novelpulsenum)==1,
    set(handles.testprogress,'String','ABORTED');
    error('Enter Novel Pulse Number!!!');
end
if novelpulsenum>totalpulsenum,
    set(handles.testprogress,'String','ABORTED');
    error('Novel Pulse Number Cannot be Greater than Total Pulse Number!!!');
end

%% Get pulse intervals
pulseint = str2num(get(handles.pint,'String'));
if isempty(pulseint)==1,
    set(handles.testprogress,'String','ABORTED');
    error('Enter Pulse Interval!!!');
end

%% Get burst intervals
burstint = str2num(get(handles.bint,'String'));

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
prestimdur = str2num(get(handles.pretri,'String'));
pststimdur = str2num(get(handles.posttri,'String'));
sdur = (prestimdur + pststimdur + (sum(stimints_current)/1000))*1000;
trialint = str2num(get(handles.tint, 'String'));
clusterint=str2num(get(handles.cint, 'String'));
numclusters= str2num(get(handles.numclust,'String'));
thold = str2num(get(handles.theshld, 'String'));
if ((isempty(numclusters)==1)|(numclusters==0)|(numclusters>6)),
    numclusters = 6;
    set(handles.numclust, 'String', num2str(numclusters));
end
if trialint<(prestimdur + pststimdur + (sum(stimints_current)/1000)),
    trialint = prestimdur + pststimdur + (sum(stimints_current)/1000);
    set(handles.tint, 'String', num2str(trialint));
end

if clusterint<(prestimdur + pststimdur + (sum(stimints_current)/1000)),
    clusterint = prestimdur + pststimdur + (sum(stimints_current)/1000);
    set(handles.cint, 'String', num2str(trialint));
end

 set(handles.textclusternum, 'String', num2str(numclusters));

%% Set number of sample points
npts = ceil((sdur*srate)/1000);                         % number of points in sample
set(handles.testprogress, 'String', 'WAITING');
disp('Set up complete.');

cluster_order=[];

whos    
    clear cluster_order;
    %cluster_order=[];
    pause(.01);
    cluster_order=orderer(numclusters);
    cluster_order=orderer(numclusters);%doubling ensures path clear
    disp(cluster_order);
disp('Experiment will begin as soon as a key is pressed.');
version
pause
set(handles.testprogress, 'String', 'RUNNING');
%% Record Data
if all(bitget(RM1.GetStatus,1:3))
    
    % Send information to RM1
    RM1.SetTagVal('threshold',thold);                  
    RM1.SetTagVal('prestimdur',(prestimdur*1000)-1);
    RM1.WriteTagV('stimints',0,stimints);
    RM1.SetTagVal('numints',length(stimints));
    RM1.SetTagVal('novelstart',novelstart);
    RM1.SetTagVal('novelend',novelend);
    
    
    clustercount=1;

    pause(.01);
    while (clustercount<=numclusters)
        trialcount=1;
        trial_order=orderer(5);
        trial_order=orderer(5);%see just above
        while (trialcount<=5)
            if(cluster_order(clustercount)==1)%%Cluster A
                disp('A');
                [pulsewaveform_back,pulsewaveform_novel]=autodiscrim_setbacknovel(pulsewaveform_A1,pulsewaveform_A2,pulsewaveform_Ax,trial_order(trialcount),pulsewaveform_A3,pulsewaveform_A4);
            elseif (cluster_order(clustercount)==2)%%Cluster B
                disp('B');
                [pulsewaveform_back,pulsewaveform_novel]=autodiscrim_setbacknovel(pulsewaveform_B1,pulsewaveform_B2,pulsewaveform_Bx,trial_order(trialcount), pulsewaveform_B3,pulsewaveform_B4);
            elseif (cluster_order(clustercount)==3)%%Cluster C
                disp('C');
                [pulsewaveform_back,pulsewaveform_novel]=autodiscrim_setbacknovel(pulsewaveform_C1,pulsewaveform_C2,pulsewaveform_Cx,trial_order(trialcount), pulsewaveform_C3,pulsewaveform_C4);
            elseif (cluster_order(clustercount)==4)%%Cluster D
                disp('D');
                [pulsewaveform_back,pulsewaveform_novel]=autodiscrim_setbacknovel(pulsewaveform_D1,pulsewaveform_D2,pulsewaveform_Dx,trial_order(trialcount), pulsewaveform_D3,pulsewaveform_D4);
            elseif (cluster_order(clustercount)==5)%%Cluster E
                disp('E');
                [pulsewaveform_back,pulsewaveform_novel]=autodiscrim_setbacknovel(pulsewaveform_E1,pulsewaveform_E2,pulsewaveform_Ex,trial_order(trialcount), pulsewaveform_E3,pulsewaveform_E4);
            elseif (cluster_order(clustercount)==6)%%Cluster F
                disp('F');
                [pulsewaveform_back,pulsewaveform_novel]=autodiscrim_setbacknovel(pulsewaveform_F1,pulsewaveform_F2,pulsewaveform_Fx,trial_order(trialcount), pulsewaveform_F3,pulsewaveform_F4);
            end
         
        trial_ordercollect(cluster_order(clustercount),:)=trial_order;    
        set(handles.textcurrentcluster, 'String', num2str(clustercount-1));
        autodiscrim_updateversus(cluster_order(clustercount),trial_order(trialcount),handles);
        set(handles.trinum, 'String', num2str(trialcount));
  %         disp('Versus should now be updated');
     
    pause(.01);
    RM1.WriteTagV('waveback', 0, pulsewaveform_back);
    RM1.WriteTagV('wavenovel', 0, pulsewaveform_novel);
    RM1.SetTagVal('bufsize',pulsenpts(cluster_order(clustercount)));
    pause(.01);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%alll actor code
         % Trigger stimulation
        RM1.SoftTrg(1);
        
        % Collect data
        curindex=RM1.GetTagVal('curindex');
        eodtimes_currep=RM1.ReadTagVEX('eodtimes', 0, curindex, 'I32', 'F32', 1)./srate;
        while ((max(eodtimes_currep)<(prestimdur + pststimdur + (sum(stimints_current)/1000)))|isnan(eodtimes_currep)==1),
            curindex=RM1.GetTagVal('curindex');
            eodtimes_currep=RM1.ReadTagVEX('eodtimes', 0, curindex, 'I32', 'F32', 1)./srate;
            actualdata_currep=RM1.ReadTagVEX('threshdata', 0, curindex, 'I32', 'F32', 1)./srate;
        end
        eodtimes_currep = eodtimes_currep - prestimdur;
        
        
%         actualdata_currep
%         length(eodtimes_currep)
%         eodtimes_currep
%         figure(2)
%         plot(eodtimes_currep,actualdata_currep)
%         pause
       
       
        if (trialcount>1 || clustercount>1)
            [a,b] = size(eodtimes);
            c = length(eodtimes_currep);
            if c<b,
                eodtimes_currep(c+1:b)= NaN;
            elseif c>b,
                eodtimes(1:a,b+1:c) = NaN;
            end
        end
        eodtimes(5*(cluster_order(clustercount)-1)+trial_order(trialcount),:) = eodtimes_currep;
            
%         figure (2)
%         hold on
% %         alpha=zeros(1,length(eodtimes_currep));
% %         beta=alpha+1;
% %         plot([eodtimes_currep eodtimes_currep],[alpha beta]);
%          disp('graph start')
%          pause(.01)
%          for i=1:length(eodtimes_currep)
%          plot([eodtimes_currep(i) eodtimes_currep(i)],[0 1],k)
%          end
%          disp('graph done')
%         hold off
% %         for i=1:length(burststrt)
% %         plot([burststrt(i) burststrt(i)],[0 1],'r')
% %         plot([burstends(i) burstends(i)],[0 1],'r')
% %         end
%         figure(1)
        
        pause(.01)
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%concludes actor code
        if (trialcount<5)
        disp('Intertrial Pause has been reached')
        disp(trialint-(prestimdur + pststimdur + (sum(stimints_current)/1000)))
        %%pause between trials--original
         set(handles.pausedisplay, 'String', strcat('Pausing between trials (', num2str(trialint-(prestimdur + pststimdur )),'s)'));
        pause(trialint-(prestimdur + pststimdur))        %%possibly insert randomness
        set(handles.pausedisplay, 'String','');
        end
       
        
        trialcount=trialcount+1;%%%must be last line before end    
        end%%end of cluster
        
        
        
        %%autosave here (after completion of cluster)%%%%%%%%%%%%%%
        %%function autodiscrim_autosave(handles,clusternum,clusterord,trialord)
        autodiscrim_autosave(handles,clustercount,cluster_order,trial_ordercollect);
        
        if (clustercount<numclusters)
        set(handles.pausedisplay, 'String', strcat('Pausing between clusters (', num2str(clusterint-(prestimdur + pststimdur)),'s)'));
        %%pause between clusters
        %pause(clusterint-(prestimdur + pststimdur + (sum(stimints_current)/1000)))           %%possibly insert randomness
        pause(clusterint-(prestimdur + pststimdur)) 
        set(handles.pausedisplay, 'String','');
        end
        
        clustercount=clustercount+1;%%%must be last line before end
    end%%end of experiment
    


        
          
    % Stop
    RM1.Halt;
    
    set(handles.textcurrentcluster, 'String', num2str(clustercount-1));
    
    % Play Beep
%    tone_time = [0:1/srate:0.02];
%    end_tone = sin(2*pi*1000*tone_time);
%    sound(end_tone,srate)
end
eodtimes = double(eodtimes);