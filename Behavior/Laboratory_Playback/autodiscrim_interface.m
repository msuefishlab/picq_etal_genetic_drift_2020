function varargout = autodiscrim_interface(varargin)
% AUTODISCRIM_INTERFACE M-file for autodiscrim_interface.fig
%      AUTODISCRIM_INTERFACE, by itself, creates a new AUTODISCRIM_INTERFACE or raises the existing
%      singleton*.
%
%      H = AUTODISCRIM_INTERFACE returns the handle to a new AUTODISCRIM_INTERFACE or the handle to
%      the existing singleton*.
%
%      AUTODISCRIM_INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUTODISCRIM_INTERFACE.M with the given input arguments.
%
%      AUTODISCRIM_INTERFACE('Property','Value',...) creates a new AUTODISCRIM_INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before autodiscrim_interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to autodiscrim_interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help autodiscrim_interface

% Last Modified by GUIDE v2.5 23-Jul-2011 15:08:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @autodiscrim_interface_OpeningFcn, ...
                   'gui_OutputFcn',  @autodiscrim_interface_OutputFcn, ...
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


% --- Executes just before autodiscrim_interface is made visible.
function autodiscrim_interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to autodiscrim_interface (see VARARGIN)

% Choose default command line output for autodiscrim_interface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes autodiscrim_interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = autodiscrim_interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

global eodtimes 
global pathname_wavestimA1 filename_wavestimA1 pathname_wavestimA2 filename_wavestimA2 stimwave_A1 srate_wavestim_A1 stimwave_A2 srate_wavestim_A2 pathname_wavestimA3 filename_wavestimA3 pathname_wavestimA4 filename_wavestimA4 stimwave_A3 srate_wavestim_A3 stimwave_A4 srate_wavestim_A4
global pathname_wavestimB1 filename_wavestimB1 pathname_wavestimB2 filename_wavestimB2 stimwave_B1 srate_wavestim_B1 stimwave_B2 srate_wavestim_B2 pathname_wavestimB3 filename_wavestimB3 pathname_wavestimB4 filename_wavestimB4 stimwave_B3 srate_wavestim_B3 stimwave_B4 srate_wavestim_B4
global pathname_wavestimC1 filename_wavestimC1 pathname_wavestimC2 filename_wavestimC2 stimwave_C1 srate_wavestim_C1 stimwave_C2 srate_wavestim_C2 pathname_wavestimC3 filename_wavestimC3 pathname_wavestimC4 filename_wavestimC4 stimwave_C3 srate_wavestim_C3 stimwave_C4 srate_wavestim_C4
global pathname_wavestimD1 filename_wavestimD1 pathname_wavestimD2 filename_wavestimD2 stimwave_D1 srate_wavestim_D1 stimwave_D2 srate_wavestim_D2 pathname_wavestimD3 filename_wavestimD3 pathname_wavestimD4 filename_wavestimD4 stimwave_D3 srate_wavestim_D3 stimwave_D4 srate_wavestim_D4
global pathname_wavestimE1 filename_wavestimE1 pathname_wavestimE2 filename_wavestimE2 stimwave_E1 srate_wavestim_E1 stimwave_E2 srate_wavestim_E2 pathname_wavestimE3 filename_wavestimE3 pathname_wavestimE4 filename_wavestimE4 stimwave_E3 srate_wavestim_E3 stimwave_E4 srate_wavestim_E4
global pathname_wavestimF1 filename_wavestimF1 pathname_wavestimF2 filename_wavestimF2 stimwave_F1 srate_wavestim_F1 stimwave_F2 srate_wavestim_F2 pathname_wavestimF3 filename_wavestimF3 pathname_wavestimF4 filename_wavestimF4 stimwave_F3 srate_wavestim_F3 stimwave_F4 srate_wavestim_F4
global no_wave reversed version
set(handles.testprogress, 'String', '');
set(handles.textbackground, 'String', '');
set(handles.textnovel, 'String', '');
set(handles.textclusternum, 'String', '');
set(handles.textcurrentcluster, 'String', '');
set(handles.trinum, 'String', '');

% --- Executes on button press in loadA1.
function loadA1_Callback(hObject, eventdata, handles)
% hObject    handle to loadA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimA1 filename_wavestimA1 stimwave_A1 srate_wavestim_A1
[filename_wavestimA1, pathname_wavestimA1] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimA1,filename_wavestimA1), '-mat');
srate_wavestim_A1 = srate;
set(handles.text3,'String',filename_wavestimA1);
stimwave_A1 = stimwave;
cd(char(pathname_wavestimA1))

% --- Executes on button press in loadA2.
function loadA2_Callback(hObject, eventdata, handles)
% hObject    handle to loadA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimA2 filename_wavestimA2 stimwave_A2 srate_wavestim_A2
[filename_wavestimA2, pathname_wavestimA2] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimA2,filename_wavestimA2), '-mat');
srate_wavestim_A2 = srate;
set(handles.text4,'String',filename_wavestimA2);
stimwave_A2 = stimwave;

% --- Executes on button press in no1.
function no1_Callback(hObject, eventdata, handles)
% hObject    handle to no1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global stimwave_A1
% figure(2)
% plot(stimwave_A1);


% Hint: get(hObject,'Value') returns toggle state of no1
%no=[get(handles.no1,'Value') get(handles.no2,'Value') get(handles.no3,'Value') get(handles.no4,'Value') get(handles.no5,'Value') get(handles.no6,'Value') get(handles.no7,'Value') get(handles.no8,'Value') get(handles.no9,'Value') get(handles.no10,'Value') get(handles.no11,'Value') get(handles.no12,'Value')]        
%invert=[get(handles.invert1,'Value') get(handles.invert2,'Value') get(handles.invert3,'Value') get(handles.invert4,'Value') get(handles.invert5,'Value') get(handles.invert6,'Value') get(handles.invert7,'Value') get(handles.invert8,'Value') get(handles.invert9,'Value') get(handles.invert10,'Value') get(handles.invert11,'Value') get(handles.invert12,'Value')]
% --- Executes on button press in invert1.
function invert1_Callback(hObject, eventdata, handles)
% hObject    handle to invert1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert1


% --- Executes on button press in no2.
function no2_Callback(hObject, eventdata, handles)
% hObject    handle to no2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of no2


% --- Executes on button press in invert2.
function invert2_Callback(hObject, eventdata, handles)
% hObject    handle to invert2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert2


% --- Executes on button press in loadB1.
function loadB1_Callback(hObject, eventdata, handles)
% hObject    handle to loadB1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimB1 filename_wavestimB1 stimwave_B1 srate_wavestim_B1
[filename_wavestimB1, pathname_wavestimB1] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimB1,filename_wavestimB1), '-mat');
srate_wavestim_B1 = srate;
set(handles.text5,'String',filename_wavestimB1);
stimwave_B1 = stimwave;

% --- Executes on button press in loadB2.
function loadB2_Callback(hObject, eventdata, handles)
% hObject    handle to loadB2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimB2 filename_wavestimB2 stimwave_B2 srate_wavestim_B2
[filename_wavestimB2, pathname_wavestimB2] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimB2,filename_wavestimB2), '-mat');
srate_wavestim_B2 = srate;
set(handles.text6,'String',filename_wavestimB2);
stimwave_B2 = stimwave;

% --- Executes on button press in no3.
function no3_Callback(hObject, eventdata, handles)
% hObject    handle to no3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of no3


% --- Executes on button press in invert3.
function invert3_Callback(hObject, eventdata, handles)
% hObject    handle to invert3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert3


% --- Executes on button press in no4.
function no4_Callback(hObject, eventdata, handles)
% hObject    handle to no4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no4


% --- Executes on button press in invert4.
function invert4_Callback(hObject, eventdata, handles)
% hObject    handle to invert4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert4


% --- Executes on button press in loadC1.
function loadC1_Callback(hObject, eventdata, handles)
% hObject    handle to loadC1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimC1 filename_wavestimC1 stimwave_C1 srate_wavestim_C1
[filename_wavestimC1, pathname_wavestimC1] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimC1,filename_wavestimC1), '-mat');
srate_wavestim_C1 = srate;
set(handles.text7,'String',filename_wavestimC1);
stimwave_C1 = stimwave;

% --- Executes on button press in loadC2.
function loadC2_Callback(hObject, eventdata, handles)
% hObject    handle to loadC2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimC2 filename_wavestimC2 stimwave_C2 srate_wavestim_C2
[filename_wavestimC2, pathname_wavestimC2] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimC2,filename_wavestimC2), '-mat');
srate_wavestim_C2 = srate;
set(handles.text8,'String',filename_wavestimC2);
stimwave_C2 = stimwave;

% --- Executes on button press in no5.
function no5_Callback(hObject, eventdata, handles)
% hObject    handle to no5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no5


% --- Executes on button press in invert5.
function invert5_Callback(hObject, eventdata, handles)
% hObject    handle to invert5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert5


% --- Executes on button press in no6.
function no6_Callback(hObject, eventdata, handles)
% hObject    handle to no6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no6


% --- Executes on button press in invert6.
function invert6_Callback(hObject, eventdata, handles)
% hObject    handle to invert6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert6


% --- Executes on button press in loadD1.
function loadD1_Callback(hObject, eventdata, handles)
% hObject    handle to loadD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimD1 filename_wavestimD1 stimwave_D1 srate_wavestim_D1
[filename_wavestimD1, pathname_wavestimD1] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimD1,filename_wavestimD1), '-mat');
srate_wavestim_D1 = srate;
set(handles.text9,'String',filename_wavestimD1);
stimwave_D1 = stimwave;

% --- Executes on button press in loadD2.
function loadD2_Callback(hObject, eventdata, handles)
% hObject    handle to loadD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimD2 filename_wavestimD2 stimwave_D2 srate_wavestim_D2
[filename_wavestimD2, pathname_wavestimD2] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimD2,filename_wavestimD2), '-mat');
srate_wavestim_D2 = srate;
set(handles.text10,'String',filename_wavestimD2);
stimwave_D2 = stimwave;

% --- Executes on button press in no7.
function no7_Callback(hObject, eventdata, handles)
% hObject    handle to no7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no7


% --- Executes on button press in invert7.
function invert7_Callback(hObject, eventdata, handles)
% hObject    handle to invert7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert7


% --- Executes on button press in no8.
function no8_Callback(hObject, eventdata, handles)
% hObject    handle to no8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no8


% --- Executes on button press in invert8.
function invert8_Callback(hObject, eventdata, handles)
% hObject    handle to invert8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert8


% --- Executes on button press in loadE1.
function loadE1_Callback(hObject, eventdata, handles)
% hObject    handle to loadE1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimE1 filename_wavestimE1 stimwave_E1 srate_wavestim_E1
[filename_wavestimE1, pathname_wavestimE1] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimE1,filename_wavestimE1), '-mat');
srate_wavestim_E1 = srate;
set(handles.text11,'String',filename_wavestimE1);
stimwave_E1 = stimwave;

% --- Executes on button press in loadE2.
function loadE2_Callback(hObject, eventdata, handles)
% hObject    handle to loadE2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimE2 filename_wavestimE2 stimwave_E2 srate_wavestim_E2
[filename_wavestimE2, pathname_wavestimE2] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimE2,filename_wavestimE2), '-mat');
srate_wavestim_E2 = srate;
set(handles.text12,'String',filename_wavestimE2);
stimwave_E2 = stimwave;

% --- Executes on button press in no9.
function no9_Callback(hObject, eventdata, handles)
% hObject    handle to no9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no9


% --- Executes on button press in invert9.
function invert9_Callback(hObject, eventdata, handles)
% hObject    handle to invert9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert9


% --- Executes on button press in no10.
function no10_Callback(hObject, eventdata, handles)
% hObject    handle to no10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no10


% --- Executes on button press in invert10.
function invert10_Callback(hObject, eventdata, handles)
% hObject    handle to invert10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert10


% --- Executes on button press in loadF1.
function loadF1_Callback(hObject, eventdata, handles)
% hObject    handle to loadF1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimF1 filename_wavestimF1 stimwave_F1 srate_wavestim_F1
[filename_wavestimF1, pathname_wavestimF1] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimF1,filename_wavestimF1), '-mat');
srate_wavestim_F1 = srate;
set(handles.text13,'String',filename_wavestimF1);
stimwave_F1 = stimwave;

% --- Executes on button press in loadF2.
function loadF2_Callback(hObject, eventdata, handles)
% hObject    handle to loadF2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimF2 filename_wavestimF2 stimwave_F2 srate_wavestim_F2
[filename_wavestimF2, pathname_wavestimF2] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimF2,filename_wavestimF2), '-mat');
srate_wavestim_F2 = srate;
set(handles.text14,'String',filename_wavestimF2);
stimwave_F2 = stimwave;

% --- Executes on button press in no11.
function no11_Callback(hObject, eventdata, handles)
% hObject    handle to no11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no11


% --- Executes on button press in invert11.
function invert11_Callback(hObject, eventdata, handles)
% hObject    handle to invert11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert11


% --- Executes on button press in no12.
function no12_Callback(hObject, eventdata, handles)
% hObject    handle to no12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no12


% --- Executes on button press in invert12.
function invert12_Callback(hObject, eventdata, handles)
% hObject    handle to invert12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert12


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%global eodtimes %%will be saved with data

global pathname_wavestimA1 filename_wavestimA1 pathname_wavestimA2 filename_wavestimA2 stimwave_A1 srate_wavestim_A1 stimwave_A2 srate_wavestim_A2 pathname_wavestimA3 filename_wavestimA3 pathname_wavestimA4 filename_wavestimA4 stimwave_A3 srate_wavestim_A3 stimwave_A4 srate_wavestim_A4
global pathname_wavestimB1 filename_wavestimB1 pathname_wavestimB2 filename_wavestimB2 stimwave_B1 srate_wavestim_B1 stimwave_B2 srate_wavestim_B2 pathname_wavestimB3 filename_wavestimB3 pathname_wavestimB4 filename_wavestimB4 stimwave_B3 srate_wavestim_B3 stimwave_B4 srate_wavestim_B4
global pathname_wavestimC1 filename_wavestimC1 pathname_wavestimC2 filename_wavestimC2 stimwave_C1 srate_wavestim_C1 stimwave_C2 srate_wavestim_C2 pathname_wavestimC3 filename_wavestimC3 pathname_wavestimC4 filename_wavestimC4 stimwave_C3 srate_wavestim_C3 stimwave_C4 srate_wavestim_C4
global pathname_wavestimD1 filename_wavestimD1 pathname_wavestimD2 filename_wavestimD2 stimwave_D1 srate_wavestim_D1 stimwave_D2 srate_wavestim_D2 pathname_wavestimD3 filename_wavestimD3 pathname_wavestimD4 filename_wavestimD4 stimwave_D3 srate_wavestim_D3 stimwave_D4 srate_wavestim_D4
global pathname_wavestimE1 filename_wavestimE1 pathname_wavestimE2 filename_wavestimE2 stimwave_E1 srate_wavestim_E1 stimwave_E2 srate_wavestim_E2 pathname_wavestimE3 filename_wavestimE3 pathname_wavestimE4 filename_wavestimE4 stimwave_E3 srate_wavestim_E3 stimwave_E4 srate_wavestim_E4
global pathname_wavestimF1 filename_wavestimF1 pathname_wavestimF2 filename_wavestimF2 stimwave_F1 srate_wavestim_F1 stimwave_F2 srate_wavestim_F2 pathname_wavestimF3 filename_wavestimF3 pathname_wavestimF4 filename_wavestimF4 stimwave_F3 srate_wavestim_F3 stimwave_F4 srate_wavestim_F4
global no_wave reversed version

stimwave_A1
%should be saved with data
%date = str2num(get(handles.datebox,'String'));
%starttime = str2num(get(handles.timebox,'String'));
%temperature = str2num(get(handles.tempbox,'String'));
%conductivity = str2num(get(handles.condbox,'String'));
%identifiers= str2num(get(handles.fishid,'String'));
%otherinfo = str2num(get(handles.infobox,'String'));

%experiment parameters
burstn = str2num(get(handles.totalbnum,'String'));
nvburstn = str2num(get(handles.nvbnum,'String'));
attention = str2num(get(handles.att,'String'));
threshold = str2num(get(handles.theshld,'String'));
pulseint = str2num(get(handles.pint,'String'));
 burstint= str2num(get(handles.bint,'String'));
trialint = str2num(get(handles.tint,'String'));
clusterint = str2num(get(handles.cint,'String'));
preint = str2num(get(handles.pretri,'String'));
postint = str2num(get(handles.posttri,'String'));
numclusters = str2num(get(handles.numclust,'String'));

no_wave=[get(handles.no1,'Value') get(handles.no2,'Value') get(handles.no3,'Value') get(handles.no4,'Value') get(handles.no5,'Value') get(handles.no6,'Value') get(handles.no7,'Value') get(handles.no8,'Value') get(handles.no9,'Value') get(handles.no10,'Value') get(handles.no11,'Value') get(handles.no12,'Value') get(handles.no13,'Value') get(handles.no14,'Value') get(handles.no15,'Value') get(handles.no16,'Value') get(handles.no17,'Value') get(handles.no18,'Value') get(handles.no19,'Value') get(handles.no20,'Value') get(handles.no21,'Value') get(handles.no22,'Value') get(handles.no23,'Value') get(handles.no24,'Value')]        
reversed=[get(handles.invert1,'Value') get(handles.invert2,'Value') get(handles.invert3,'Value') get(handles.invert4,'Value') get(handles.invert5,'Value') get(handles.invert6,'Value') get(handles.invert7,'Value') get(handles.invert8,'Value') get(handles.invert9,'Value') get(handles.invert10,'Value') get(handles.invert11,'Value') get(handles.invert12,'Value') get(handles.invert13,'Value') get(handles.invert14,'Value') get(handles.invert15,'Value') get(handles.invert16,'Value') get(handles.invert17,'Value') get(handles.invert18,'Value') get(handles.invert19,'Value') get(handles.invert20,'Value') get(handles.invert21,'Value') get(handles.invert22,'Value') get(handles.invert23,'Value') get(handles.invert24,'Value')]
version=get(handles.enhancer,'Value')+2*get(handles.version3,'Value');%%0=v1,1=v2,2=v3

[filename,pathname] = uiputfile('*.autod.exper.mat','Enter protocol name');
if pathname == 0
    beep
    return
end
save (fullfile(pathname,filename),'version','burstn','nvburstn','attention','threshold','pulseint','burstint','trialint', 'clusterint','preint','postint','numclusters','no_wave','reversed' ,'pathname_wavestimA1', 'filename_wavestimA1', 'pathname_wavestimA2', 'filename_wavestimA2','pathname_wavestimB1', 'filename_wavestimB1', 'pathname_wavestimB2', 'filename_wavestimB2','pathname_wavestimC1', 'filename_wavestimC1', 'pathname_wavestimC2', 'filename_wavestimC2', 'pathname_wavestimD1', 'filename_wavestimD1', 'pathname_wavestimD2', 'filename_wavestimD2','pathname_wavestimE1', 'filename_wavestimE1' ,'pathname_wavestimE2', 'filename_wavestimE2','pathname_wavestimF1' ,'filename_wavestimF1', 'pathname_wavestimF2', 'filename_wavestimF2', 'stimwave_A1', 'srate_wavestim_A1', 'stimwave_A2', 'srate_wavestim_A2','stimwave_B1', 'srate_wavestim_B1', 'stimwave_B2', 'srate_wavestim_B2','stimwave_C1', 'srate_wavestim_C1', 'stimwave_C2', 'srate_wavestim_C2','stimwave_D1', 'srate_wavestim_D1', 'stimwave_D2', 'srate_wavestim_D2','stimwave_E1', 'srate_wavestim_E1', 'stimwave_E2', 'srate_wavestim_E2','stimwave_F1', 'srate_wavestim_F1', 'stimwave_F2', 'srate_wavestim_F2','stimwave_A3', 'srate_wavestim_A3', 'stimwave_A4', 'srate_wavestim_A4', 'stimwave_B3', 'srate_wavestim_B3', 'stimwave_B4', 'srate_wavestim_B4', 'stimwave_C3', 'srate_wavestim_C3', 'stimwave_C4', 'srate_wavestim_C4', 'stimwave_D3', 'srate_wavestim_D3', 'stimwave_D4', 'srate_wavestim_D4', 'stimwave_E3', 'srate_wavestim_E3', 'stimwave_E4', 'srate_wavestim_E4', 'stimwave_F3', 'srate_wavestim_F3', 'stimwave_F4', 'srate_wavestim_F4', 'pathname_wavestimA3', 'filename_wavestimA3', 'pathname_wavestimA4', 'filename_wavestimA4', 'pathname_wavestimB3', 'filename_wavestimB3', 'pathname_wavestimB4', 'filename_wavestimB4', 'pathname_wavestimC3', 'filename_wavestimC3', 'pathname_wavestimC4', 'filename_wavestimC4', 'pathname_wavestimD3', 'filename_wavestimD3', 'pathname_wavestimD4', 'filename_wavestimD4', 'pathname_wavestimE3', 'filename_wavestimE3', 'pathname_wavestimE4', 'filename_wavestimE4', 'pathname_wavestimF3', 'filename_wavestimF3', 'pathname_wavestimF4', 'filename_wavestimF4')
cd(char(pathname))
set(handles.protocolname,'String',filename)

% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimA1 filename_wavestimA1 pathname_wavestimA2 filename_wavestimA2 pathname_wavestimA3 filename_wavestimA3 pathname_wavestimA4 filename_wavestimA4
global pathname_wavestimB1 filename_wavestimB1 pathname_wavestimB2 filename_wavestimB2 pathname_wavestimB3 filename_wavestimB3 pathname_wavestimB4 filename_wavestimB4
global pathname_wavestimC1 filename_wavestimC1 pathname_wavestimC2 filename_wavestimC2 pathname_wavestimC3 filename_wavestimC3 pathname_wavestimC4 filename_wavestimC4
global pathname_wavestimD1 filename_wavestimD1 pathname_wavestimD2 filename_wavestimD2 pathname_wavestimD3 filename_wavestimD3 pathname_wavestimD4 filename_wavestimD4
global pathname_wavestimE1 filename_wavestimE1 pathname_wavestimE2 filename_wavestimE2 pathname_wavestimE3 filename_wavestimE3 pathname_wavestimE4 filename_wavestimE4
global pathname_wavestimF1 filename_wavestimF1 pathname_wavestimF2 filename_wavestimF2 pathname_wavestimF3 filename_wavestimF3 pathname_wavestimF4 filename_wavestimF4
global no_wave reversed version

[filename, pathname] = uigetfile('*.autod.exper.mat', 'Open Protocol');
if pathname == 0
    beep
    return
end
set(handles.protocolname,'String',filename)
clear  no_wave reversed version burstn  nvburstn  attention  threshold  pulseint  burstint  trialint   clusterint  preint  postint  numclusters  no_wave  reversed   pathname_wavestimA1   filename_wavestimA1   pathname_wavestimA2   filename_wavestimA2  pathname_wavestimB1   filename_wavestimB1   pathname_wavestimB2   filename_wavestimB2  pathname_wavestimC1   filename_wavestimC1   pathname_wavestimC2   filename_wavestimC2   pathname_wavestimD1   filename_wavestimD1   pathname_wavestimD2   filename_wavestimD2  pathname_wavestimE1   filename_wavestimE1   pathname_wavestimE2   filename_wavestimE2  pathname_wavestimF1   filename_wavestimF1   pathname_wavestimF2   filename_wavestimF2   stimwave_A1   srate_wavestim_A1   stimwave_A2   srate_wavestim_A2  stimwave_B1   srate_wavestim_B1   stimwave_B2   srate_wavestim_B2  stimwave_C1   srate_wavestim_C1   stimwave_C2   srate_wavestim_C2  stimwave_D1   srate_wavestim_D1   stimwave_D2   srate_wavestim_D2  stimwave_E1   srate_wavestim_E1   stimwave_E2   srate_wavestim_E2  stimwave_F1   srate_wavestim_F1   stimwave_F2   srate_wavestim_F2 pathname_wavestimA3 filename_wavestimA3 pathname_wavestimA4 filename_wavestimA4 pathname_wavestimB3 filename_wavestimB3 pathname_wavestimB4 filename_wavestimB4 pathname_wavestimC3 filename_wavestimC3 pathname_wavestimC4 filename_wavestimC4 pathname_wavestimD3 filename_wavestimD3 pathname_wavestimD4 filename_wavestimD4 pathname_wavestimE3 filename_wavestimE3 pathname_wavestimE4 filename_wavestimE4 pathname_wavestimF3 filename_wavestimF3 pathname_wavestimF4 filename_wavestimF4 )
load (fullfile(pathname,filename), '-mat');
cd(char(pathname))
set(handles.testprogress, 'String', '');
set(handles.textbackground, 'String', '');
set(handles.textnovel, 'String', '');
set(handles.textclusternum, 'String', '');
set(handles.textcurrentcluster, 'String', '');
set(handles.trinum, 'String', '');
%%%%%%%of questionable utility for me%%%%%%%%%%%%%%
% if isempty(burstint)==1,
%     stimints = [0 repmat(pulseint,1,totalpulsenum-1)];
% else
%     stimints = 0;
%     burstseq = [repmat(pulseint,1,9)];
%     for i=1:totalpulsenum-1,
%         stimints = [stimints burstseq burstint];
%     end
%     stimints = [stimints burstseq];
% end
% stimints_current = stimints;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(handles.no1,'Value',no_wave(1));
set(handles.invert1,'Value',reversed(1));
set(handles.no2,'Value',no_wave(2));
set(handles.invert2,'Value',reversed(2));
set(handles.no3,'Value',no_wave(3));
set(handles.invert3,'Value',reversed(3));
set(handles.no4,'Value',no_wave(4));
set(handles.invert4,'Value',reversed(4));
set(handles.no5,'Value',no_wave(5));
set(handles.invert5,'Value',reversed(5));
set(handles.no6,'Value',no_wave(6));
set(handles.invert6,'Value',reversed(6));
set(handles.no7,'Value',no_wave(7));
set(handles.invert7,'Value',reversed(7));
set(handles.no8,'Value',no_wave(8));
set(handles.invert8,'Value',reversed(8));
set(handles.no9,'Value',no_wave(9));
set(handles.invert9,'Value',reversed(9));
set(handles.no10,'Value',no_wave(10));
set(handles.invert10,'Value',reversed(10));
set(handles.no11,'Value',no_wave(11));
set(handles.invert11,'Value',reversed(11));
set(handles.no12,'Value',no_wave(12));
set(handles.invert12,'Value',reversed(12));
set(handles.no13,'Value',no_wave(13));
set(handles.invert13,'Value',reversed(13));
set(handles.no14,'Value',no_wave(14));
set(handles.invert14,'Value',reversed(14));
set(handles.no15,'Value',no_wave(15));
set(handles.invert15,'Value',reversed(15));
set(handles.no16,'Value',no_wave(16));
set(handles.invert16,'Value',reversed(16));
set(handles.no17,'Value',no_wave(17));
set(handles.invert17,'Value',reversed(17));
set(handles.no18,'Value',no_wave(18));
set(handles.invert18,'Value',reversed(18));
set(handles.no19,'Value',no_wave(19));
set(handles.invert19,'Value',reversed(19));
set(handles.no20,'Value',no_wave(20));
set(handles.invert20,'Value',reversed(20));
set(handles.no21,'Value',no_wave(21));
set(handles.invert21,'Value',reversed(21));
set(handles.no22,'Value',no_wave(22));
set(handles.invert22,'Value',reversed(22));
set(handles.no23,'Value',no_wave(23));
set(handles.invert23,'Value',reversed(23));
set(handles.no24,'Value',no_wave(24));
set(handles.invert24,'Value',reversed(24));


if (version==1)
    set(handles.text56,'Visible','on');
    set(handles.text57,'Visible','off');
    set(handles.v3text,'Visible','off');
    set(handles.enhancer,'Value',1);
    set(handles.version3,'Value',0);
elseif(version==2)
    set(handles.text56,'Visible','off');
    set(handles.text57,'Visible','off');
    set(handles.v3text,'Visible','on');
    set(handles.enhancer,'Value',0);
    set(handles.version3,'Value',1);
else
    set(handles.text56,'Visible','off');
    set(handles.text57,'Visible','on');
    set(handles.v3text,'Visible','off');
    set(handles.enhancer,'Value',0);
    set(handles.version3,'Value',0);
end

set(handles.totalbnum,'String',burstn);
set(handles.nvbnum,'String',nvburstn);
set(handles.datebox,'String',date);  %%automatically sets date; can be turned off
set(handles.att,'String',attention);
set(handles.theshld,'String',threshold);
set(handles.pint,'String',pulseint);
set(handles.bint,'String',burstint);
set(handles.tint,'String',trialint);
set(handles.cint,'String',clusterint);
set(handles.pretri,'String',preint);
set(handles.posttri,'String',postint);
set(handles.numclust,'String',numclusters);

set(handles.text3,'String',filename_wavestimA1);
set(handles.text4,'String',filename_wavestimA2);
set(handles.text5,'String',filename_wavestimB1);
set(handles.text6,'String',filename_wavestimB2);
set(handles.text7,'String',filename_wavestimC1);
set(handles.text8,'String',filename_wavestimC2);
set(handles.text9,'String',filename_wavestimD1);
set(handles.text10,'String',filename_wavestimD2);
set(handles.text11,'String',filename_wavestimE1);
set(handles.text12,'String',filename_wavestimE2);
set(handles.text13,'String',filename_wavestimF1);
set(handles.text14,'String',filename_wavestimF2);
set(handles.text40,'String',filename_wavestimA3);
set(handles.text41,'String',filename_wavestimA4);
set(handles.text42,'String',filename_wavestimB3);
set(handles.text43,'String',filename_wavestimB4);
set(handles.text44,'String',filename_wavestimC3);
set(handles.text45,'String',filename_wavestimC4);
set(handles.text46,'String',filename_wavestimD3);
set(handles.text47,'String',filename_wavestimD4);
set(handles.text48,'String',filename_wavestimE3);
set(handles.text49,'String',filename_wavestimE4);
set(handles.text50,'String',filename_wavestimF3);
set(handles.text51,'String',filename_wavestimF4);

version

% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%get(handles.protocolname,'String')
%if strcmp(get(handles.protocolname,'String'),'')==1
global pathname_wavestimA1 filename_wavestimA1 pathname_wavestimA2 filename_wavestimA2 stimwave_A1 srate_wavestim_A1 stimwave_A2 srate_wavestim_A2 pathname_wavestimA3 filename_wavestimA3 pathname_wavestimA4 filename_wavestimA4 stimwave_A3 srate_wavestim_A3 stimwave_A4 srate_wavestim_A4
global pathname_wavestimB1 filename_wavestimB1 pathname_wavestimB2 filename_wavestimB2 stimwave_B1 srate_wavestim_B1 stimwave_B2 srate_wavestim_B2 pathname_wavestimB3 filename_wavestimB3 pathname_wavestimB4 filename_wavestimB4 stimwave_B3 srate_wavestim_B3 stimwave_B4 srate_wavestim_B4
global pathname_wavestimC1 filename_wavestimC1 pathname_wavestimC2 filename_wavestimC2 stimwave_C1 srate_wavestim_C1 stimwave_C2 srate_wavestim_C2 pathname_wavestimC3 filename_wavestimC3 pathname_wavestimC4 filename_wavestimC4 stimwave_C3 srate_wavestim_C3 stimwave_C4 srate_wavestim_C4
global pathname_wavestimD1 filename_wavestimD1 pathname_wavestimD2 filename_wavestimD2 stimwave_D1 srate_wavestim_D1 stimwave_D2 srate_wavestim_D2 pathname_wavestimD3 filename_wavestimD3 pathname_wavestimD4 filename_wavestimD4 stimwave_D3 srate_wavestim_D3 stimwave_D4 srate_wavestim_D4
global pathname_wavestimE1 filename_wavestimE1 pathname_wavestimE2 filename_wavestimE2 stimwave_E1 srate_wavestim_E1 stimwave_E2 srate_wavestim_E2 pathname_wavestimE3 filename_wavestimE3 pathname_wavestimE4 filename_wavestimE4 stimwave_E3 srate_wavestim_E3 stimwave_E4 srate_wavestim_E4
global pathname_wavestimF1 filename_wavestimF1 pathname_wavestimF2 filename_wavestimF2 stimwave_F1 srate_wavestim_F1 stimwave_F2 srate_wavestim_F2 pathname_wavestimF3 filename_wavestimF3 pathname_wavestimF4 filename_wavestimF4 stimwave_F3 srate_wavestim_F3 stimwave_F4 srate_wavestim_F4
global no_wave reversed version
global eodtimes

if isempty(get(handles.protocolname,'String'))
    save_Callback(hObject, eventdata, handles)
end
[exper_filename,exper_pathname] = uiputfile('*.mat','Enter experiment name');
if exper_pathname == 0
    beep
    return
end
set(handles.expername,'String',exper_filename);
set(handles.pathnametext,'String',exper_pathname);
cd(char(exper_pathname))

set(handles.testprogress, 'String', 'STARTING');
set(handles.textclusternum, 'String', get(handles.numclust,'String'));
no_wave=[get(handles.no1,'Value') get(handles.no2,'Value') get(handles.no3,'Value') get(handles.no4,'Value') get(handles.no5,'Value') get(handles.no6,'Value') get(handles.no7,'Value') get(handles.no8,'Value') get(handles.no9,'Value') get(handles.no10,'Value') get(handles.no11,'Value') get(handles.no12,'Value') get(handles.no13,'Value') get(handles.no14,'Value') get(handles.no15,'Value') get(handles.no16,'Value') get(handles.no17,'Value') get(handles.no18,'Value') get(handles.no19,'Value') get(handles.no20,'Value') get(handles.no21,'Value') get(handles.no22,'Value') get(handles.no23,'Value') get(handles.no24,'Value')]        
reversed=[get(handles.invert1,'Value') get(handles.invert2,'Value') get(handles.invert3,'Value') get(handles.invert4,'Value') get(handles.invert5,'Value') get(handles.invert6,'Value') get(handles.invert7,'Value') get(handles.invert8,'Value') get(handles.invert9,'Value') get(handles.invert10,'Value') get(handles.invert11,'Value') get(handles.invert12,'Value') get(handles.invert13,'Value') get(handles.invert14,'Value') get(handles.invert15,'Value') get(handles.invert16,'Value') get(handles.invert17,'Value') get(handles.invert18,'Value') get(handles.invert19,'Value') get(handles.invert20,'Value') get(handles.invert21,'Value') get(handles.invert22,'Value') get(handles.invert23,'Value') get(handles.invert24,'Value')]
version=get(handles.enhancer,'Value')+2*get(handles.version3,'Value');%%0=v1,1=v2,2=v3

set(handles.textcurrentcluster, 'String', '0');
%joshtester
autodiscrim_mobile


if(get(handles.testprogress,'String')~='ABORTED')
    set(handles.textbackground, 'String', '');
    set(handles.textnovel, 'String', '');
    set(handles.testprogress, 'String', 'COMPLETED');
    set(handles.trinum, 'String', '');
end


function expername_Callback(hObject, eventdata, handles)
% hObject    handle to expername (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of expername as text
%        str2double(get(hObject,'String')) returns contents of expername as a double


% --- Executes during object creation, after setting all properties.
function expername_CreateFcn(hObject, eventdata, handles)
% hObject    handle to expername (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function totalbnum_Callback(hObject, eventdata, handles)
% hObject    handle to totalbnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of totalbnum as text
%        str2double(get(hObject,'String')) returns contents of totalbnum as a double


% --- Executes during object creation, after setting all properties.
function totalbnum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to totalbnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nvbnum_Callback(hObject, eventdata, handles)
% hObject    handle to nvbnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nvbnum as text
%        str2double(get(hObject,'String')) returns contents of nvbnum as a double


% --- Executes during object creation, after setting all properties.
function nvbnum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nvbnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function att_Callback(hObject, eventdata, handles)
% hObject    handle to att (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of att as text
%        str2double(get(hObject,'String')) returns contents of att as a double


% --- Executes during object creation, after setting all properties.
function att_CreateFcn(hObject, eventdata, handles)
% hObject    handle to att (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theshld_Callback(hObject, eventdata, handles)
% hObject    handle to theshld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theshld as text
%        str2double(get(hObject,'String')) returns contents of theshld as a double


% --- Executes during object creation, after setting all properties.
function theshld_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theshld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pint_Callback(hObject, eventdata, handles)
% hObject    handle to pint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pint as text
%        str2double(get(hObject,'String')) returns contents of pint as a double


% --- Executes during object creation, after setting all properties.
function pint_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bint_Callback(hObject, eventdata, handles)
% hObject    handle to bint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bint as text
%        str2double(get(hObject,'String')) returns contents of bint as a double


% --- Executes during object creation, after setting all properties.
function bint_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tint_Callback(hObject, eventdata, handles)
% hObject    handle to tint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tint as text
%        str2double(get(hObject,'String')) returns contents of tint as a double


% --- Executes during object creation, after setting all properties.
function tint_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cint_Callback(hObject, eventdata, handles)
% hObject    handle to cint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cint as text
%        str2double(get(hObject,'String')) returns contents of cint as a double


% --- Executes during object creation, after setting all properties.
function cint_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pretri_Callback(hObject, eventdata, handles)
% hObject    handle to pretri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pretri as text
%        str2double(get(hObject,'String')) returns contents of pretri as a double


% --- Executes during object creation, after setting all properties.
function pretri_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pretri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function posttri_Callback(hObject, eventdata, handles)
% hObject    handle to posttri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of posttri as text
%        str2double(get(hObject,'String')) returns contents of posttri as a double


% --- Executes during object creation, after setting all properties.
function posttri_CreateFcn(hObject, eventdata, handles)
% hObject    handle to posttri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function datebox_Callback(hObject, eventdata, handles)
% hObject    handle to datebox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of datebox as text
%        str2double(get(hObject,'String')) returns contents of datebox as a double


% --- Executes during object creation, after setting all properties.
function datebox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to datebox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function timebox_Callback(hObject, eventdata, handles)
% hObject    handle to timebox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of timebox as text
%        str2double(get(hObject,'String')) returns contents of timebox as a double


% --- Executes during object creation, after setting all properties.
function timebox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timebox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tempbox_Callback(hObject, eventdata, handles)
% hObject    handle to tempbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tempbox as text
%        str2double(get(hObject,'String')) returns contents of tempbox as a double


% --- Executes during object creation, after setting all properties.
function tempbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tempbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function condbox_Callback(hObject, eventdata, handles)
% hObject    handle to condbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of condbox as text
%        str2double(get(hObject,'String')) returns contents of condbox as a double


% --- Executes during object creation, after setting all properties.
function condbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to condbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fishid_Callback(hObject, eventdata, handles)
% hObject    handle to fishid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fishid as text
%        str2double(get(hObject,'String')) returns contents of fishid as a double


% --- Executes during object creation, after setting all properties.
function fishid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fishid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function infobox_Callback(hObject, eventdata, handles)
% hObject    handle to infobox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of infobox as text
%        str2double(get(hObject,'String')) returns contents of infobox as a double


% --- Executes during object creation, after setting all properties.
function infobox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to infobox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numclust_Callback(hObject, eventdata, handles)
% hObject    handle to numclust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numclust as text
%        str2double(get(hObject,'String')) returns contents of numclust as a double


% --- Executes during object creation, after setting all properties.
function numclust_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numclust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadA3.
function loadA3_Callback(hObject, eventdata, handles)
% hObject    handle to loadA3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimA3 filename_wavestimA3 stimwave_A3 srate_wavestim_A3
[filename_wavestimA3, pathname_wavestimA3] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimA3,filename_wavestimA3), '-mat');
srate_wavestim_A3 = srate;
set(handles.text40,'String',filename_wavestimA3);
stimwave_A3 = stimwave;
cd(char(pathname_wavestimA3))

% --- Executes on button press in loadA4.
function loadA4_Callback(hObject, eventdata, handles)
% hObject    handle to loadA4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimA4 filename_wavestimA4 stimwave_A4 srate_wavestim_A4
[filename_wavestimA4, pathname_wavestimA4] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimA4,filename_wavestimA4), '-mat');
srate_wavestim_A4 = srate;
set(handles.text41,'String',filename_wavestimA4);
stimwave_A4 = stimwave;
cd(char(pathname_wavestimA4))

% --- Executes on button press in no13.
function no13_Callback(hObject, eventdata, handles)
% hObject    handle to no13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of no13


% --- Executes on button press in invert13.
function invert13_Callback(hObject, eventdata, handles)
% hObject    handle to invert13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert13


% --- Executes on button press in no14.
function no14_Callback(hObject, eventdata, handles)
% hObject    handle to no14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no14


% --- Executes on button press in invert14.
function invert14_Callback(hObject, eventdata, handles)
% hObject    handle to invert14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert14


% --- Executes on button press in loadB3.
function loadB3_Callback(hObject, eventdata, handles)
% hObject    handle to loadB3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimB3 filename_wavestimB3 stimwave_B3 srate_wavestim_B3
[filename_wavestimB3, pathname_wavestimB3] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimB3,filename_wavestimB3), '-mat');
srate_wavestim_B3 = srate;
set(handles.text42,'String',filename_wavestimB3);
stimwave_B3 = stimwave;
cd(char(pathname_wavestimB3))

% --- Executes on button press in loadB4.
function loadB4_Callback(hObject, eventdata, handles)
% hObject    handle to loadB4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimB4 filename_wavestimB4 stimwave_B4 srate_wavestim_B4
[filename_wavestimB4, pathname_wavestimB4] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimB4,filename_wavestimB4), '-mat');
srate_wavestim_B4 = srate;
set(handles.text43,'String',filename_wavestimB4);
stimwave_B4 = stimwave;
cd(char(pathname_wavestimB4))

% --- Executes on button press in no15.
function no15_Callback(hObject, eventdata, handles)
% hObject    handle to no15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no15


% --- Executes on button press in invert15.
function invert15_Callback(hObject, eventdata, handles)
% hObject    handle to invert15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert15


% --- Executes on button press in no16.
function no16_Callback(hObject, eventdata, handles)
% hObject    handle to no16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no16


% --- Executes on button press in invert16.
function invert16_Callback(hObject, eventdata, handles)
% hObject    handle to invert16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert16


% --- Executes on button press in loadC3.
function loadC3_Callback(hObject, eventdata, handles)
% hObject    handle to loadC3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimC3 filename_wavestimC3 stimwave_C3 srate_wavestim_C3
[filename_wavestimC3, pathname_wavestimC3] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimC3,filename_wavestimC3), '-mat');
srate_wavestim_C3 = srate;
set(handles.text44,'String',filename_wavestimC3);
stimwave_C3 = stimwave;
cd(char(pathname_wavestimC3))

% --- Executes on button press in loadC4.
function loadC4_Callback(hObject, eventdata, handles)
% hObject    handle to loadC4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimC4 filename_wavestimC4 stimwave_C4 srate_wavestim_C4
[filename_wavestimC4, pathname_wavestimC4] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimC4,filename_wavestimC4), '-mat');
srate_wavestim_C4 = srate;
set(handles.text45,'String',filename_wavestimC4);
stimwave_C4 = stimwave;
cd(char(pathname_wavestimC4))

% --- Executes on button press in no17.
function no17_Callback(hObject, eventdata, handles)
% hObject    handle to no17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no17


% --- Executes on button press in invert17.
function invert17_Callback(hObject, eventdata, handles)
% hObject    handle to invert17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert17


% --- Executes on button press in no18.
function no18_Callback(hObject, eventdata, handles)
% hObject    handle to no18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no18


% --- Executes on button press in invert18.
function invert18_Callback(hObject, eventdata, handles)
% hObject    handle to invert18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert18


% --- Executes on button press in loadD3.
function loadD3_Callback(hObject, eventdata, handles)
% hObject    handle to loadD3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimD3 filename_wavestimD3 stimwave_D3 srate_wavestim_D3
[filename_wavestimD3, pathname_wavestimD3] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimD3,filename_wavestimD3), '-mat');
srate_wavestim_D3 = srate;
set(handles.text46,'String',filename_wavestimD3);
stimwave_D3 = stimwave;
cd(char(pathname_wavestimD3))

% --- Executes on button press in loadD4.
function loadD4_Callback(hObject, eventdata, handles)
% hObject    handle to loadD4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimD4 filename_wavestimD4 stimwave_D4 srate_wavestim_D4
[filename_wavestimD4, pathname_wavestimD4] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimD4,filename_wavestimD4), '-mat');
srate_wavestim_D4 = srate;
set(handles.text47,'String',filename_wavestimD4);
stimwave_D4 = stimwave;
cd(char(pathname_wavestimD4))

% --- Executes on button press in no19.
function no19_Callback(hObject, eventdata, handles)
% hObject    handle to no19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no19


% --- Executes on button press in invert19.
function invert19_Callback(hObject, eventdata, handles)
% hObject    handle to invert19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert19


% --- Executes on button press in no20.
function no20_Callback(hObject, eventdata, handles)
% hObject    handle to no20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no20


% --- Executes on button press in invert20.
function invert20_Callback(hObject, eventdata, handles)
% hObject    handle to invert20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert20


% --- Executes on button press in loadE3.
function loadE3_Callback(hObject, eventdata, handles)
% hObject    handle to loadE3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimE3 filename_wavestimE3 stimwave_E3 srate_wavestim_E3
[filename_wavestimE3, pathname_wavestimE3] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimE3,filename_wavestimE3), '-mat');
srate_wavestim_E3 = srate;
set(handles.text48,'String',filename_wavestimE3);
stimwave_E3 = stimwave;
cd(char(pathname_wavestimE3))

% --- Executes on button press in loadE4.
function loadE4_Callback(hObject, eventdata, handles)
% hObject    handle to loadE4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimE4 filename_wavestimE4 stimwave_E4 srate_wavestim_E4
[filename_wavestimE4, pathname_wavestimE4] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimE4,filename_wavestimE4), '-mat');
srate_wavestim_E4 = srate;
set(handles.text49,'String',filename_wavestimE4);
stimwave_E4 = stimwave;
cd(char(pathname_wavestimE4))

% --- Executes on button press in no21.
function no21_Callback(hObject, eventdata, handles)
% hObject    handle to no21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no21


% --- Executes on button press in invert21.
function invert21_Callback(hObject, eventdata, handles)
% hObject    handle to invert21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert21


% --- Executes on button press in no22.
function no22_Callback(hObject, eventdata, handles)
% hObject    handle to no22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no22


% --- Executes on button press in invert22.
function invert22_Callback(hObject, eventdata, handles)
% hObject    handle to invert22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert22


% --- Executes on button press in loadF3.
function loadF3_Callback(hObject, eventdata, handles)
% hObject    handle to loadF3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimF3 filename_wavestimF3 stimwave_F3 srate_wavestim_F3
[filename_wavestimF3, pathname_wavestimF3] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimF3,filename_wavestimF3), '-mat');
srate_wavestim_F3 = srate;
set(handles.text50,'String',filename_wavestimF3);
stimwave_F3 = stimwave;
cd(char(pathname_wavestimF3))

% --- Executes on button press in loadF4.
function loadF4_Callback(hObject, eventdata, handles)
% hObject    handle to loadF4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname_wavestimF4 filename_wavestimF4 stimwave_F4 srate_wavestim_F4
[filename_wavestimF4, pathname_wavestimF4] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestimF4,filename_wavestimF4), '-mat');
srate_wavestim_F4 = srate;
set(handles.text51,'String',filename_wavestimF4);
stimwave_F4 = stimwave;
cd(char(pathname_wavestimF4))

% --- Executes on button press in no23.
function no23_Callback(hObject, eventdata, handles)
% hObject    handle to no23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no23


% --- Executes on button press in invert23.
function invert23_Callback(hObject, eventdata, handles)
% hObject    handle to invert23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert23


% --- Executes on button press in no24.
function no24_Callback(hObject, eventdata, handles)
% hObject    handle to no24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no24


% --- Executes on button press in invert24.
function invert24_Callback(hObject, eventdata, handles)
% hObject    handle to invert24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert24


% --- Executes on button press in enhancer.
function enhancer_Callback(hObject, eventdata, handles)
% hObject    handle to enhancer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of enhancer
if (get(hObject,'Value')==1)
    set(handles.text56,'Visible','on');
    set(handles.text57,'Visible','off');
    set(handles.v3text,'Visible','off');
    set(handles.version3,'Value',0);
else
    set(handles.text56,'Visible','off');
    set(handles.text57,'Visible','on');
    set(handles.v3text,'Visible','off');
end


% --- Executes on button press in version3.
function version3_Callback(hObject, eventdata, handles)
% hObject    handle to version3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of version3
if (get(hObject,'Value')==1)
    set(handles.text56,'Visible','off');
    set(handles.text57,'Visible','off');
    set(handles.v3text,'Visible','on');
    set(handles.enhancer,'Value',0);
else
    set(handles.text56,'Visible','off');
    set(handles.text57,'Visible','on');
    set(handles.v3text,'Visible','off');
end


