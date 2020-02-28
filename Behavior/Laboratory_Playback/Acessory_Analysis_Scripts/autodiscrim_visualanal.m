function varargout = autodiscrim_visualanal(varargin)
% AUTODISCRIM_VISUALANAL M-file for autodiscrim_visualanal.fig
%      AUTODISCRIM_VISUALANAL, by itself, creates a new AUTODISCRIM_VISUALANAL or raises the existing
%      singleton*.
%
%      H = AUTODISCRIM_VISUALANAL returns the handle to a new AUTODISCRIM_VISUALANAL or the handle to
%      the existing singleton*.
%
%      AUTODISCRIM_VISUALANAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUTODISCRIM_VISUALANAL.M with the given input arguments.
%
%      AUTODISCRIM_VISUALANAL('Property','Value',...) creates a new AUTODISCRIM_VISUALANAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before autodiscrim_visualanal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to autodiscrim_visualanal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help autodiscrim_visualanal

% Last Modified by GUIDE v2.5 20-Jul-2011 10:48:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @autodiscrim_visualanal_OpeningFcn, ...
                   'gui_OutputFcn',  @autodiscrim_visualanal_OutputFcn, ...
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


% --- Executes just before autodiscrim_visualanal is made visible.
function autodiscrim_visualanal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to autodiscrim_visualanal (see VARARGIN)

% Choose default command line output for autodiscrim_visualanal
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes autodiscrim_visualanal wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = autodiscrim_visualanal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

global xdata ydata protocol clustero trialo date2 starttime1 identifiers1 otherinfo1 burstn1 nvburstn1
global eodtimes2 esdf sd1 sd2 burstint1 pulseint1 clusterint1 preint1 postint1 numclusters1 expername
global a b fignum bin_size stimints time_sdf deltamaxsdf deltamaxsd1 deltamaxsd2 deltavgsdf deltavgsd1 deltavgsd2
fignum=2;


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xdata ydata protocol clustero trialo date2 starttime1 identifiers1 otherinfo1 burstn1 nvburstn1
global eodtimes2 esdf sd1 sd2 burstint1 pulseint1 clusterint1 preint1 postint1 numclusters1 expername
global a b fignum bin_size stimints time_sdf deltamaxsdf deltamaxsd1 deltamaxsd2 deltavgsdf deltavgsd1 deltavgsd2

% clear xdata ydata protocol clustero trialo date1 starttime1 identifiers1 otherinfo1 burstn1 nvburstn1
% clear eodtimes2 esdf sd1 sd2 burstint1 pulseint1 clusterint1 preint1 postint1 numclusters1 expername
% clear a b fignum bin_size stimints time_sdf 
% fignum=2;



[expername, experpath] = uigetfile('*.mat', 'Open experimental data file...');
load (fullfile(experpath,expername), '-mat');

set(handles.workingtext,'Visible','on');
pause(.01)

eodtimes2=eodtimes;
protocol=protocolname;
clustero=clusterord;
trialo=trialord;
%date2=date1;
statrttime1=starttime;
identifiers1=identifiers;
otherinfo1=otherinfo;
burstn1=burstn;
nvburstn1=nvburstn;
burstint1=burstint;
pulseint1=pulseint;
clusterint1=clusterint;
preint1=preint;
postint1=postint;
numclusters1=numclusters;

bin_size=500;

set(handles.modetext,'String','Normal');
sdfcalc([])



set(handles.protocoltext,'String',protocol);
set(handles.experimenttext,'String',expername);
set(handles.workingtext,'Visible','off');
set(handles.currenttext,'String',num2str(1));
updatetrial(handles)
updateruntimenum(handles)

%set popup menu
options=char('Select Graph Type','EOD-Intervals','EOD-Frequency','EOD-Intervals-stair','EOD-Frequency-stair','SDF','SDF-maxes','SDF-mins','SDF-window', 'dSDF','dSDF-abs','dSDF-maxes','dSDF-mins','dSDF-window', 'ddSDF','ddSDF-maxes','ddSDF-mins','ddSDF-window','SDF(t+tau) vs. SDF(t) Return Map', 'dSDF vs. SDF Return Map');
set(handles.popupmenu1,'String',options);



function [f]=expfitter(x,y)
    
    %exponential
lny=log(y)
nums=polyfit(x,lny,1)
% C=exp(nums(2))
% a=nums(1)
t=1:.01:10;
f=exp(nums(1).*t+nums(2));


% nums=polyfit(x,y,4);
 %t=1:.01:10;
 %f=polyval(nums,t);


%plot(x,lny,'r.',x,polyval(nums,x),'-')




function sdfcalc(counter)
global xdata ydata protocol clustero trialo date2 starttime1 identifiers1 otherinfo1 burstn1 nvburstn1
global eodtimes2 esdf sd1 sd2 burstint1 pulseint1 clusterint1 preint1 postint1 numclusters1 expername
global a b fignum bin_size stimints time_sdf deltamaxsdf deltamaxsd1 deltamaxsd2 deltavgsdf deltavgsd1 deltavgsd2
%%%%%%%%%%%%%%%modifed from stim1playback_novel_anal  (B. Carlson)%%%%%%%%%%%%%
 if isempty(burstint1)==1,
    stimints = [0 genstimsequence('Constant Interval',totalpulsenum,pulseint)];
    novelstart = novelpulsenum;
    novelend = novelpulsenum;
else
    stimints = 0;
    burstseq = [repmat(pulseint1,1,9)];
    for i=1:burstn1-1,
        stimints = [stimints burstseq burstint1];   
    end
    stimints = [stimints burstseq];
    novelstart = ((nvburstn1-1)*10)+1;
    novelend = nvburstn1*10;
end
stimints_current = stimints;
 [a,b] = size(eodtimes2);
 if (~isempty(counter)&counter==1)
      esdf=zeros(a,ceil((preint1 + postint1 + sum(stimints)/1000) * 1000));
      sd1=esdf;
      sd2=esdf;
 elseif (isempty(counter))
     esdf=[];
     sd1=[];
     sd2=[];
 end
 
 for i=1:a
        eodtimes_sdf = eodtimes2(i,:) + preint1;%
        [f,d,d2,b] = sdf(eodtimes_sdf,bin_size);    %calculates sdf (f), deriv (d), second deriv (d2), binned spike times (b)
        desired_samples = ceil((preint1 + postint1 + sum(stimints)/1000) * 1000)
        length(f)
        length(d)
        if desired_samples>length(f),
            f = [f zeros(1,desired_samples-length(f))];
            d = [d zeros(1,desired_samples-length(d))];
            d2 = [d2 zeros(1,desired_samples-length(d2))];
        elseif desired_samples<length(f),
            f = f(1:desired_samples);
            d = d(1:desired_samples);
            d2 = d2(1:desired_samples);
        end
        if (isempty(counter))
        eod_sdf(i,:) = f;
        length(d)
        size(sd1)
        sd1(i,:)=d;
        sd2(i,:)=d2;
        else
            eod_sdf(i,:) = ((counter-1).*esdf(i,:)+f)./counter;
            sd1(i,:)=((counter-1).*sd1(i,:)+d)./counter;
            sd2(i,:)=((counter-1).*sd2(i,:)+d2)./counter;
        end
end
    time_sdf = [1/1000:1/1000:length(eod_sdf)/1000]-preint1;
    esdf=eod_sdf;
    
    %if(isempty(counter))
        calcdeltas()
      %  calcdeltalike()
    %end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function calcdeltalike()
    global xdata ydata protocol clustero trialo date2 starttime1 identifiers1 otherinfo1 burstn1 nvburstn1
    global eodtimes2 esdf sd1 sd2 burstint1 pulseint1 clusterint1 preint1 postint1 numclusters1 expername
    global a b fignum bin_size stimints time_sdf deltamaxsdf deltamaxsd1 deltamaxsd2 deltavgsdf deltavgsd1 deltavgsd2
   
    global fulldeltavg1sdf fulldeltavg2sdf fulldeltavg5sdf fulldeltavg1sd1 fulldeltavg2sd1 fulldeltavg5sd1 fulldeltavg1sd2 fulldeltavg2sd2 fulldeltavg5sd2 fulldeltavg0sdf fullsdfmax
     
  
    
    j=[1:30]';
    
    stimtimes = cumsum(stimints);
    burstinds = [1 find(stimints==burstint1)];           
    burststrt = stimtimes(burstinds);                   
    burstends = burststrt + (pulseint1*9);                   
    burststrt = burststrt/1000;                        
    burstends = burstends/1000;    
    
     for i=1:length(burststrt),%all peaks
        strind = min(find(time_sdf>=burststrt(i)));
        endind = min(find(time_sdf>=burstends(i)+2));
        preind1=min(find(time_sdf>=burstends(i)-1));
        preind2=min(find(time_sdf>=burstends(i)-2));
        preind5=min(find(time_sdf>=burstends(i)-5));
        
        [sdfpeak(:,i),peakind(:,i)] = max(esdf(j,strind:endind),[],2);
        peakind(:,i) = peakind(:,i) + strind - 1;
        [sd1peak(:,i),peakind1(:,i)] = max(sd1(j,strind:endind),[],2);
        peakind1(:,i) = peakind1(:,i) + strind - 1;
        [sd2peak(:,i),peakind2(:,i)] = max(sd2(j,strind:endind),[],2);
        peakind2(:,i) = peakind2(:,i) + strind - 1;
        
        [presdfmean1(:,i)] = mean(esdf(j,preind1:strind-1),2);
        [presd1mean1(:,i)] = mean(sd1(j,preind1:strind-1),2);
        [presd2mean1(:,i)] = mean(sd2(j,preind1:strind-1),2);
        
        [presdfmean2(:,i)] = mean(esdf(j,preind2:strind-1),2);
        [presd1mean2(:,i)] = mean(sd1(j,preind2:strind-1),2);
        [presd2mean2(:,i)] = mean(sd2(j,preind2:strind-1),2);
        
        [presdfmean5(:,i)] = mean(esdf(j,preind5:strind-1),2);
        [presd1mean5(:,i)] = mean(sd1(j,preind5:strind-1),2);
        [presd2mean5(:,i)] = mean(sd2(j,preind5:strind-1),2);
        
        [presdfmean0(:,i)] = mean(esdf(j,strind-1),2);
        
     end
     
     fullsdfmax=sdfpeak;
     
     fulldeltavg1sdf=sdfpeak-presdfmean1;
     fulldeltavg2sdf=sdfpeak-presdfmean2;
     fulldeltavg5sdf=sdfpeak-presdfmean5;
     fulldeltavg0sdf=sdfpeak-presdfmean0;
     
     fulldeltavg1sd1 =sd1peak-presd1mean1;
     fulldeltavg2sd1 =sd1peak-presd1mean2;
     fulldeltavg5sd1 =sd1peak-presd1mean5;
     
     fulldeltavg1sd2=sd2peak-presd2mean1; 
     fulldeltavg2sd2=sd2peak-presd2mean2;
     fulldeltavg5sd2=sd2peak-presd2mean5;
     
%      dfulldeltavg1sdf=diff(fulldeltavg1sdf,[],2);
%      dfulldeltavg2sdf=diff(fulldeltavg2sdf,[],2);
%      dfulldeltavg5sdf=diff(fulldeltavg5sdf,[],2);
%      
%      dfulldeltavg1sd1 =diff(fulldeltavg1sd1,[],2);
%      dfulldeltavg2sd1 =diff(fulldeltavg2sd1,[],2);
%      dfulldeltavg5sd1 =diff(fulldeltavg5sd1,[],2);
%      
%      dfulldeltavg1sd2=diff(fulldeltavg1sd2,[],2);
%      dfulldeltavg2sd2=diff(fulldeltavg2sd2,[],2);
%      dfulldeltavg5sd2=diff(fulldeltavg5sd2,[],2);
     
     
    
    function calcdeltas()
    global xdata ydata protocol clustero trialo date2 starttime1 identifiers1 otherinfo1 burstn1 nvburstn1
    global eodtimes2 esdf sd1 sd2 burstint1 pulseint1 clusterint1 preint1 postint1 numclusters1 expername
    global a b fignum bin_size stimints time_sdf deltamaxsdf deltamaxsd1 deltamaxsd2 deltavgsdf deltavgsd1 deltavgsd2
    
    j=[1:30]';
    
    stimtimes = cumsum(stimints);
    burstinds = [1 find(stimints==burstint1)];           
    burststrt = stimtimes(burstinds);                   
    burstends = burststrt + (pulseint1*9);                   
    burststrt = burststrt/1000;                        
    burstends = burstends/1000;  
    
    
    
    i=nvburstn1-1;
        strind = min(find(time_sdf>=burststrt(i)));
        endind = min(find(time_sdf>=burstends(i)+2));
        %peaks of preceeding maximum
        [sdfpeakbefore,peakindbefore] = max(esdf(j,strind:endind),[],2);
        peakindbefore = peakindbefore + strind - 1;
        [sd1peakbefore,peakindbefore1] = max(sd1(j,strind:endind),[],2);
        peakindbefore1 = peakindbefore1 + strind - 1;
        [sd2peakbefore,peakindbefore2] = max(sd2(j,strind:endind),[],2);
        peakindbefore2 = peakindbefore2 + strind - 1;
     i=i+1;
        strind = min(find(time_sdf>=burststrt(i)));
        endind = min(find(time_sdf>=burstends(i)+2));
        preind=min(find(time_sdf>=burstends(i)-2));
        %%sdfpeaks
        [sdfpeak,peakind] = max(esdf(j,strind:endind),[],2);
        peakind = peakind + strind - 1;
        [sd1peak,peakind1] = max(sd1(j,strind:endind),[],2);
        peakind1 = peakind1 + strind - 1;
        [sd2peak,peakind2] = max(sd2(j,strind:endind),[],2);
        peakind2 = peakind2 + strind - 1;
        %%average values of preceeding 2 seconds
        [presdfmean] = mean(esdf(j,preind:strind-1),2);
        [presd1mean] = mean(sd1(j,preind:strind-1),2);
        [presd2mean] = mean(sd2(j,preind:strind-1),2);
    
%         [alpha1,beta1]=size(sdfpeak)
%         [alpha2,beta2]=size(presdfmean)
        
        deltamaxsdf=sdfpeak-sdfpeakbefore 
        deltamaxsd1=sd1peak-sd1peakbefore
        deltamaxsd2=sd2peak-sd2peakbefore 
        deltavgsdf=sdfpeak-presdfmean 
        deltavgsd1 =sd1peak-presd1mean 
        deltavgsd2=sd2peak-presd2mean 
        
        
   
        
        
    function labelsdf(handles, which)
    global xdata ydata protocol clustero trialo date2 starttime1 identifiers1 otherinfo1 burstn1 nvburstn1
    global eodtimes2 esdf sd1 sd2 burstint1 pulseint1 clusterint1 preint1 postint1 numclusters1 expername
    global a b fignum bin_size stimints time_sdf deltamaxsdf deltamaxsd1 deltamaxsd2 deltavgsdf deltavgsd1 deltavgsd2
    
    if(which<5)
        current_sdf=esdf(str2num(get(handles.currenttext,'String')),:);
    elseif(which<9)
        current_sdf=sd1(str2num(get(handles.currenttext,'String')),:);
    else
        current_sdf=sd2(str2num(get(handles.currenttext,'String')),:);
    end
        which=which-4*floor(which/4.001);
        
        baseline_start = min(find(time_sdf>=(-preint1+(bin_size/1000))));
        baseline_end = max(find(time_sdf<-(bin_size/1000)));
        baseline_mean = mean(current_sdf(baseline_start:baseline_end));
        baseline_std = std(current_sdf(baseline_start:baseline_end));   
    
%         plot(time_sdf,current_sdf,'k-','LineWidth',2)
%     
%         ylabel('EOD Rate (Hz)','FontSize',12)
%         xlabel('Time (s)','FontSize',12)
%         xlim([-preint1 postint1 + sum(stimints)/1000])   
%         yl = ylim;
%         ylim([0 yl(2)])
    
    colors=['-r ' ;'-g '; '-b ' ;'-m '; '-k '; '--r'; '--g' ;'--b'; '--m'; '--k'; '-.r' ;'-.g'; '-.b'; '-.m'; '-.k'; ':r ' ;':g '; ':b ' ;':m ' ;':k '];
    leg=['stim 01';'stim 02';'stim 03';'stim 04';'stim 05';'stim 06';'stim 07';'stim 08';'stim 09';'stim 10']
    leg(nvburstn1,:)='stim nv';
    stimtimes = cumsum(stimints);
    burstinds = [1 find(stimints==burstint1)];           
    burststrt = stimtimes(burstinds);                   
    burstends = burststrt + (pulseint1*9);                   
    burststrt = burststrt/1000;                        
    burstends = burstends/1000;                       
    for i=1:length(burststrt),
        strind = min(find(time_sdf>=burststrt(i)));
        endind = min(find(time_sdf>=burstends(i)+2));
        [sdfpeak(i),peakind(i)] = max(current_sdf(strind:endind));
        peakind(i) = peakind(i) + strind - 1;
        [sdfpeak2(i),peakind2(i)] = min(current_sdf(strind:endind));
        peakind2(i) = peakind2(i) + strind - 1; 
        if (which==4)
            plot(handles.axes1,(strind:endind)-strind,current_sdf(strind:endind),colors(i,:))
            areaunder(i,1)=sum(current_sdf(strind:endind-.75*(endind-strind))')%area under first half second
            areaunder(i,2)=sum(current_sdf(strind:endind-.5*(endind-strind))')%area under first  second
            areaunder(i,3)=sum(current_sdf(strind:endind-.25*(endind-strind))')%area under first and a half seconds
            areaunder(i,4)=sum(current_sdf(strind:endind-.0*(endind-strind))')%area under first 2 seconds
            hold on
        end
    end
    
    hold on
    if (which==1)%%full sdf
    plot(handles.axes1,time_sdf(peakind),sdfpeak,'g*')
    plot(handles.axes1,time_sdf(peakind(nvburstn1)),sdfpeak(nvburstn1),'*')   %recolor novel respose blue
    plot(handles.axes1,time_sdf(peakind2),sdfpeak2,'m*')
    plot(handles.axes1,time_sdf(peakind2(nvburstn1)),sdfpeak2(nvburstn1),'y*')   %recolor novel respose blue
    plot(handles.axes1,time_sdf(peakind2(nvburstn1)),sdfpeak2(nvburstn1),'o')   %recolor novel respose blue
    %burst start lines
    linemax=max(current_sdf);
%     if(linemax<30)
%         linemax=30;
%     end
    sdfpeak'
    linemin=min(current_sdf);
    if(linemin>0)
        linemin=0.00001;
    end
    for i=1:length(burststrt)
        plot(handles.axes1,[burststrt(i) burststrt(i)],[linemin linemax],'r')
        plot(handles.axes1,[burstends(i) burstends(i)],[linemin linemax],'r')
    end
    elseif (which==2)%%maxes
        hold off
        sdfpeak'
        plot(handles.axes1,sdfpeak(1)','g*')
        hold on
        plot(handles.axes1,sdfpeak','g*')
        plot(handles.axes1,nvburstn1,sdfpeak(nvburstn1)','*')   %recolor novel respose blue
        
        [ff]=expfitter([1:8],sdfpeak(1:8));
        %[C, ax]=expfitter([1:8],sdfpeak(1:8));
        t=1:.01:10;
        %plot(t,C*exp(ax.*t))  
        plot(t,ff)
    elseif(which==3)%%mins)
        hold off
        plot(handles.axes1,sdfpeak2(1)','m*')
        hold on
        plot(handles.axes1,sdfpeak2','m*')
        plot(handles.axes1,nvburstn1,sdfpeak2(nvburstn1)','y*')   %recolor novel response yellow
        plot(handles.axes1,nvburstn1,sdfpeak2(nvburstn1)','o')  
    elseif(which==4)
        legend(leg);
    end
    hold off
    
    set(handles.text1, 'String',char('Maxes:','',num2str(sdfpeak'),'','','Mins:','                ',num2str(sdfpeak2')))
    set(handles.text13, 'String',char('','','','Mean:','',num2str(mean(sdfpeak(1:nvburstn1-1))),'','Novel','',num2str(sdfpeak(nvburstn1)),'','','','','','','Mean:','                ',num2str(mean(sdfpeak2(1:nvburstn1-1))),'','Novel:','',num2str(sdfpeak2(nvburstn1))))
    updatetrial(handles)
    updateruntimenum(handles)
    
% --- Executes on button press in loadmulti.
function loadmulti_Callback(hObject, eventdata, handles)
% hObject    handle to loadmulti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xdata ydata protocol clustero trialo date2 starttime1 identifiers1 otherinfo1 burstn1 nvburstn1
global eodtimes2 esdf sd1 sd2 burstint1 pulseint1 clusterint1 preint1 postint1 numclusters1 expername
global a b fignum bin_size stimints time_sdf deltamaxsdf deltamaxsd1 deltamaxsd2 deltavgsdf deltavgsd1 deltavgsd2

% clear xdata ydata protocol clustero trialo date1 starttime1 identifiers1 otherinfo1 burstn1 nvburstn1
% clear eodtimes2 esdf sd1 sd2 burstint1 pulseint1 clusterint1 preint1 postint1 numclusters1 expername
% clear a b fignum bin_size stimints time_sdf 
% fignum=2;


[expername, experpath] = uiputfile('*.mat', 'Provide path and rootname @ for char, # for number...');
expsave=expername;
 check=exist(fullfile(experpath,expername),'file')
    
  if ((check)~=2)
        
        
   

set(handles.workingtext,'Visible','on');
chars='ABCDEFGHIJKLMNOPQRSTUVWXYZ';

changeindex=[];
type=(~isempty(findstr(expername,'@')))+2*(~isempty(findstr(expername,'#')));

if (type==1)
    changeindex=findstr(expername,'@');
elseif (type==2)
    changeindex=findstr(expername,'#');
else
    error('Name is not a valid root name')
end

a=1;
count=1;
bin_size=500;

while (count<=a)
  if (type==1)%%letter
    expername=strcat(expername(1:changeindex-1),chars(count),expername(changeindex+1:end))
  elseif (type==2)%number
    expername=strcat(expername(1:changeindex-1),num2str(count),expername(changeindex+1:end))
  end  
  
    check=exist(fullfile(experpath,expername),'file');
    
    if ((check)~=2)
        break;
    end
    set(handles.workingtext,'String',strvcat('Working',num2str(count)));
    pause(.01)
    
    %%%loading section%%%%
   load (fullfile(experpath,expername), '-mat');
  


    eodtimes2=eodtimes;
    if (count==1)
    protocol=protocolname;
    burstn1=burstn;
    nvburstn1=nvburstn;
    burstint1=burstint;
    pulseint1=pulseint;
    clusterint1=clusterint;
    preint1=preint;
    postint1=postint;
    numclusters1=numclusters;
    end
    date2(count,:)=date1;
    
    sdfcalc(count)    
    
    dmaxsdfsave(:,count)=deltamaxsdf;     
    dmaxsd1save(:,count)=deltamaxsd1;
    dmaxsd2save(:,count)=deltamaxsd2;
    
    davgsdfsave(:,count)=deltavgsdf;
    davgsd1save(:,count)=deltavgsd1;
    davgsd2save(:,count)=deltavgsd2;
    %%%%%%%%%%%%%%%%%%%%%%%
    count=count+1;
end

  deltamaxsdf=dmaxsdfsave;     
  deltamaxsd1=dmaxsd1save;
  deltamaxsd2=dmaxsd2save;
    
  deltavgsdf=davgsdfsave;
  deltavgsd1=davgsd1save;
  deltavgsd2=davgsd2save;


  if (type==1)%%letter
    expername=strcat(expername(1:changeindex-1),'@',expername(changeindex+1:end));
  elseif (type==2)%number
    expername=strcat(expername(1:changeindex-1),'#',expername(changeindex+1:end));
  end  
  
  
save (fullfile(experpath,expsave),'xdata', 'ydata', 'protocol', 'date2','burstn1', 'nvburstn1', 'esdf', 'sd1', 'sd2', 'burstint1', 'pulseint1', 'clusterint1', 'preint1', 'postint1', 'numclusters1', 'expername','a', 'b', 'fignum', 'bin_size', 'stimints', 'time_sdf','deltamaxsdf', 'deltamaxsd1', 'deltamaxsd2', 'deltavgsdf', 'deltavgsd1', 'deltavgsd2') 
    else
        load(fullfile(experpath,expername),'-mat');
    end

set(handles.modetext,'String','Multi');
set(handles.protocoltext,'String',protocol);
set(handles.experimenttext,'String',expername);
set(handles.workingtext,'Visible','off');
set(handles.currenttext,'String',num2str(1));updatetrial(handles)

set(handles.text15,'String','NA');
set(handles.text17,'String','NA');
set(handles.runorderbox,'Visible','off');

options=char('Select Graph Type','SDF','SDF-maxes','SDF-mins','SDF-window', 'dSDF','dSDF-abs','dSDF-maxes','dSDF-mins','dSDF-window', 'ddSDF','ddSDF-maxes','ddSDF-mins','ddSDF-window','SDF(t+tau) vs. SDF(t) Return Map', 'dSDF vs. SDF Return Map');
set(handles.popupmenu1,'String',options);

% --- Executes on button press in lmdelta.
function lmdelta_Callback(hObject, eventdata, handles)
% hObject    handle to lmdelta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xdata ydata protocol clustero trialo date2 starttime1 identifiers1 otherinfo1 burstn1 nvburstn1
global eodtimes2 esdf sd1 sd2 burstint1 pulseint1 clusterint1 preint1 postint1 numclusters1 expername
global a b fignum bin_size stimints time_sdf deltamaxsdf deltamaxsd1 deltamaxsd2 deltavgsdf deltavgsd1 deltavgsd2

global fulldeltavg1sdf fulldeltavg2sdf fulldeltavg5sdf fulldeltavg1sd1 fulldeltavg2sd1 fulldeltavg5sd1 fulldeltavg1sd2 fulldeltavg2sd2 fulldeltavg5sd2 fulldeltavg0sdf fullsdfmax
     
    davg1sdfsave=[];
    davg2sdfsave=[];
    davg5sdfsave=[];
    davg0sdfsave=[];
    
    davg1sd1save=[];
    davg2sd1save=[];
    davg5sd1save=[];
    
    davg1sd2save=[];
    davg2sd2save=[];
    davg5sd2save=[];
    
    fullsdfmaxsave=[];
    
    fulldeltavg1sdf=[];
    fulldeltavg2sdf=[];
    fulldeltavg5sdf=[];
    fulldeltavg0sdf=[];
    
    fulldeltavg1sd1=[];
    fulldeltavg2sd1=[];
    fulldeltavg5sd1=[];
    
    fulldeltavg1sd2=[];
    fulldeltavg2sd2=[];
    fulldeltavg5sd2=[];
    
    fullsdfmax=[];

% clear xdata ydata protocol clustero trialo date1 starttime1 identifiers1 otherinfo1 burstn1 nvburstn1
% clear eodtimes2 esdf sd1 sd2 burstint1 pulseint1 clusterint1 preint1 postint1 numclusters1 expername
% clear a b fignum bin_size stimints time_sdf 
% fignum=2;

date2=[];

[expername, experpath] = uiputfile('*.mat', 'Provide path and rootname @ for char, # for number...');
expsave=strcat(expername,'-delta');
 check=exist(fullfile(experpath,expsave),'file')
    
  if ((check)~=2)
        
        
   

set(handles.workingtext,'Visible','on');
chars='ABCDEFGHIJKLMNOPQRSTUVWXYZ';

changeindex=[];
type=(~isempty(findstr(expername,'@')))+2*(~isempty(findstr(expername,'#')));

if (type==1)
    changeindex=findstr(expername,'@');
elseif (type==2)
    changeindex=findstr(expername,'#');
else
    error('Name is not a valid root name')
end

a=1;
count=1;
bin_size=500;

while (count<=a)
  if (type==1)%%letter
    expername=strcat(expername(1:changeindex-1),chars(count),expername(changeindex+1:end))
  elseif (type==2)%number
    expername=strcat(expername(1:changeindex-1),num2str(count),expername(changeindex+1:end))
  end  
  
    check=exist(fullfile(experpath,expername),'file');
    
    if ((check)~=2)
        break;
    end
    set(handles.workingtext,'String',strvcat('Working',num2str(count)));
    pause(.01)
    
    %%%loading section%%%%
   load (fullfile(experpath,expername), '-mat');
  


    eodtimes2=eodtimes;
    if (count==1)
    protocol=protocolname;
    burstn1=burstn;
    nvburstn1=nvburstn;
    burstint1=burstint;
    pulseint1=pulseint;
    clusterint1=clusterint;
    preint1=preint;
    postint1=postint;
    numclusters1=numclusters;
    end
    if (exist('date1')>0)
    date2(count,:)=date1;
    end
    
    sdfcalc(count)    
    calcdeltalike();
    
    dmaxsdfsave(:,count)=deltamaxsdf;     
    dmaxsd1save(:,count)=deltamaxsd1;
    dmaxsd2save(:,count)=deltamaxsd2;
    
    davgsdfsave(:,count)=deltavgsdf;
    davgsd1save(:,count)=deltavgsd1;
    davgsd2save(:,count)=deltavgsd2;
    
    davg1sdfsave=[davg1sdfsave;fulldeltavg1sdf];
    davg2sdfsave=[davg2sdfsave;fulldeltavg2sdf];
    davg5sdfsave=[davg5sdfsave;fulldeltavg5sdf];
    davg0sdfsave=[davg0sdfsave;fulldeltavg0sdf];
    
    davg1sd1save=[davg1sd1save;fulldeltavg1sd1];
    davg2sd1save=[davg2sd1save;fulldeltavg2sd1];
    davg5sd1save=[davg5sd1save;fulldeltavg5sd1];
    
    davg1sd2save=[davg1sd2save;fulldeltavg1sd2];
    davg2sd2save=[davg2sd2save;fulldeltavg2sd2];
    davg5sd2save=[davg5sd2save;fulldeltavg5sd2];
    
    fullsdfmaxsave=[fullsdfmaxsave;fullsdfmax];
    
    %%%%%%%%%%%%%%%%%%%%%%%
    count=count+1;
end

  deltamaxsdf=dmaxsdfsave;     
  deltamaxsd1=dmaxsd1save;
  deltamaxsd2=dmaxsd2save;
    
  deltavgsdf=davgsdfsave;
  deltavgsd1=davgsd1save;
  deltavgsd2=davgsd2save;

    fulldeltavg1sdf=davg1sdfsave;
    fulldeltavg2sdf=davg2sdfsave;
    fulldeltavg5sdf=davg5sdfsave;
    fulldeltavg0sdf=davg0sdfsave;
    
    fulldeltavg1sd1=davg1sd1save;
    fulldeltavg2sd1=davg2sd1save;
    fulldeltavg5sd1=davg5sd1save;
    
    fulldeltavg1sd2=davg1sd2save;
    fulldeltavg2sd2=davg2sd2save;
    fulldeltavg5sd2=davg5sd2save;
    
    fullsdfmax=fullsdfmaxsave;
  

  if (type==1)%%letter
    expername=strcat(expername(1:changeindex-1),'@',expername(changeindex+1:end));
  elseif (type==2)%number
    expername=strcat(expername(1:changeindex-1),'#',expername(changeindex+1:end));
  end  
  
  
save (fullfile(experpath,expsave),'xdata', 'ydata', 'protocol', 'date2','burstn1', 'nvburstn1', 'burstint1', 'pulseint1', 'clusterint1', 'preint1', 'postint1', 'numclusters1', 'expername','a', 'b', 'fignum', 'bin_size', 'stimints','deltamaxsdf', 'deltamaxsd1', 'deltamaxsd2','fulldeltavg1sdf', 'fulldeltavg2sdf', 'fulldeltavg5sdf','fulldeltavg0sdf', 'fulldeltavg1sd1', 'fulldeltavg2sd1', 'fulldeltavg5sd1', 'fulldeltavg1sd2', 'fulldeltavg2sd2', 'fulldeltavg5sd2','fullsdfmax') 
    else
        load(fullfile(experpath,expername),'-mat');
    end


set(handles.workingtext,'Visible','off');


% --- Executes on button press in popout.
function popout_Callback(hObject, eventdata, handles)
% hObject    handle to popout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fignum
h=figure(fignum)
%h=copyobj(handles.axes1,gca)
set(h,'CurrentAxes',copyobj(handles.axes1,gcf))
%axes(handles.axes1)
fignum=fignum+1;



function enactortext_Callback(hObject, eventdata, handles)
% hObject    handle to enactortext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of enactortext as text
%        str2double(get(hObject,'String')) returns contents of enactortext



        

% --- Executes during object creation, after setting all properties.
function enactortext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to enactortext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in enactor.
function enactor_Callback(hObject, eventdata, handles)
% hObject    handle to enactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a b fignum bin_size stimints time_sdf deltamaxsdf deltamaxsd1 deltamaxsd2 deltavgsdf deltavgsd1 deltavgsd2
%calcdeltas();
 mean(deltamaxsdf,2)     
  mean(deltamaxsd1,2)
  mean(deltamaxsd2,2)
    
  mean(deltavgsdf,2)
  mean(deltavgsd1,2)
  mean(deltavgsd2,2)

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
global xdata ydata protocol clustero trialo date1 starttime1 identifiers1 otherinfo1 burstn1 nvburstn1
global eodtimes2 esdf sd1 sd2 burstint1 pulseint1 clusterint1 preint1 postint1 numclusters1 expername
global a b fignum bin_size stimints time_sdf deltamaxsdf deltamaxsd1 deltamaxsd2 deltavgsdf deltavgsd1 deltavgsd2

set(handles.text1,'String','');
set(handles.text13,'String','');

 contents = get(hObject,'String');
 selection2=char(contents(get(hObject,'Value'),:));
 selection=selection2(~isspace(selection2));
 
 plotchosen(handles,selection,selection2);



function plotchosen(handles,sel,sel2)
global xdata ydata protocol clustero trialo date2 starttime1 identifiers1 otherinfo1 burstn1 nvburstn1
global eodtimes2 esdf sd1 sd2 burstint1 pulseint1 clusterint1 preint1 postint1 numclusters1 expername
global a b fignum bin_size stimints time_sdf deltamaxsdf deltamaxsd1 deltamaxsd2 deltavgsdf deltavgsd1 deltavgsd2


titletxt=strcat(expername,' (',protocol,'):  ',identifiers1,'   .',date2,'       .',get(handles.text9,'String'),'   .',sel2,'  (',get(handles.modetext,'String'),')')
if (strcmp(get(handles.modetext,'String'),'Multi'))
    titletxt=strcat(expername,' (',protocol,'):  ','   .',date2,'       .',get(handles.text9,'String'),'   .',sel2,'  (',get(handles.modetext,'String'),')')
    titletxt=titletxt(1,:);
end
switch sel
     case 'EOD-Intervals'
            plot(handles.axes1,eodtimes2(str2num(get(handles.currenttext,'String')),2:end)',diff(eodtimes2(str2num(get(handles.currenttext,'String')),:)')*1000,'.')
            ylabel('EOD interval (ms)','FontSize',12)
            xlabel('Time (s)','FontSize',12)
            xlim([-preint1 postint1 + sum(stimints)/1000])
            title(titletxt,'FontSize',14)
     case 'EOD-Frequency'
            plot(handles.axes1,eodtimes2(str2num(get(handles.currenttext,'String')),2:end)',1./diff(eodtimes2(str2num(get(handles.currenttext,'String')),:)'),'.')%removed x1000 from y variable
            ylabel('Frequency (Hz)','FontSize',12)
            xlabel('Time (s)','FontSize',12)
            xlim([-preint1 postint1 + sum(stimints)/1000])
            title(titletxt,'FontSize',14)
     case 'EOD-Intervals-stair'
            stairs(handles.axes1,eodtimes2(str2num(get(handles.currenttext,'String')),2:end)',diff(eodtimes2(str2num(get(handles.currenttext,'String')),:)')*1000,'-')
            ylabel('EOD interval (ms)','FontSize',12)
            xlabel('Time (s)','FontSize',12)
            xlim([-preint1 postint1 + sum(stimints)/1000])
           title(titletxt,'FontSize',14)
     case 'EOD-Frequency-stair'
            stairs(handles.axes1,eodtimes2(str2num(get(handles.currenttext,'String')),2:end)',1./diff(eodtimes2(str2num(get(handles.currenttext,'String')),:)')*1000,'-')
            ylabel('Frequency (Hz)','FontSize',12)
            xlabel('Time (s)','FontSize',12)
            xlim([-preint1 postint1 + sum(stimints)/1000])
            title(titletxt,'FontSize',14)
     case'SDF'
        % length(esdf)
        % length(time_sdf)
            plot(handles.axes1,time_sdf(1,:)',esdf(str2num(get(handles.currenttext,'String')),:)','k-')
            labelsdf(handles,1);
            ylabel('Frequency (Hz)','FontSize',12)
            xlabel('Time (s)','FontSize',12)
            xlim([-preint1 postint1 + sum(stimints)/1000])
            title(titletxt,'FontSize',14)
     case'SDF-maxes'
            labelsdf(handles,2);
            ylabel('Frequency (Hz)','FontSize',12)
            xlabel('Response number','FontSize',12)
            xlim([.5 burstn1+.5])
            title(titletxt,'FontSize',14)
     case'SDF-mins'
            labelsdf(handles,3);
            ylabel('Frequency (Hz)','FontSize',12)
            xlabel('Response Number','FontSize',12)
            xlim([.5 burstn1+.5])
            title(titletxt,'FontSize',14)
     case'SDF-window'
            labelsdf(handles,4);
            ylabel('Frequency (Hz)','FontSize',12)
            xlabel('Response Number','FontSize',12)
            title(titletxt,'FontSize',14)
     case'dSDF'
            plot(handles.axes1,time_sdf(1,:)',sd1(str2num(get(handles.currenttext,'String')),:)','k-')
            labelsdf(handles,5);
            ylabel('dFrequency (Hz/s)','FontSize',12)
            xlabel('Time (s)','FontSize',12)
            xlim([-preint1 postint1 + sum(stimints)/1000])
            title(titletxt,'FontSize',14)
     case'dSDF-abs'
            plot(handles.axes1,time_sdf(1,:)',abs(sd1(str2num(get(handles.currenttext,'String')),:)'),'k-')
            labelsdf(handles,5);
            ylabel('Absolute Value of dFrequency (Hz/s)','FontSize',12)
            xlabel('Time (s)','FontSize',12)
            xlim([-preint1 postint1 + sum(stimints)/1000])
            title(titletxt,'FontSize',14)
     case 'dSDF-maxes'
            labelsdf(handles,6);
            ylabel('dFrequency (Hz/s)','FontSize',12)
            xlabel('Response number','FontSize',12)
            xlim([.5 burstn1+.5])
            title(titletxt,'FontSize',14)
     case 'dSDF-mins'
            labelsdf(handles,7);
            ylabel('dFrequency (Hz/s)','FontSize',12)
            xlabel('Response Number','FontSize',12)
            xlim([.5 burstn1+.5])
            title(titletxt,'FontSize',14)
     case 'dSDF-window'
            labelsdf(handles,8);
            ylabel('dFrequency (Hz/s)','FontSize',12)
            xlabel('Response Number','FontSize',12)
            title(titletxt,'FontSize',14)
     case 'ddSDF'
            plot(handles.axes1,time_sdf(1,:)',sd2(str2num(get(handles.currenttext,'String')),:)','k-')
            labelsdf(handles,9);
            ylabel('ddFrequency (Hz/s^-^2)','FontSize',12)
            xlabel('Time (s)','FontSize',12)
            xlim([-preint1 postint1 + sum(stimints)/1000])
            title(titletxt,'FontSize',14)
     case 'ddSDF-maxes'
            labelsdf(handles,10);
            ylabel('ddFrequency (Hz/s^-^2)','FontSize',12)
            xlabel('Response number','FontSize',12)
            xlim([.5 burstn1+.5])
            title(titletxt,'FontSize',14)
     case 'ddSDF-mins'
           labelsdf(handles,11);
            ylabel('ddFrequency (Hz/s^-^2)','FontSize',12)
            xlabel('Response Number','FontSize',12)
            xlim([.5 burstn1+.5])
           title(titletxt,'FontSize',14)
     case'ddSDF-window'
            labelsdf(handles,12);
            ylabel('ddFrequency (Hz/s^-^2)','FontSize',12)
            xlabel('Response Number','FontSize',12)
            xlim([.5 burstn1+.5])
            title(titletxt,'FontSize',14)
     case 'SDF(t+tau)vs.SDF(t)ReturnMap'
         tau=50;
          sdf1 = esdf(str2num(get(handles.currenttext,'String')),1:1:(length(esdf(str2num(get(handles.currenttext,'String')),:))-tau));
          sdf2 = esdf(str2num(get(handles.currenttext,'String')),(tau+1):1:length(esdf(str2num(get(handles.currenttext,'String')),:)));
          plot(sdf1,sdf2,'r-')
          xlabel('SDF(t) [s^-^1]')
          ylabel('SDF(t+tau) [s^-^1]')
          title(titletxt,'FontSize',14)
%           axis('equal')
%           axis('square')

    



     case 'dSDFvs.SDFReturnMap'
            plot(handles.axes1,esdf(str2num(get(handles.currenttext,'String')),:),sd1(str2num(get(handles.currenttext,'String')),:),'r-')
            xlabel('SDF [s^-^1]')
            ylabel('dSDF [s^-^2]')
            title(titletxt,'FontSize',14)   
            
        stimtimes = cumsum(stimints);
        burstinds = [1 find(stimints==burstint1)];           
        burststrt = stimtimes(burstinds);                   
        burstends = burststrt + (pulseint1*9);                   
        burststrt = burststrt/1000;                        
        burstends = burstends/1000;                       
        i=nvburstn1;
        strind = min(find(time_sdf>=burststrt(i)));
        endind = min(find(time_sdf>=burstends(i)+2));
        hold on
         plot(handles.axes1,esdf(str2num(get(handles.currenttext,'String')),(strind:endind)),sd1(str2num(get(handles.currenttext,'String')),(strind:endind)),'-')
         hold off
    end    
 
 
 
 
function updatetrial(handles)
        alpha='';
        num1='';
        num2='';

        upcount=str2num(get(handles.currenttext,'String'));
        clustercount=floor((upcount)/5.01)+1;
        t=upcount-5*(clustercount-1);
        
if (clustercount==1)
    alpha='A';
elseif (clustercount==2)
    alpha='B';
elseif (clustercount==3)
    alpha='C'; 
elseif (clustercount==4)
    alpha='D';
elseif (clustercount==5)
    alpha='E';
elseif (clustercount==6)
    alpha='F';
end
   
    
if (t==1)
    num1='1';
    num2='1';
elseif (t==2)
    num1='1';
    num2='2';
elseif (t==3)
    num1='1'; 
    num2='X';
elseif (t==4)
    num1='2';
    num2='1';
elseif (t==5)
    num1='X';
    num2='1';
end


set(handles.text9,'String',strcat(alpha,num1,'. vs. .',alpha,num2));

    
    
function updateruntimenum(handles)
global xdata ydata protocol clustero trialo date2 starttime1 identifiers1 otherinfo1 burstn1 nvburstn1
global eodtimes2 esdf sd1 sd2 burstint1 pulseint1 clusterint1 preint1 postint1 numclusters1 expername
global a b fignum bin_size stimints time_sdf deltamaxsdf deltamaxsd1 deltamaxsd2 deltavgsdf deltavgsd1 deltavgsd2
if (~strcmp(get(handles.modetext,'String'),'Multi'))
    if (get(handles.runorderbox,'Value')==0)
    upcount=str2num(get(handles.currenttext,'String'));
    clustercount=floor((upcount)/5.01)+1;
    t=upcount-5*(clustercount-1);
    runord=5*(find(clustero==clustercount)-1)+find(trialo(clustercount,:)==t);
    set(handles.text15,'String',num2str(runord));
    set(handles.text17,'String',num2str(runord));
    else
    upcount=str2num(get(handles.text15,'String'));
    clustercount=clustero(floor((upcount)/5.01)+1);
    t=trialo(clustercount,upcount-5*((floor((upcount)/5.01)+1)-1));               %%%%FIX THIS
    runord=5*(find(clustero==clustercount)-1)+find(trialo(clustercount,:)==t);
    set(handles.currenttext,'String',num2str(5*(clustercount-1)+t));
    end
end 
 
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


% --- Executes on button press in backbutton.
function backbutton_Callback(hObject, eventdata, handles)
% hObject    handle to backbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% if (str2num(get(handles.currenttext,'String'))<=1)
%     return;
% end   
% spotsave=get(handles.currenttext,'String');   
% 
% set(handles.currenttext,'String',num2str(str2num(spotsave)-1))
% 
% spotsave=get(handles.currenttext,'String');  
% 
% %if (get(handles.runtimeord,'Value')==1)
%  %   set(handles.currenttext,'String',num2str(COMPLEX))
% %end
%  contents = get(handles.popupmenu1,'String');
%  selection2=char(contents(get(handles.popupmenu1,'Value'),:));
%  selection=selection2(~isspace(selection2));
% 
% 
% plotchosen(handles,selection,selection2)
% 
% set(handles.currenttext,'String',spotsave)
% updatetrial(handles)
% updateruntimenum(handles)
if (get(handles.runorderbox,'Value')==0)
    spotsave=get(handles.currenttext,'String') ;
else
    spotsave=get(handles.text17,'String') ;
end

    if (str2num(spotsave)<=1)
        return;
    end   
      

if (get(handles.runorderbox,'Value')==0)
    set(handles.currenttext,'String',num2str(str2num(spotsave)-1))
else
    set(handles.text17,'String',num2str(str2num(spotsave)-1));
    set(handles.text15,'String',num2str(str2num(spotsave)-1));
end

     




%     spotsave=get(handles.currenttext,'String');  
% 
%     %if (get(handles.runtimeord,'Value')==1)
%      %   set(handles.currenttext,'String',num2str(COMPLEX))
%     %end
     contents = get(handles.popupmenu1,'String');
     selection2=char(contents(get(handles.popupmenu1,'Value'),:));
     selection=selection2(~isspace(selection2));

    updatetrial(handles)
    updateruntimenum(handles)
    
    plotchosen(handles,selection,selection2)





% --- Executes on button press in forwardbutton.
function forwardbutton_Callback(hObject, eventdata, handles)
% hObject    handle to forwardbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xdata ydata protocol clustero trialo date2 starttime1 identifiers1 otherinfo1 burstn1 nvburstn1
global eodtimes2 esdf sd1 sd2 burstint1 pulseint1 clusterint1 preint1 postint1 numclusters1 expername
global a b fignum bin_size stimints time_sdf deltamaxsdf deltamaxsd1 deltamaxsd2 deltavgsdf deltavgsd1 deltavgsd2


if (get(handles.runorderbox,'Value')==0)
    spotsave=get(handles.currenttext,'String') ;
else
    spotsave=get(handles.text17,'String') ;
end

 

    if (str2num(spotsave)>=a)
        return;
    end   
      

if (get(handles.runorderbox,'Value')==0)
    set(handles.currenttext,'String',num2str(str2num(spotsave)+1))
else
    set(handles.text17,'String',num2str(str2num(spotsave)+1));
    set(handles.text15,'String',num2str(str2num(spotsave)+1));
end

     




%     spotsave=get(handles.currenttext,'String');  
% 
%     %if (get(handles.runtimeord,'Value')==1)
%      %   set(handles.currenttext,'String',num2str(COMPLEX))
%     %end
     contents = get(handles.popupmenu1,'String');
     selection2=char(contents(get(handles.popupmenu1,'Value'),:));
     selection=selection2(~isspace(selection2));

    updatetrial(handles)
    updateruntimenum(handles)
    
    plotchosen(handles,selection,selection2)



%     set(handles.currenttext,'String',spotsave)
   

    

% --- Executes on button press in zoombox.
function zoombox_Callback(hObject, eventdata, handles)
% hObject    handle to zoombox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of zoombox
if (get(hObject,'Value')==1)
    zoom on;
else
    zoom off;
end

% --- Executes on button press in runorderbox.
function runorderbox_Callback(hObject, eventdata, handles)
% hObject    handle to runorderbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of runorderbox
if (get(hObject,'Value')==1)
   set(handles.text17,'Visible','on');
else
   set(handles.text17,'Visible','off');
end


% --- Executes on selection change in datapopupmenu.
function datapopupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to datapopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns datapopupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from datapopupmenu


% --- Executes during object creation, after setting all properties.
function datapopupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to datapopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





