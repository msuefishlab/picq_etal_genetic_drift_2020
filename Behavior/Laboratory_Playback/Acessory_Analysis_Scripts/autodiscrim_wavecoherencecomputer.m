function varargout = autodiscrim_wavecoherencecomputer(varargin)
% AUTODISCRIM_WAVECOHERENCECOMPUTER M-file for autodiscrim_wavecoherencecomputer.fig
%      AUTODISCRIM_WAVECOHERENCECOMPUTER, by itself, creates a new AUTODISCRIM_WAVECOHERENCECOMPUTER or raises the existing
%      singleton*.
%
%      H = AUTODISCRIM_WAVECOHERENCECOMPUTER returns the handle to a new AUTODISCRIM_WAVECOHERENCECOMPUTER or the handle to
%      the existing singleton*.
%
%      AUTODISCRIM_WAVECOHERENCECOMPUTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUTODISCRIM_WAVECOHERENCECOMPUTER.M with the given input arguments.
%
%      AUTODISCRIM_WAVECOHERENCECOMPUTER('Property','Value',...) creates a new AUTODISCRIM_WAVECOHERENCECOMPUTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before autodiscrim_wavecoherencecomputer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to autodiscrim_wavecoherencecomputer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help autodiscrim_wavecoherencecomputer

% Last Modified by GUIDE v2.5 08-Jun-2011 11:04:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @autodiscrim_wavecoherencecomputer_OpeningFcn, ...
                   'gui_OutputFcn',  @autodiscrim_wavecoherencecomputer_OutputFcn, ...
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


% --- Executes just before autodiscrim_wavecoherencecomputer is made visible.
function autodiscrim_wavecoherencecomputer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to autodiscrim_wavecoherencecomputer (see VARARGIN)

% Choose default command line output for autodiscrim_wavecoherencecomputer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes autodiscrim_wavecoherencecomputer wait for user response (see UIRESUME)
% uiwait(handles.figure1);




% --- Outputs from this function are returned to the command line.
function varargout = autodiscrim_wavecoherencecomputer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srate filename_wavestims waveforms nums
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loader.
function loader_Callback(hObject, eventdata, handles)
% hObject    handle to loader (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  filename_wavestims waveforms nums
[filename_wavestim4, pathname_wavestim4] = uigetfile('*.stim.wav.mat', 'Open stimulus waveform file...');
load (fullfile(pathname_wavestim4,filename_wavestim4), '-mat');
srate_wavestim_4 = srate;
%set(handles.text4,'String',filename_wavestim4);
stimwave_4 = stimwave;
cd(char(pathname_wavestim4))

pulsewaveform=autodiscrim_genstimwaveform(stimwave_4,srate_wavestim_4,srate,0,0);

[a,b]=size(waveforms)
if (a==0)
    waveforms=pulsewaveform;
else
[pulsewaveform_1,pulsewaveform_2,pulsenpts]= autodiscrim_zeropad(waveforms(a,:),pulsewaveform);

if (pulsenpts>b)
    waveforms = [zeros(a,floor((pulsenpts-b)/2)) waveforms zeros(a,ceil((pulsenpts-b)/2))];
end
waveforms(a+1,:)=pulsewaveform_2;
end


filename_wavestims=char(filename_wavestims,filename_wavestim4);
nums(a+1,:)=str2num(get(handles.edit1,'String'));
set(handles.text1,'String',filename_wavestims);
[a,b]=size(waveforms)

% --- Executes on button press in computer.
function computer_Callback(hObject, eventdata, handles)
% hObject    handle to computer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  filename_wavestims waveforms nums
[max,b]=size(waveforms)

dwaveforms=diff(waveforms')';

store=zeros(max+1,max+1);

nums

[alpha,beta]=size(store(2:end,1))
[alpha,beta]=size(nums)
store(2:end,1)=nums;
store(1,2:end)=nums';
dstore=store;
mult=dstore;
i=1;

while (i<=max)
    j=i+1;
    while (j<=max)
        
        rdiff=waveforms(i,:)-waveforms(j,:);
        squared=rdiff.*rdiff;
        rsum=sum(squared);
        
        ddiff=dwaveforms(i,:)-dwaveforms(j,:);
        dsquared=ddiff.*ddiff;
        dsum=sum(dsquared);
        
        
        store(i+1,j+1)=rsum;
        dstore(i+1,j+1)=dsum;
        store(j+1,i+1)=rsum;
        dstore(j+1,i+1)=dsum;
        mult(i+1,j+1)=rsum*dsum;
        mult(j+1,i+1)=dsum*dsum;
        j=j+1;
    end
    i=i+1;
end


% storemod=store;
% storemod(find(0==storemod))=99999
% 
% k=1;
% while (k<=15)
% In=find(storemod==min(min(storemod)))
% storemod(In)=k*100000;
% number(k,:)=In;
% k=k+1;
% end
% number
% storemod
num2str(ceil(store.*100)/100)
num2str(ceil(dstore.*100)/100)
num2str(ceil(mult.*100)/100)
set(handles.text1,'String',num2str(ceil(store.*100)/100));

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text1,'String','');
clear all


