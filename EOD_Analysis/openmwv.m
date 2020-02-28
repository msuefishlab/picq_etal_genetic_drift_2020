%%%%%%%%%%
%openmwv.m
%opens an old multiwav for data input use
%prompts for the creation of an output file (with column headers)
%for measured wave statistics
%%%%%%%%%%

%[fn,pn]=uigetfile('C:\MATLAB6p5p1\toolbox\Mwv\Measeod\*.eod','Open input file...');
[fn,pn]=uigetfile('/Users/jgallant/Documents/Research/Kingsleaye Project','Open input file...');

													%opens file open dialog box;
													%fn=filename, pn=pathname
inputfile = [pn fn];							%assigns variable inputfile to file name
fid = fopen(inputfile, 'r');				%opens file, for 'r' read only
													%fid is an integer file identifier
[version,count]=fread(fid,1,'char');	%reads binary data from opened file fid
													%writes it into matrix version, here '1'=1x1
                                       %precision is 'char'=8 bit
													%out argument count is #elements success read                                       
if(count == 0)
	fprintf (1,'%s %d\n', 'Error on read, end of file, count = ',count)
													%FID=1 (standard output); \n (linefeed)
   return;										%causes return to invoking function or keyboard
end												%terminates scope of IF statement

wavenum=0;										%start with first EOD in file
nchar_text=fread(fid,1,'short');			%size of text info (precis short=integer 16bit)
temp=fread(fid,nchar_text,'char');		%integer representation of text info
wave_text=sprintf('%c',temp);				%writes %c formatted data to string wave_text
n_bits=fread(fid,1,'char');				%?bits of vertical resolution?
n_bytes=fread(fid,1,'char');				%?size of file?
data_polarity=fread(fid,1,'char');		%determined by user at time of recording
user_data=fread(fid,6,'float');			%six user defn, usu unused floating pnts 32bit
s_rate=fread(fid,1,'ulong');				%sampling rate of eod; unsigned long int 32 or 64 bit
adrange=fread(fid,1,'float');				%?raw voltage range?
n_pts=fread(fid,1,'long');					%number of points in eod sample
wave=fread(fid,n_pts,'short');			%eod voltage data
time=linspace(0,1000*n_pts/s_rate,n_pts);	%eod time data in milliseconds
wavenum
%--create output file & data headers---%do this only once (when opening .eod file), so that you can measure
%several waves and save the stats to the same output file without always writing new column headings
writedata = input('Create an output file for saving measured wave statistics? (y/n)','s');
writefn = 'c:\MATLAB6p5p1\toolbox\Mwv\measeod\data.txt';
if writedata=='y'
   disp([' Data will be written to ',writefn]);
   kontinue = input(' Continue? (y/n)','s');
   if kontinue=='y'
   fprintf(writefn, 'filename\twave#\ttext\ttT1\ttS0\tvS0\tsS0\ttP0\tvP0\ttZC1\tsZC1\ttS1\tvS1\tsS1\ttP1\tvP1\ttS2\tvS2\tsS2\ttZC2\tsZC2\ttP2\tvP2\ttS3\tvS3\tsS3\ttZC3\tsZC3\ttP3\tvP3\ttS4\tvS4\tsS4\ttZC4\tsZC4\ttP4\tvP4\ttS5\tvS5\tsS5\ttT2\tf_low\tfftmax\tf_high\tp0area(T1-ZC1)\tp0area(S0-ZC1)\tp1area(ZC1-ZC2)\tp1area(ZC1-S2)\tp1area(ZC1-T2)\tp1area(T1-ZC2)\tp1area(S1-ZC2)\tp2area(ZC2-ZC3)\tp2area(ZC2-S3)\tp2area(ZC2-T2)\tp3area(ZC3-ZC4)\tp3area(ZC3-S4)\tp3area(ZC3-T2)\tp4area(ZC4-S5)\tp4area(ZC4-T2)\n');
	end
   %if continue=='y'
   %fprintf(writefn, 'filename\twave#\ttext\tp1area(T1-ZC2)\tp1area(S1-ZC2)\n');
	%end   
end

