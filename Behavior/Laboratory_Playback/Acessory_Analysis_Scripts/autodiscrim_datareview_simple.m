clear all
close all

[filename_wavestimA1, pathname_wavestimA1] = uigetfile('*.mat', 'Open data file...');
load (fullfile(pathname_wavestimA1,filename_wavestimA1), '-mat');

[a,b] = size(eodtimes);

[c,d]=size(eodtimes(1:5,2:b)')
[e,f]=size(diff(eodtimes(1:5,1:b)'))

if (0)

figure (1)
plot(eodtimes(1:5,2:b)',diff(eodtimes(1:5,1:b)')*1000,'.')
ylabel('EOD interval (ms)','FontSize',12)
xlabel('Time (s)','FontSize',12)
yl = ylim;
ylim([0 yl(2)]); zoom on;
title('Plot of Cluster A')

figure (2)
plot(eodtimes(6:10,2:b)',diff(eodtimes(6:10,1:b)')*1000,'.')
ylabel('EOD interval (ms)','FontSize',12)
xlabel('Time (s)','FontSize',12)
yl = ylim;
ylim([0 yl(2)]); zoom on;
title('Plot of Cluster B')

figure (3)
plot(eodtimes(11:15,2:b)',diff(eodtimes(11:15,1:b)')*1000,'.')
ylabel('EOD interval (ms)','FontSize',12)
xlabel('Time (s)','FontSize',12)
yl = ylim;
ylim([0 yl(2)]); zoom on;
title('Plot of Cluster C')

figure (4)
plot(eodtimes(16:20,2:b)',diff(eodtimes(16:20,1:b)')*1000,'.')
ylabel('EOD interval (ms)','FontSize',12)
xlabel('Time (s)','FontSize',12)
yl = ylim;
ylim([0 yl(2)]); zoom on;
title('Plot of Cluster D')

figure (5)
plot(eodtimes(21:25,2:b)',diff(eodtimes(21:25,1:b)')*1000,'.')
ylabel('EOD interval (ms)','FontSize',12)
xlabel('Time (s)','FontSize',12)
yl = ylim;
ylim([0 yl(2)]); zoom on;
title('Plot of Cluster E')

figure (6)
plot(eodtimes(26:30,2:b)',diff(eodtimes(26:30,1:b)')*1000,'.')
ylabel('EOD interval (ms)','FontSize',12)
xlabel('Time (s)','FontSize',12)
yl = ylim;
ylim([0 yl(2)]); zoom on;
title('Plot of Cluster F')
end

selector=19;
figure (6)
plot(eodtimes(selector,2:b)',diff(eodtimes(selector,1:b)')*1000,'.')
ylabel('EOD interval (ms)','FontSize',12)
xlabel('Time (s)','FontSize',12)
yl = ylim;
ylim([0 yl(2)]); zoom on;



alpha=1;
while (alpha<31)
figure (7)
plot(eodtimes(alpha,2:b)',diff(eodtimes(alpha,1:b)')*1000,'.')
ylabel('EOD interval (ms)','FontSize',12)
xlabel('Time (s)','FontSize',12)
yl = ylim;
ylim([0 yl(2)]); zoom on;
title(alpha)
pause
alpha=alpha+1;
end


beta=[1 6 11 16 21 26];
while (beta(1)<6)
figure (7)
plot(eodtimes(beta,2:b)',diff(eodtimes(beta,1:b)')*1000,'.')
ylabel('EOD interval (ms)','FontSize',12)
xlabel('Time (s)','FontSize',12)
yl = ylim;
ylim([0 yl(2)]); zoom on;
pause
beta=beta+1;
end


