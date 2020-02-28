function [eodwave, info, infoText] = ReadEODFile(filename, numToRead)
%READEODFILE  Read an EOD data file.
%
%   [EODWAVE, INFO, INFOTEXT] = READEODFILE(FILENAME) reads the standard 
%   Hopkin's Lab EOD file FILENAME.  EODWAVE is a cell array, each cell
%   containing a single EOD waveform from the file.  INFO is a structure
%   array (each element corresponding to one cell of EODWAVE) containing
%   the following fields read from the file:
%       version         date            time            specimen        
%       species         location        temperature     comment
%       nBits           nBytes          polarity        userData
%       sampRate        ADrange
%   INFOTEXT is a cell array of strings, each cell being the exact 
%   "information text" from one EOD record in the file.  The "information 
%   text" is the text containing the information that is put into the date, 
%   time, specimen, species, location, temperature, and comment fields of
%   INFO.
%
%   READEODFILE(FILENAME, NUMTOREAD) only reads and returns the first 
%   NUMTOREAD EOD records from the file FILENAME.
%
%   READEODFILE and READEODFILE([], NUMTOREAD) use a standard file dialog
%   box to let the user choose a file to read.
%
%   See also READONEEOD, WRITEEODFILE, DECODEWAVETEX

%   Written by B. Scott Jackson
%   $Revision 1.00$  $Date: 2005/01/27 15:26$

eodwave = {[]};
info = struct('version', {}, 'date', {}, 'time', {}, 'specimen', {}, 'species', {}, ...
                'location', {}, 'temperature', {}, 'comment', {}, 'nBits', {}, ...
                'nBytes', {}, 'polarity', {}, 'userData', {}, 'sampRate', {}, 'ADrange', {});
infoText = {''};

if nargin < 1 | isempty(filename) | ~ischar(filename) | (exist(filename) ~= 2)
    [filename, pathname] = uigetfile({'*.EOD', 'EOD Files (*.EOD)'; '*.*', 'All Files (*.*)'}, ...
                                                                       'Choose an EOD File');
    if (filename == 0) & (pathname == 0), lasterr = 'Cancelled by user.'; return; end
    filename = fullfile(pathname, filename);
end

if nargin < 2 | isempty(numToRead) | ~isnumeric(numToRead) | (numToRead ~= round(numToRead)) | (numToRead < 1)
    numToRead = Inf;
end

if length(numToRead) ~= 1
    error('Second argument must be a scalar.')
end

fid = fopen(filename, 'r');
if fid == -1cl
    error(['Could not open the file ''' filename '''.']);
end

k = 1;

try
    while k <= numToRead
        eodwave{k} = [];
        info(k).version = [];
        infoText{k} = '';
        
		[info(k).version, count] = fread(fid, 1, 'char');
		if(count ~= 1), error(''); end;
		
        [nchar, count] = fread(fid, 1, 'short');
		if(count ~= 1), error(''); end;
		[infoTextTemp, count] = fread(fid, nchar, 'char');
        if(count ~= nchar), error(''); end;
        infoTextTemp(find(infoTextTemp(1:(end-1)) == 10)) = 32; %replace new lines with spaces
        infoTextTemp = char(infoTextTemp(:).');
        infoText{k} = infoTextTemp;
		infoTemp = decodewavetex_updated(infoTextTemp);
        
        info(k).date = infoTemp.date;
        info(k).time = infoTemp.time;
        info(k).specimen = infoTemp.specimen;
        info(k).species = infoTemp.species;
        info(k).location = infoTemp.location;
        info(k).temperature = infoTemp.temperature;
        if isfield(infoTemp,'gain')
            info(k).gain = infoTemp.gain;
        end
        if isfield(infoTemp,'coupling')
            info(k).coupling = infoTemp.coupling;
        end
        info(k).comment = infoTemp.comment;
       
            
        [info(k).nBits, count] = fread(fid, 1, 'char');
		if(count ~= 1), error(''); end;
		[info(k).nBytes, count] = fread(fid, 1, 'char');
		if(count ~= 1), error(''); end;
		[info(k).polarity, count] = fread(fid, 1, 'char');
		if(count ~= 1), error(''); end;
		
        [info(k).userData,count]=fread(fid,6,'float');
		if(count ~= 6), error(''); end;
        
        [info(k).sampRate, count] = fread(fid, 1, 'ulong');
		if(count ~= 1), error(''); end;
        
        if info(k).sampRate == round(info(k).userData(1))
            info(k).sampRate = info(k).userData(1);
        end
            
		[info(k).ADrange, count]= fread(fid, 1, 'float');
		if(count ~= 1), error(''); end;
		
        [nPts, count] = fread(fid, 1, 'long');
		if(count ~= 1), error(''); end;
	
		[eodwave{k}, count] = fread(fid, nPts, 'short');
		if(count ~= nPts), error(''); end;
        
        k = k + 1;
    end
catch
    if k == 1
        if ~exist('lasterr', 'var') | isempty(lasterr)
             error(['Error occurred while reading the file ''' filename ...
                            '''.  Could be an invalid EOD file format.']);
        else
             error(lasterr);
        end
    else
        infoText(k) = [];
        info(k) = [];
        eodwave(k) = [];
        lasterr = [];
    end
end

fclose(fid);