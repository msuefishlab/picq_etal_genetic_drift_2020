function varargout = autodiscrim_wavedisplay(varargin)
% AUTODISCRIM_WAVEDISPLAY M-file for autodiscrim_wavedisplay.fig
%      AUTODISCRIM_WAVEDISPLAY, by itself, creates a new AUTODISCRIM_WAVEDISPLAY or raises the existing
%      singleton*.
%
%      H = AUTODISCRIM_WAVEDISPLAY returns the handle to a new AUTODISCRIM_WAVEDISPLAY or the handle to
%      the existing singleton*.
%
%      AUTODISCRIM_WAVEDISPLAY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUTODISCRIM_WAVEDISPLAY.M with the given input arguments.
%
%      AUTODISCRIM_WAVEDISPLAY('Property','Value',...) creates a new AUTODISCRIM_WAVEDISPLAY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before autodiscrim_wavedisplay_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to autodiscrim_wavedisplay_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help autodiscrim_wavedisplay

% Last Modified by GUIDE v2.5 07-Jun-2011 13:21:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @autodiscrim_wavedisplay_OpeningFcn, ...
                   'gui_OutputFcn',  @autodiscrim_wavedisplay_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before autodiscrim_wavedisplay is made visible.
function autodiscrim_wavedisplay_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to autodiscrim_wavedisplay (see VARARGIN)

% Choose default command line output for autodiscrim_wavedisplay
handles.output = hObject;
global pathname_wavestim1 filename_wavestim1 stimwave_1 srate_wavestim_1
global pathname_wavestim2 filename_wavestim2 stimwave_2 srate_wavestim_2
global pathname_wavestim3 filename_wavestim3 stimwave_3 srate_wavestim_3
global pathname_wavestim4 filename_wavestim4 stimwave_4 srate_wavestim_4
global srate
% clear pathname_wavestim1 filename_wavestim1 stimwave_1 srate_wavestim_1
% clear pathname_wavestim2 filename_wavestim2 stimwave_2 srate_wavestim_2
% clear pathname_wavestim3 filename_wavestim3 stimwave_3 srate_wavestim_3
% clear pathname_wavestim4 filename_wavestim4 stimwave_4 srate_wavestim_4
set(handles.text1,'String','');
set(handles.text2,'String','');
set(handles.text3,'String','');
set(handles.text4,'String','');
% stimwave1=[];
% stimwave2=[];
% stimwave3=[];
% stimwave4=[];

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes autodiscrim_wavedisplay wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = autodiscrim_wavedisplay_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
global pathname_wavestim1 filename_wavestim1 stimwave_1 srate_wavestim_1
global pathname_wavestim2 filename_wavestim2 stimwave_2 srate_wavestim_2
global pathname_wavestim3 filename_wavestim3 stimwave_3 srate_wavestim_3
global pathname_wavestim4 filename_wavestim4 stimwave_4 srate_wavestim_4
global srate

% stimwave1=[];
% stimwave2=[];
% stimwave3=[];
% stimwave4=[];

varargout{1} = handles.output;


% --- Executes on button press in load1.
function load1_Callback(hObject, eventdata, handles)
% hObject    handle to load1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestim1 filename_wavestim1 stimwave_1 srate_wavestim_1
[filename_wavestim1, pathname_wavestim1] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestim1,filename_wavestim1), '-mat');
srate_wavestim_1 = srate;
set(handles.text1,'String',filename_wavestim1);
stimwave_1 = stimwave;
cd(char(pathname_wavestim1))

% --- Executes on button press in load2.
function load2_Callback(hObject, eventdata, handles)
% hObject    handle to load2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestim2 filename_wavestim2 stimwave_2 srate_wavestim_2
[filename_wavestim2, pathname_wavestim2] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestim2,filename_wavestim2), '-mat');
srate_wavestim_2 = srate;
set(handles.text2,'String',filename_wavestim2);
stimwave_2 = stimwave;
cd(char(pathname_wavestim2))

% --- Executes on button press in load3.
function load3_Callback(hObject, eventdata, handles)
% hObject    handle to load3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestim3 filename_wavestim3 stimwave_3 srate_wavestim_3
[filename_wavestim3, pathname_wavestim3] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestim3,filename_wavestim3), '-mat');
srate_wavestim_3 = srate;
set(handles.text3,'String',filename_wavestim3);
stimwave_3 = stimwave;
cd(char(pathname_wavestim3))

% --- Executes on button press in load4.
function load4_Callback(hObject, eventdata, handles)
% hObject    handle to load4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestim4 filename_wavestim4 stimwave_4 srate_wavestim_4
[filename_wavestim4, pathname_wavestim4] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestim4,filename_wavestim4), '-mat');
srate_wavestim_4 = srate;
set(handles.text4,'String',filename_wavestim4);
stimwave_4 = stimwave;
cd(char(pathname_wavestim4))

% --- Executes on button press in clear1.
function clear1_Callback(hObject, eventdata, handles)
% hObject    handle to clear1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text1,'String','');
stimwave_1=[];

% --- Executes on button press in clear2.
function clear2_Callback(hObject, eventdata, handles)
% hObject    handle to clear2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text2,'String','');
stimwave_2=[];

% --- Executes on button press in clear3.
function clear3_Callback(hObject, eventdata, handles)
% hObject    handle to clear3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text3,'String','');
stimwave_3=[];

% --- Executes on button press in clear4.
function clear4_Callback(hObject, eventdata, handles)
% hObject    handle to clear4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text4,'String','');
stimwave_4=[];

% --- Executes on button press in updater2.
function updater2_Callback(hObject, eventdata, handles)
% hObject    handle to updater2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestim1 filename_wavestim1 stimwave_1 srate_wavestim_1
global pathname_wavestim2 filename_wavestim2 stimwave_2 srate_wavestim_2
global pathname_wavestim3 filename_wavestim3 stimwave_3 srate_wavestim_3
global pathname_wavestim4 filename_wavestim4 stimwave_4 srate_wavestim_4
global srate
RM1 = actxcontrol('RPco.x',[5 5 26 26]);
RM1.ConnectRM1('USB', 1);
%if isdir('N:\')==1,
%    RM1.LoadCOF('N:\Matlab\Mobile Processor\stim1playback_novel_playrec_mobile.rcx');
%else
%    RM1.LoadCOF('C:\Documents and Settings\Carlson Lab\My Documents\Matlab\Mobile Processor\stim1playback_novel_playrec_mobile.rcx');
%RM1.LoadCOF('E:\Documents and Settings\Carl\My Documents\MATLAB\work-josh\stim1playback_novel_playrec_mobile.rcx');
RM1.LoadCOF('C:\Documents and Settings\Hopkins\My Documents\MATLAB\work-josh\autodiscrim_mobile.rcx');
% %end
srate = RM1.GetSFreq;
RM1.Run;
pause(1)
RM1.Halt;
clear pulsewaveform_1 pulsewaveform_2 pulsewaveform_3 pulsewaveform_4
pulsewaveform_1=[];
pulsewaveform_2=[];
pulsewaveform_3=[];
pulsewaveform_4=[];
pulsenpts=[];

strcmp(get(handles.text1,'String'),'')
strcmp(get(handles.text2,'String'),'')

pulsewaveform_1=autodiscrim_genstimwaveform(stimwave_1,srate_wavestim_1,srate,0,strcmp(get(handles.text1,'String'),''));
pulsewaveform_2=autodiscrim_genstimwaveform(stimwave_2,srate_wavestim_2,srate,0,strcmp(get(handles.text2,'String'),''));
pulsewaveform_3=autodiscrim_genstimwaveform(stimwave_3,srate_wavestim_3,srate,0,strcmp(get(handles.text3,'String'),''));
pulsewaveform_4=autodiscrim_genstimwaveform(stimwave_4,srate_wavestim_4,srate,0,strcmp(get(handles.text4,'String'),''));

[pulsewaveform_1,pulsewaveform_2,pulsenpts(1)]= autodiscrim_zeropad(pulsewaveform_1,pulsewaveform_2);
[pulsewaveform_3,pulsewaveform_4,pulsenpts(2)]= autodiscrim_zeropad(pulsewaveform_3,pulsewaveform_4);
[pulsewaveform_3,pulsewaveform_2,pulsenpts(3)]= autodiscrim_zeropad(pulsewaveform_3,pulsewaveform_2);
[pulsewaveform_1,pulsewaveform_2,pulsenpts(4)]= autodiscrim_zeropad(pulsewaveform_1,pulsewaveform_2);
[pulsewaveform_3,pulsewaveform_4,pulsenpts(5)]= autodiscrim_zeropad(pulsewaveform_3,pulsewaveform_4);

hold off
plot(0,0)
hold on
zoom on
if (~strcmp(get(handles.text1,'String'),''))
    disp('I am here')
    plot(handles.axes1,(1:pulsenpts(5))*1000/srate-.5*pulsenpts(5)*1000/srate,pulsewaveform_1,'r')
end
if (~strcmp(get(handles.text2,'String'),''))
    disp('I am here2')
    plot(handles.axes1,(1:pulsenpts(5))*1000/srate-.5*pulsenpts(5)*1000/srate,pulsewaveform_2,'g')
end
if (~strcmp(get(handles.text3,'String'),''))
    disp('I am here3')
    plot(handles.axes1,(1:pulsenpts(5))*1000/srate-.5*pulsenpts(5)*1000/srate,pulsewaveform_3,'k')
end
if (~strcmp(get(handles.text4,'String'),''))
    disp('I am here4')
    plot(handles.axes1,(1:pulsenpts(5))*1000/srate-.5*pulsenpts(5)*1000/srate,pulsewaveform_4,'m')
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global pathname_wavestim1 filename_wavestim1 stimwave_1 srate_wavestim_1
% % [filename_wavestim1, pathname_wavestim1] = uigetfile('*.eod', 'Open stimulus waveform file...');
% % load (fullfile(pathname_wavestim1,filename_wavestim1), '-eod');
% % w=getallwaves(filename_wavestim1);
% % wm=mean(w);
% % srate_wavestim_1=w(1).srate;
% [fn,pn]=uigetfile('*.eod');
% pnfn=[pn fn];
% handles.pnfn=pnfn;
% handles.pn=pn;
% handles.fn=fn;
% cd(pn);
% handles.waves=getallwaves(handles.fn);
% 
% wm=mean(handles.waves)

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


