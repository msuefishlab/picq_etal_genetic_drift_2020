function autodiscrim_autosave(handles,clusternum,clusterord,trialord)
global pathname_wavestimA1 filename_wavestimA1 pathname_wavestimA2 filename_wavestimA2 
global pathname_wavestimB1 filename_wavestimB1 pathname_wavestimB2 filename_wavestimB2 
global pathname_wavestimC1 filename_wavestimC1 pathname_wavestimC2 filename_wavestimC2 
global pathname_wavestimD1 filename_wavestimD1 pathname_wavestimD2 filename_wavestimD2 
global pathname_wavestimE1 filename_wavestimE1 pathname_wavestimE2 filename_wavestimE2 
global pathname_wavestimF1 filename_wavestimF1 pathname_wavestimF2 filename_wavestimF2 
global no_wave reversed
global eodtimes

date1 = get(handles.datebox,'String');
starttime = get(handles.timebox,'String');
temperature = str2num(get(handles.tempbox,'String'));
conductivity = str2num(get(handles.condbox,'String'));
identifiers= get(handles.fishid,'String');
otherinfo = get(handles.infobox,'String');

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

no_wave=[get(handles.no1,'Value') get(handles.no2,'Value') get(handles.no3,'Value') get(handles.no4,'Value') get(handles.no5,'Value') get(handles.no6,'Value') get(handles.no7,'Value') get(handles.no8,'Value') get(handles.no9,'Value') get(handles.no10,'Value') get(handles.no11,'Value') get(handles.no12,'Value')];        
reversed=[get(handles.invert1,'Value') get(handles.invert2,'Value') get(handles.invert3,'Value') get(handles.invert4,'Value') get(handles.invert5,'Value') get(handles.invert6,'Value') get(handles.invert7,'Value') get(handles.invert8,'Value') get(handles.invert9,'Value') get(handles.invert10,'Value') get(handles.invert11,'Value') get(handles.invert12,'Value')];
version=get(handles.enhancer, 'Value');

filename=get(handles.expername,'String');
pathname=get(handles.pathnametext,'String');
protocolname=get(handles.protocolname,'String');

save (fullfile(pathname,filename),'protocolname','clusterord','trialord','eodtimes','clusternum','date1','version', 'starttime','temperature','conductivity','identifiers','otherinfo','burstn','nvburstn','attention','threshold','pulseint','burstint','trialint', 'clusterint','preint','postint','numclusters','no_wave','reversed' ,'pathname_wavestimA1', 'filename_wavestimA1', 'pathname_wavestimA2', 'filename_wavestimA2','pathname_wavestimB1', 'filename_wavestimB1', 'pathname_wavestimB2', 'filename_wavestimB2','pathname_wavestimC1', 'filename_wavestimC1', 'pathname_wavestimC2', 'filename_wavestimC2', 'pathname_wavestimD1', 'filename_wavestimD1', 'pathname_wavestimD2', 'filename_wavestimD2','pathname_wavestimE1', 'filename_wavestimE1' ,'pathname_wavestimE2', 'filename_wavestimE2','pathname_wavestimF1' ,'filename_wavestimF1', 'pathname_wavestimF2', 'filename_wavestimF2')