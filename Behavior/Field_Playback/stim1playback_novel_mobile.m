function varargout = stim1playback_novel_mobile(varargin)

%
% stim1playback_novel_mobile.m
%       Generates background and novel stimulus waveforms and captures EOD timing data
%
%   For use with Tucker-Davis Technologies System 3, using an RM1 mobile processor
%
%   CONNECTIONS:
%       ADC1 ... from recording amplifier
%       DAC1 ... to stimulus isolation unit
%

%% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @stim1playback_novel_mobile_OpeningFcn, ...
                   'gui_OutputFcn',  @stim1playback_novel_mobile_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

%% Executes just before stim1playback_novel_mobile is made visible.
function stim1playback_novel_mobile_OpeningFcn(hObject, eventdata, handles, varargin)

%% Choose default command line output for stim1playback_novel_mobile
handles.output = hObject;

%% Update handles structure
guidata(hObject, handles);

%% Outputs from this function are returned to the command line.
function varargout = stim1playback_novel_mobile_OutputFcn(hObject, eventdata, handles) 

%% Get default command line output from handles structure
varargout{1} = handles.output;

%% Clear sampling parameter variables
clear srate thold

%% Initialization
global eodtimes pathname_wavstimA filename_wavstimA pathname_wavstimB filename_wavstimB
axes(handles.axes_responseplot);
xlabel('Time (s)', 'FontSize',12)
ylabel('EOD interval (ms)','FontSize',12)
eodtimes = [];
pathname_wavstimA = '';
filename_wavstimA = '';
pathname_wavstimB = '';
filename_wavstimB = '';

%% PLAY/REC TOGGLEBUTTON - Plays stimulus and records data
function togglebutton_playrec_Callback(hObject, eventdata, handles)
global eodtimes srate prestimdur pststimdur trialint pulseint burstint pulseatt totalpulsenum novelpulsenum  pulsetype_back pulsedur_back pulsepol_back stimwave_A srate_wavstim_A pulsetype_novel pulsedur_novel pulsepol_novel stimwave_B srate_wavstim_B
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max'),
    set(hObject,'ForegroundColor',[0 0 0]);
    stim_run = 1;
    stimints_actual = [];
    stim1playback_novel_playrec_mobile;
    stim1playback_plot;
elseif button_state == get(hObject,'Min'),
    set(hObject,'ForegroundColor',[1 1 1]);
    stim_run = 0;
end

%% SAVE PUSHBUTTON - Save data to file
function pushbutton_save_Callback(hObject, eventdata, handles)
global eodtimes srate prestimdur pststimdur trialint pulseint burstint pulseatt totalpulsenum novelpulsenum  pulsetype_back pulsedur_back pulsepol_back stimwave_A srate_wavstim_A pulsetype_novel pulsedur_novel pulsepol_novel stimwave_B srate_wavstim_B
species_array = get(handles.popupmenu_species, 'String');
species = char(species_array(get(handles.popupmenu_species, 'Value')));
sex_array = get(handles.popupmenu_sex,'String');
sex = char(sex_array(get(handles.popupmenu_sex, 'Value')));
totallength = str2num(get(handles.edit_totallength,'String'));
temperature = str2num(get(handles.edit_temperature,'String'));
conductivity = str2num(get(handles.edit_conductivity,'String'));
wavfilebackname = get(handles.text_wavfileback,'String');
wavfilenovelname = get(handles.text_wavfilenovel,'String');
addinfo = get(handles.edit_addinfo,'String');
[filename,pathname] = uiputfile('*.novel.st1.mat','Enter file name');
if pathname == 0
    beep
    return
end
save (fullfile(pathname,filename), 'species', 'sex', 'totallength', 'temperature', 'conductivity', 'addinfo', 'srate', 'pulseint', 'burstint', 'pulseatt', 'prestimdur', 'pststimdur', 'trialint', 'eodtimes', 'totalpulsenum', 'novelpulsenum', 'wavfilebackname', 'wavfilenovelname', 'pulsetype_back', 'pulsedur_back', 'pulsepol_back', 'pulsetype_novel', 'pulsedur_novel', 'pulsepol_novel');
cd(char(pathname))

%% LOAD PUSHBUTTON - Loads saved data
function pushbutton_load_Callback(hObject, eventdata, handles)
global eodtimes srate prestimdur pststimdur trialint pulseint burstint pulseatt totalpulsenum novelpulsenum pulsetype_back pulsedur_back pulsepol_back stimwave_A srate_wavstim_A pulsetype_novel pulsedur_novel pulsepol_novel stimwave_B srate_wavstim_B
[filename, pathname] = uigetfile('*.novel.st1.mat', 'Open data file');
if pathname == 0
    beep
    return
end
clear prestimdur pststimdur trialint burstint pulseint burstint pulseatt totalpulsenum novelpulsenum  pulsetype_back pulsedur_back pulsepol_back stimwave_A srate_wavstim_A pulsetype_novel pulsedur_novel pulsepol_novel stimwave_B srate_wavstim_B
load (fullfile(pathname,filename), '-mat');
cd(char(pathname))
if isempty(burstint)==1,
    stimints = [0 repmat(pulseint,1,totalpulsenum-1)];
else
    stimints = 0;
    burstseq = [repmat(pulseint,1,9)];
    for i=1:totalpulsenum-1,
        stimints = [stimints burstseq burstint];
    end
    stimints = [stimints burstseq];
end
stimints_current = stimints;
species_options = get(handles.popupmenu_species,'String');
quit = 0;
i = 1;
while quit==0,
    if size(char(species_options(i)))==size(species),
        if species==char(species_options(i)),
            set(handles.popupmenu_species,'Value',i);
            quit = 1;
        end
    end
    i = i+1;
end
sex_options = get(handles.popupmenu_sex,'String');
quit = 0;
i = 1;
while quit==0,
    if size(char(sex_options(i)))==size(sex),
        if sex==char(sex_options(i)),
            set(handles.popupmenu_sex,'Value',i);
            quit = 1;
        end
    end
    i = i+1;
end
set(handles.edit_totallength, 'String', totallength);
set(handles.edit_temperature, 'String', temperature);
set(handles.edit_conductivity, 'String', conductivity);
pulsetypebackground_options = get(handles.popupmenu_Apulsetype,'String');
quit = 0;
i = 1;
while quit==0,
    if size(char(pulsetypebackground_options(i)))==size(pulsetype_back),
        if pulsetype_back==char(pulsetypebackground_options(i)),
            set(handles.popupmenu_Apulsetype,'Value',i);
            quit = 1;
        end
    end
    i = i+1;
end
pulsetypenovel_options = get(handles.popupmenu_Bpulsetype,'String');
quit = 0;
i = 1;
while quit==0,
    if size(char(pulsetypenovel_options(i)))==size(pulsetype_novel),
        if pulsetype_novel==char(pulsetypenovel_options(i)),
            set(handles.popupmenu_Bpulsetype,'Value',i);
            quit = 1;
        end
    end
    i = i+1;
end
pulsepolbackground_options = get(handles.popupmenu_Apulsepol,'String');
quit = 0;
i = 1;
while quit==0,
    if size(char(pulsepolbackground_options(i)))==size(pulsepol_back),
        if pulsepol_back==char(pulsepolbackground_options(i)),
            set(handles.popupmenu_Apulsepol,'Value',i);
            quit = 1;
        end
    end
    i = i+1;
end
pulsepolnovel_options = get(handles.popupmenu_Bpulsepol,'String');
quit = 0;
i = 1;
while quit==0,
    if size(char(pulsepolnovel_options(i)))==size(pulsepol_novel),
        if pulsepol_novel==char(pulsepolnovel_options(i)),
            set(handles.popupmenu_Bpulsepol,'Value',i);
            quit = 1;
        end
    end
    i = i+1;
end
set(handles.popupmenu_pulsetrain,'Value',4);
set(handles.text_wavfileback,'String',wavfilebackname);
set(handles.text_wavfilenovel,'String',wavfilenovelname);
set(handles.edit_Apulsedur, 'String', pulsedur_back);
set(handles.edit_Bpulsedur, 'String', pulsedur_novel);
set(handles.edit_addinfo, 'String', addinfo);
set(handles.edit_pulseatt, 'String', pulseatt);
pulsevolt = 10*(10^(-pulseatt/20));
set(handles.text_voltout,'String',['= ' num2str(pulsevolt,3) ' V']);
set(handles.edit_prestimdur, 'String', prestimdur);
set(handles.edit_pststimdur, 'String', pststimdur);
set(handles.edit_trialint, 'String', trialint);
set(handles.edit_totalpulsenum, 'String', totalpulsenum);
set(handles.edit_novelpulsenum, 'String', novelpulsenum);
set(handles.edit_pulseint, 'String', pulseint);
set(handles.edit_burstint, 'String', burstint);
set(handles.edit_setnumreps, 'String', []);
set(handles.edit_threshold, 'String', []);
stim1playback_plot

%% Pulse A Type
function popupmenu_Apulsetype_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function popupmenu_Apulsetype_Callback(hObject, eventdata, handles)
global pathname_wavstimA filename_wavstimA stimwave_A srate_wavstim_A
pulse_type_array = get(handles.popupmenu_Apulsetype, 'String');
pulsetype = char(pulse_type_array(get(handles.popupmenu_Apulsetype, 'Value')));
switch pulsetype
    case 'Load Waveform File'
        [filename_wavstimA, pathname_wavstimA] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
        load (fullfile(pathname_wavstimA,filename_wavstimA), '-mat');
        srate_wavstim_A = srate;
        set(handles.edit_Apulsedur,'String',[]);
        stimwave_A = stimwave;
    case 'No Waveform'
        set(handles.edit_Apulsedur,'String',[]);
        filename_wavstimA = '';
        pathname_wavstimA = '';
        srate_wavstim_A = '';
        stimwaveA = '';
    otherwise
        filename_wavstimA = '';
        pathname_wavstimA = '';
        srate_wavstim_A = '';
        stimwaveA = '';
end
pulse_train_array = get(handles.popupmenu_pulsetrain, 'String');
pulsetrain = char(pulse_train_array(get(handles.popupmenu_pulsetrain, 'Value')));
switch pulsetrain
    case 'Select'
        set(handles.text_wavfileback,'String','');
        set(handles.text_wavfilenovel,'String','');
    case 'A Train'
        set(handles.text_wavfileback,'String',filename_wavstimA);
        set(handles.text_wavfilenovel,'String',filename_wavstimA);
    case 'A Train/B Insert'
        set(handles.text_wavfileback,'String',filename_wavstimA);
    case 'B Train/A Insert'
        set(handles.text_wavfilenovel,'String',filename_wavstimA);
end

%% Pulse A Polarity
function popupmenu_Apulsepol_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function popupmenu_Apulsepol_Callback(hObject, eventdata, handles)

%% Pulse A Duration
function edit_Apulsedur_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_Apulsedur_Callback(hObject, eventdata, handles)

%% Pulse B Type
function popupmenu_Bpulsetype_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function popupmenu_Bpulsetype_Callback(hObject, eventdata, handles)
global pathname_wavstimB filename_wavstimB stimwave_B srate_wavstim_B
pulse_type_array = get(handles.popupmenu_Bpulsetype, 'String');
pulsetype = char(pulse_type_array(get(handles.popupmenu_Bpulsetype, 'Value')));
switch pulsetype
    case 'Load Waveform File'
        [filename_wavstimB, pathname_wavstimB] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
        load (fullfile(pathname_wavstimB,filename_wavstimB), '-mat');
        srate_wavstim_B = srate;
        set(handles.edit_Bpulsedur,'String',[]);
        stimwave_B = stimwave;
    case 'No Waveform'
        set(handles.edit_Bpulsedur,'String',[]);
        filename_wavstimB = '';
        pathname_wavstimB = '';
        srate_wavstim_B = '';
        stimwaveB = '';
    otherwise
        filename_wavstimB = '';
        pathname_wavstimB = '';
        srate_wavstim_B = '';
        stimwaveB = '';
end
pulse_train_array = get(handles.popupmenu_pulsetrain, 'String');
pulsetrain = char(pulse_train_array(get(handles.popupmenu_pulsetrain, 'Value')));
switch pulsetrain
    case 'Select'
        set(handles.text_wavfileback,'String','');
        set(handles.text_wavfilenovel,'String','');
    case 'B Train'
        set(handles.text_wavfileback,'String',filename_wavstimB);
        set(handles.text_wavfilenovel,'String',filename_wavstimB);
    case 'A Train/B Insert'
        set(handles.text_wavfilenovel,'String',filename_wavstimB);
    case 'B Train/A Insert'
        set(handles.text_wavfileback,'String',filename_wavstimB);
end

%% Pulse B Polarity
function popupmenu_Bpulsepol_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function popupmenu_Bpulsepol_Callback(hObject, eventdata, handles)

%% Pulse B Duration
function edit_Bpulsedur_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_Bpulsedur_Callback(hObject, eventdata, handles)

%% Choose Pulse Train Type
function popupmenu_pulsetrain_CreateFcn(hObject, eventdata, handles)
function popupmenu_pulsetrain_Callback(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global pathname_wavstimA filename_wavstimA pathname_wavstimB filename_wavstimB
pulse_train_array = get(handles.popupmenu_pulsetrain, 'String');
pulsetrain = char(pulse_train_array(get(handles.popupmenu_pulsetrain, 'Value')));
switch pulsetrain
    case 'Select'
        set(handles.text_wavfileback,'String','');
        set(handles.text_wavfilenovel,'String','');
    case 'A Train'
        set(handles.text_wavfileback,'String',filename_wavstimA);
        set(handles.text_wavfilenovel,'String',filename_wavstimA);
    case 'B Train'
        set(handles.text_wavfileback,'String',filename_wavstimB);
        set(handles.text_wavfilenovel,'String',filename_wavstimB);
    case 'A Train/B Insert'
        set(handles.text_wavfileback,'String',filename_wavstimA);
        set(handles.text_wavfilenovel,'String',filename_wavstimB);
    case 'B Train/A Insert'
        set(handles.text_wavfileback,'String',filename_wavstimB);
        set(handles.text_wavfilenovel,'String',filename_wavstimA);
end

%% Enter Total Pulse Number
function edit_totalpulsenum_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_totalpulsenum_Callback(hObject, eventdata, handles)

%% Enter Novel Pulse Number (i.e. which pulse is novel)
function edit_novelpulsenum_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_novelpulsenum_Callback(hObject, eventdata, handles)

%% Enter Pulse Interval
function edit_pulseint_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_pulseint_Callback(hObject, eventdata, handles)

%% Enter Burst Interval
function edit_burstint_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_burstint_Callback(hObject, eventdata, handles)

%% Enter Pulse Attenuation
function edit_pulseatt_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_pulseatt_Callback(hObject, eventdata, handles)
pulseatt = str2num(get(handles.edit_pulseatt,'String'));
pulsevolt = 10*(10^(-pulseatt/20));
set(handles.text_voltout,'String',['= ' num2str(pulsevolt,3) ' V']);

%% Enter Threshold
function edit_threshold_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_threshold_Callback(hObject, eventdata, handles)

%% Set Specific Number of Reps
function edit_setnumreps_Callback(hObject, eventdata, handles)
function edit_setnumreps_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Enter Duration of Pre-Stimulus Recording
function edit_prestimdur_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_prestimdur_Callback(hObject, eventdata, handles)

%% Enter Duration of Post-Stimulus Recording
function edit_pststimdur_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_pststimdur_Callback(hObject, eventdata, handles)

%% Enter Duration of Inter-Trial Interval
function edit_trialint_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_trialint_Callback(hObject, eventdata, handles)

%% Choose Species
function popupmenu_species_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function popupmenu_species_Callback(hObject, eventdata, handles)

%% Choose Sex
function popupmenu_sex_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function popupmenu_sex_Callback(hObject, eventdata, handles)

%% Enter Total Length
function edit_totallength_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_totallength_Callback(hObject, eventdata, handles)

%% Enter Temperature
function edit_temperature_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_temperature_Callback(hObject, eventdata, handles)

%% Enter Conductivity
function edit_conductivity_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_conductivity_Callback(hObject, eventdata, handles)

%% Enter Additional Info
function edit_addinfo_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_addinfo_Callback(hObject, eventdata, handles)

%% Choose the Type of Plot
function popupmenu_plottype_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function popupmenu_plottype_Callback(hObject, eventdata, handles)
global eodtimes prestimdur pststimdur stimints pulseint burstint totalpulsenum
if isempty(burstint)==1,
    stimints = [0 repmat(pulseint,1,totalpulsenum-1)];
else
    stimints = 0;
    burstseq = [repmat(pulseint,1,9)];
    for i=1:totalpulsenum-1,
        stimints = [stimints burstseq burstint];
    end
    stimints = [stimints burstseq];
end
stimints_current = stimints;
stim1playback_plot

%% Choose the Bin Size
function edit_binsize_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_binsize_Callback(hObject, eventdata, handles)
global eodtimes prestimdur pststimdur stimints pulseint burstint totalpulsenum
if isempty(burstint)==1,
    stimints = [0 repmat(pulseint,1,totalpulsenum-1)];
else
    stimints = 0;
    burstseq = [repmat(pulseint,1,9)];
    for i=1:totalpulsenum-1,
        stimints = [stimints burstseq burstint];
    end
    stimints = [stimints burstseq];
end
stimints_current = stimints;
stim1playback_plot

%% Choose the Statistical Cutoff
function popupmenu_cutoff_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function popupmenu_cutoff_Callback(hObject, eventdata, handles)
global eodtimes prestimdur pststimdur stimints pulseint burstint totalpulsenum
if isempty(burstint)==1,
    stimints = [0 repmat(pulseint,1,totalpulsenum-1)];
else
    stimints = 0;
    burstseq = [repmat(pulseint,1,9)];
    for i=1:totalpulsenum-1,
        stimints = [stimints burstseq burstint];
    end
    stimints = [stimints burstseq];
end
stimints_current = stimints;
stim1playback_plot