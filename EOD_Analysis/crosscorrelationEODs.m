function newXcorr
startDir = pwd;
folder = uigetdir;
cd(folder);
files = dir( '*.mat');
N=length(files);
concat_data=[];
%concat_data = zeros(2049,N); %% set the length depending on the length of the longest waveform
tempFishID = zeros(N,1);
centroids=zeros(9,2); %change 9 to 11 when Mouvanga09-99 and Bambomo09-99 are separate groups

for i = 1:length(files)
    loadedFile = load(files(i,1).name);
    temp = regexp(files(i).name,'.*-(\d+)-.*','tokens');
    tempFishID(i) = str2double(temp{1});
    data = loadedFile.data;   
    % if length(data)~=length(concat_data)-1
    %   data2=[data;zeros(length(concat_data)-1-length(data),1)]
    %elseif length(data)==length(concat_data)-1
    %    data2=data
    %end
    
    fishGroupID = loadedFile.fishGroupID;
    %data2(end+1,1) = fishGroupID;
    data(end+1,1) = fishGroupID;
    concat_data=[concat_data,data];
   % concat_data(:,i) = data2;
    
end

%tag = sort(concat_data(end,:));
[values, order] = sort(concat_data(end,:));
sortedData = concat_data(:,order);
sortedFishID = tempFishID(order,1);
num_pop = unique(concat_data(end,:));
mdisMat = zeros(num_pop);
popSizeVec = zeros(1,length(num_pop));

for i=1:length(num_pop)
 popSizeVec(1,i)= length(find(concat_data(end,:) == num_pop(i)));
end

A = sortedData(1:end-1,:);
done = 0;
rowLength=size(A,2);

xd = zeros(length(A(1,:))); % create empty distance matrix
for i=1:length(xd(1,:))
    for j=1:length(xd(:,1))
        cor_list = xcorr(A(:,i),A(:,j),'coeff');
        abs_cor_list = abs(cor_list);
        xd(i,j) = max(abs_cor_list);
    end
end
result2 = round(xd * 1e10) * 1e-10;

[scaledResult2,stress] = mdscale(result2,2);
if(~exist([folder '\MDSResult'], 'dir'))
        mkdir([folder '\MDSResult'])
end
path_prefix = [folder '\MDSResult' ]
filename = [path_prefix '\MDSResult' ];
save(filename,'scaledResult2','stress');
stress
mdscalePlot(scaledResult2, sortedFishID,num_pop,popSizeVec);
hold on

title('Multidimensional scaling results');
xlabel('Dimension 1');
ylabel('Dimension 2');

if length(num_pop) > 1
j = 1;
for i=1:length(num_pop)%for the different populations: this may be from 1 to 11
    X = scaledResult2(j:j+popSizeVec(1,i)-1,:);
    meanX = mean(X);
    plot(meanX(1),meanX(2),'r.');
    text(meanX(1),meanX(2),num2str(num_pop(i)));
    centroids(i,:)=meanX;

   
w = 1;
for v = 1:length(num_pop)
    Y = scaledResult2(w:w+popSizeVec(1,v)-1,:);
    mdistMat(i,v) = MahalanobisDistance(X,Y);
    w = w+popSizeVec(1,v);
     if w == size(scaledResult2,1)
         break;
     end
end
 j = j+popSizeVec(1,i);
     if j == size(scaledResult2,1)
         break;
     end
     save('centroids.mat', 'centroids')
end
 mdistMat
end
 
function d=MahalanobisDistance(A, B) 
% Return mahalanobis distance of two data matrices 
% A and B (row = object, column = feature) 
% @author: Kardi Teknomo 
% http://people.revoledu.com/kardi/index.html 
[n1, k1]=size(A); 
[n2, k2]=size(B); 
n=n1+n2; 
if(k1~=k2) 
    disp('number of columns of A and B must be the same') 
else 
    xDiff=mean(A)-mean(B);       % mean diff row vector 
    cA=Covariance(A); 
    cB=Covariance(B); 
    pC=n1/n*cA+n2/n*cB;           % pooled covariance matrix 
    %pcA = grpstats(scaledResult2,tag);
    %pcA = cov(scaledResult2-pcA(tag,:)); %pooled within group covariance matrix from http://www.mathworks.com/matlabcentral/newsreader/view_thread/75379
    %test = Covariance(scaledResult2-pcA(tag,:));
    d=sqrt(xDiff*inv(pC)*xDiff');   % mahalanobis distance 
    %d = sqrt(xDiff*inv(pcA)*xDiff');
end
end
function C=Covariance(X) 
% Return covariance given data matrix X (row = object, column = feature) 
% @author: Kardi Teknomo 
% http://people.revoledu.com/kardi/index.html 
[n,k]=size(X); 
Xc=X-repmat(mean(X),n,1);  % centered data 
C=Xc'*Xc/n;                           % covariance
end
function mdscalePlot(varargin)

fh = figure;


%create this colormap that matches Jason's colors

%hex=['#d95f0e';'#2ca25f';'#fec44f'; '#bf812d'; '#edf8b1'; '#7bccc4'; '#c994c7'; '#fa9fb5'; '#7a0177';'#e31a1c';'#08589e'];
%Col=sscanf(hex', '#%2x%2x%2x',[3,size(hex,1)]).' / 255


hex=['#d95f0e';'#2ca25f';'#fec44f'; '#bf812d'; '#edf8b1'; '#7bccc4'; '#c994c7'; '#fa9fb5'; '#7a0177'];
Col=sscanf(hex', '#%2x%2x%2x',[3,size(hex,1)]).' / 255

%color map for P0 present, P0 absent, and hybrid zone
%hex=['#c7e9b4';'#fec44f';'#0c2c84']
%Col=sscanf(hex', '#%2x%2x%2x',[3,size(hex,1)]).' / 255


startIdx = nan(9,1);
endIdx = nan(9,1);
for idx = 1:length(num_pop)
    startIdx(num_pop(idx)) = find(values ==num_pop(idx),1,'first');
    endIdx(num_pop(idx)) = find(values ==num_pop(idx),1,'last');
end
if length(find(num_pop == 1)) ~= 0
    hold on
  plot(scaledResult2(startIdx(1):endIdx(1),1),scaledResult2(startIdx(1):endIdx(1),2),'o','Markerfacecolor',Col(1,:), 'MarkerEdgeColor',Col(1,:))  
end
if length(find(num_pop == 2)) ~= 0
    hold on
  plot(scaledResult2(startIdx(2):endIdx(2),1),scaledResult2(startIdx(2):endIdx(2),2),'o','Markerfacecolor',Col(2,:), 'MarkerEdgeColor',Col(2,:))
end
if length(find(num_pop == 3)) ~= 0
    hold on
  plot(scaledResult2(startIdx(3):endIdx(3),1),scaledResult2(startIdx(3):endIdx(3),2),'o','Markerfacecolor',Col(3,:), 'MarkerEdgeColor',Col(3,:))
end
if length(find(num_pop == 4)) ~= 0
    hold on 
 plot(scaledResult2(startIdx(4):endIdx(4),1),scaledResult2(startIdx(4):endIdx(4),2),'o','Markerfacecolor',Col(4,:), 'MarkerEdgeColor',Col(4,:))
end
if length(find(num_pop == 5)) ~= 0
    hold on 
 plot(scaledResult2(startIdx(5):endIdx(5),1),scaledResult2(startIdx(5):endIdx(5),2),'o','Markerfacecolor',Col(5,:), 'MarkerEdgeColor',Col(5,:))
end
if length(find(num_pop == 6)) ~= 0
    hold on 
 plot(scaledResult2(startIdx(6):endIdx(6),1),scaledResult2(startIdx(6):endIdx(6),2),'o','Markerfacecolor',Col(6,:), 'MarkerEdgeColor',Col(6,:))
end
if length(find(num_pop == 7)) ~= 0
    hold on 
 plot(scaledResult2(startIdx(7):endIdx(7),1),scaledResult2(startIdx(7):endIdx(7),2),'o','Markerfacecolor',Col(7,:), 'MarkerEdgeColor',Col(7,:))
end
if length(find(num_pop == 8)) ~= 0
    hold on 
 plot(scaledResult2(startIdx(8):endIdx(8),1),scaledResult2(startIdx(8):endIdx(8),2),'o','Markerfacecolor',Col(8,:), 'MarkerEdgeColor',Col(8,:))
end
if length(find(num_pop == 9)) ~= 0
    hold on 
 plot(scaledResult2(startIdx(9):endIdx(9),1),scaledResult2(startIdx(9):endIdx(9),2),'o','Markerfacecolor',Col(9,:), 'MarkerEdgeColor',Col(9,:))
%end
%if length(find(num_pop == 10)) ~= 0
%    hold on 
% plot(scaledResult2(startIdx(10):endIdx(10),1),scaledResult2(startIdx(10):endIdx(10),2),'o','Markerfacecolor',Col(10,:), 'MarkerEdgeColor',Col(10,:))
%end
%if length(find(num_pop == 11)) ~= 0
%    hold on 
% plot(scaledResult2(startIdx(11):endIdx(11),1),scaledResult2(startIdx(11):endIdx(11),2),'o','Markerfacecolor',Col(11,:), 'MarkerEdgeColor',Col(11,:))
hold off
end

dcm = datacursormode(fh);
datacursormode on
set(dcm,'updatefcn',{@myfunction,varargin})

end
%add partial legend (not centroids); will have to add Bale!
f=get(gca, 'Children');
f=flipud(f);
legend([f(1),f(2),f(3),f(4),f(5),f(6),f(7),f(8),f(9)], 'Apassa', 'Bale', 'Bambomo', 'Bavavela', 'Bikagala', 'Mouvanga', 'Nyame Pende', 'Okano', 'Songou')

%legend([f(1),f(2),f(3),f(4),f(5),f(6),f(7),f(8), f(9),f(10),f(11)], 'Apassa-hybrid', 'Bale-absent', 'Bambomo-hybrid', 'Bavavela-absent', 'Bikagala-absent', 'Mouvanga-present', 'Nyame Pende-present', 'Okano-present', 'Songou-absent','Bambomo99-hybrid','Mouvanga99-present')

%legend([f(1),f(2),f(3),f(4),f(5),f(6),f(7),f(8), f(9),f(10),f(11)], 'Apassa', 'Bale', 'Bambomo', 'Bavavela', 'Bikagala', 'Mouvanga', 'Nyame Pende', 'Okano', 'Songou','Bambomo99','Mouvanga99')
%legend([f(1),f(2),f(3),f(4),f(5),f(6),f(7),f(8)], 'Apassa', 'Bambomo09', 'Bavavela', 'Bikagala', 'Mouvanga09','Songou','Bambomo99','Mouvanga99')
  
    function output_txt = myfunction(obj,event_obj,varargin)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

 pos = get(event_obj,'Position');
idx = find(scaledResult2(:,1)== pos(1));
 fish = sortedFishID(idx);
output_txt = {['X: ',num2str(pos(1),4)],...
    ['Y: ',num2str(pos(2),4)]};
if ~isempty(fish)
     output_txt{end+1} = ['Fish ID: ',num2str(fish)];
end
% If there is a Z-coordinate in the position, display it as well
if length(pos) > 2
    output_txt{end+1} = ['Z: ',num2str(pos(3),4)];
end

    end
end


