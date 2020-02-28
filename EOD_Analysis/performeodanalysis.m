%%%%%%%%%%
%doeodanalysis.m
%modified from matt arnegard openmwv.m by jason gallant accesses a given directory and runs measurescript on the data modified for cabre complex project 6.5.08
%
%
%%%%%%%%%%
%--create output file & data headers---%do this only once (when opening .eod file), so that you can measure 
% several waves and save the stats to the same output file without always writing new column headings

clear errorlist;

localities={'Bambomo','Cocobeach','Ivindo','Libreville','LowerLoetsi','Mouvanga','Ntem','Nyanga','Ogoue','Okano','UpperLoetsi','Woleu'};
[junk, sizeoflocalities]=size(localities);
basedirectory=input('Please Enter the Directory in Which the EOD Library is Located. (Include / at end!): ','s')
directory={};

if exist('templocdata') ==0;
    input('Please Select the Temperature/Locality Data');
    uiopen;
end
%%%%%%%%%%%%%%%%
%Establish Directories
%%%%%%%%%%%%%%%%
for i=1:+1:sizeoflocalities
    directory(i)={[basedirectory, char(localities(i))]};

end
[junk,endofd]=size(directory);

%%%%%%%%%%%%%%%%%%%%%%%    
% For Each Directory
%%%%%%%%%%%%%%%%%%%%%%%
statcount=1;
for d=1:+1:endofd;
    pn=char(directory(d));
    eoddatafilename=[pn '/eoddata.mat'];
    load(eoddatafilename, 'eod_files');
    [number_of_files,junk]=size(eod_files.name); %counts the number of EOD files in 'directory'
    counter=1; %sets the counter to 1 (beginning of directory)

    %%%%%%%%%%%%%
    %For Each file in the Directory
    %%%%%%%%%%%%%
    
    for counter = 1:+1:	number_of_files;  %iterates process from 1 to the number_of_files	

            fn=eod_files.name(counter);                              %filenames are stored in the array 'eod_files in the name matrix.										
            inputfile = fullfile(pn,char(fn));							%assigns variable inputfile to full file path
            [rowdata, columndata]=find(strcmp(templocdata,fn));
            
            if cell2mat(eod_files.best_eod(counter)) == 0
                eod_files.best_eod(counter)=1;
            else           
             besteod=cell2mat(eod_files.best_eod(counter));
             [eodwave, info, infoText] = ReadEODFile(inputfile);
               
                wave_text=infoText(besteod);
                n_bits=info(besteod).nBits;				    %?bits of vertical resolution?
                n_bytes=info(besteod).nBytes;				%?size of file?
                data_polarity=info(besteod).polarity;       %determined by user at time of recording
                user_data=info(besteod).userData;			%six user defn, usu unused floating pnts 32bit
                s_rate=info(besteod).sampRate;				%sampling rate of eod; unsigned long int 32 or 64 bit
                adrange=info(besteod).ADrange;				%?raw voltage range?
                [n_pts junk]=size(eodwave{besteod});			%number of points in eod sample
                wave=eodwave{besteod};
                time=linspace(0,1000*n_pts/s_rate,n_pts);

                wavetext=char(wave_text);
                wavenum=besteod;
                
                dccurrent; %open wave measuring screen
                
                DCOffset.Population(statcount,1)={char(localities(d))};
                DCOffset.FishID(statcount,1)={char(fn)};
                DCOffset.WaveNumber(statcount,1)=num2cell(besteod);
                DCOffset.DCVal(statcount,1)=num2cell(dcoffset);
                
                measurescript;

                EODData.fn(statcount,1)=fn;
                EODData.wavenum(statcount,1)=num2cell(wavenum);
                EODData.wavetext(statcount,1)={char(wavetext)};
                %EODData.fb(statcount,1)=num2cell(fb);
                EODData.temp(statcount,1)={char(info(besteod).temperature)};
                EODData.Population(statcount,1)={char(localities(d))};
                EODData.Location(statcount,1)={char(info(besteod).location)};
                EODData.duration(statcount,1)=num2cell(tT2-tT1);
                EODData.tS0(statcount,1)=num2cell(tS0);
                EODData.vS0(statcount,1)=num2cell(vS0);
                EODData.sS0(statcount,1)=num2cell(sS0);
                EODData.tP0(statcount,1)=num2cell(tP0);
                EODData.vP0(statcount,1)=num2cell(vP0);
                EODData.tZC1(statcount,1)=num2cell(tZC1);
                EODData.sZC1(statcount,1)=num2cell(sZC1);
                EODData.tS1(statcount,1)=num2cell(tS1);
                EODData.vS1(statcount,1)=num2cell(vS1);
                EODData.sS1(statcount,1)=num2cell(sS1);
                EODData.vP1(statcount,1)=num2cell(vP1);
                EODData.tS2(statcount,1)=num2cell(tS2);
                EODData.vS2(statcount,1)=num2cell(vS2);
                EODData.sS2(statcount,1)=num2cell(sS2);
                EODData.tZC2(statcount,1)=num2cell(tZC2);
                EODData.sZC2(statcount,1)=num2cell(sZC2);
                EODData.tP2(statcount,1)=num2cell(tP2);
                EODData.flow(statcount,1)=num2cell(f_low);
                EODData.fftmax(statcount,1)=num2cell(fftmax);
                EODData.fhigh(statcount,1)=num2cell(f_high);
                EODData.ap0(statcount,1)=num2cell(ap0);
                EODData.ap1(statcount,1)=num2cell(p1aT1ZC2);
                EODData.ap2(statcount,1)=num2cell(p2aZC2T2);
                EODData.XCoord(statcount,1)=templocdata(rowdata,5);
                EODData.YCoord(statcount,1)=templocdata(rowdata,6);
    
                statcount=statcount+1

            end

    end


end
kingsleyaedata=dataset({nominal(EODData.Population),'Locality'},{(EODData.fn),'fn'},{cell2mat(EODData.wavenum),'wn'},{cell2mat(EODData.XCoord),'Xcoord'},{cell2mat(EODData.YCoord),'YCoord'},{cell2mat(EODData.duration),'Duration'},{cell2mat(EODData.tS0),'tS0'},{cell2mat(EODData.vS0),'vs0'},{cell2mat(EODData.sS0),'sS0'},{cell2mat(EODData.tP0),'tP0'},{cell2mat(EODData.vP0),'vP0'},{cell2mat(EODData.tZC1),'tZC1'},{cell2mat(EODData.sZC1),'sZC1'},{cell2mat(EODData.tS1),'tS1'},{cell2mat(EODData.vS1),'vS1'},{cell2mat(EODData.sS1),'sS1'},{cell2mat(EODData.vP1),'vP1'},{cell2mat(EODData.tS2),'tS2'},{cell2mat(EODData.vS2),'vS2'},{cell2mat(EODData.sS2),'sS2'},{cell2mat(EODData.tZC2),'tZC2'},{cell2mat(EODData.sZC2),'sZC2'},{cell2mat(EODData.tP2),'tP2'},{cell2mat(EODData.flow),'F_Low'},{cell2mat(EODData.fftmax),'F_Max'},{cell2mat(EODData.fhigh),'F_High'},{cell2mat(EODData.ap0),'ap0'},{cell2mat(EODData.ap1),'ap1'},{cell2mat(EODData.ap2),'ap2'});

keep DCOffset EODData kingsleyaedata templocdata;

