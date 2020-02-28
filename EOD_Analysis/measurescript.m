%%%%%%%%%%
%measurescript.m
%finds various landmarks on the eod and plots them together with the eod
%
%modified 3 November 2008, for JRG's study of signal variation in P.
%kingsleyae, based on MEA's code for analyzing variation in P. magnostipes
%reproductive isolation.

f = figure(1);
clf;

%% --normalize current eod---------
normeodp1;								%returns normalized vectors 'time' and 'wave'

%% --calc first derivative---------
ddteod;									%returns vector 'ddtwave'

%%--define zero-xing thresholds---
threshold = 0.0005;
firstforty = wave(1:40);
stddev = std(firstforty);
if stddev > threshold				%if wave too noisy
   threshold = 2*stddev;			%set noise threshold = 2 x std dev
end

%% --initialize landmarks----------
tS0 =0;  vS0 =0;  sS0 =0;			%S0, P0, ZC1 only put out if phase0 exists
tP0 =0;  vP0 =0;
tZC1=0;  vZC1=0;  sZC1=-5;			%set sZC1 to -5 as default against which cond for phase0_pres is tested (below)
tZC2=0;  vZC2=0;  sZC2=40;			%set sZC2 to +40 as default against which cond for phase2_pres is tested (below)
tP2 =0;  vP2 =0;

%% --find P1-----------------------%always present, by definition
ip1 = ivmax;							%index of P1
tP1 = time(ip1);						%time of P1
vP1 = wave(ip1);						%voltage at P1

%% --find T1 and T2----------------%always present
[tmin,istart] = min(time);			%first index of eod
[tmax,iend] = max(time);			%last index of eod
j = istart;
while abs(wave(j))<0.02				%look for first point that deviates >= 2% ptp
   j = j + 1;
end
it1 = j;									%index of T1
tT1 = time(it1);						%time of T1
vT1 = wave(it1);						%voltage at T1
k = iend;
while abs(wave(k))<0.02				%read backwards to find T2 (2% deviation)
   k = k - 1;
end
it2 = k;									%index of T2
tT2 = time(k);							%time of T2
vT2 = wave(k);							%voltage at T2

%% --find S1----------------------%always present, by definition
[sS1,is1] = max(ddtwave(istart:ip1));
%[sS1,itemp] = max(ddtwave(117:ip1));
%is1 = 117 + itemp -1;
tS1 = time(is1);						%time of S1
vS1 = wave(is1);						%voltage at S1

%% --P0 is always assumed to be present: find and measure the area **Modified by JRG******--------

for i = ip1:-1:istart				%start at P1 and read backwards
	if wave(i) < 0	       
        %if wave (i-2)<= baseline	
        izc1 = i;				%index just before wave crosses +threshold
		break;     						%break out of for loop and leave dumpos1 = corrected i
        %end
    end
end

for i=ip1:-1:istart
    if wave(i)<0
        izc1filt=i;
        break
    end
end

tZC1 = time(izc1);				%time of ZC1
vZC1 = wave(izc1);				%voltage at ZC1
sZC1 = ddtwave(izc1);			%slope at ZC1 

width=fix(s_rate*.0005);
markpoint=izc1-width;
ap0=sum(wave(markpoint:izc1))/s_rate;
ap0=ap0/1e-6;

[vP0,ip0] = min(wave(markpoint:izc1)); %attempt to find the minimum
tP0 = time(ip0+markpoint);     %attempt to find the time of minimum


%% --is phase two present?---------%
dumpos1 = iend-1;						%default near end of wave
dumpos2 = iend;						%default at end of wave
dumpos2_present = 0;					%initialize condition for phase2 presence to false
for i = ip1:+1:iend					%start at P1 and read forward
	if wave(i) <= threshold		
   	dumpos1 = i - 1;				%index just before wave crosses +threshold
		break;     						%break out of for loop and leave dumpos1 = corrected i
  	end
end
for i = dumpos1:+1:iend				%start at dumpos1 and read forward
	if wave(i) <= (-threshold)	
     	dumpos2 = i;					%index where wave crosses -threshold
     	dumpos2_present = 1;			%if so, set cond for phase2 presence to true      
     	break;    						%break out of for loop and leave dumpos2 = new i
  	end
end
if dumpos2_present					%if condition true, find ZC2 landmarks
   j = round((dumpos1 + dumpos2)/2);
   if abs(wave(dumpos1))<abs(wave(j))
      izc2=dumpos1;
   elseif abs(wave(dumpos2))<abs(wave(j))
     	izc2=dumpos2;					%these statements check for rounding error
   else									%and find the actual voltage nearest zero-xing
      izc2=j;							%in this (usually) steep voltage transition
   end
  	tZC2 = time(izc2);				%time of ZC2
  	vZC2 = wave(izc2);				%voltage at ZC2
  	sZC2 = ddtwave(izc2);			%slope at ZC2
end
tT2 = time(it2);						%time of T1
vT2 = wave(it2);						%voltage at T1



%% --if present, find P2 & S3------

%[vP2,i] = min(wave(ip1:590));
[vP2,i] = min(wave(ip1:iend));%assume absval vP2 always > absval vP4, when present
ip2 = ip1 + i - 1;
tP2 = time(ip2);					%time of P2

[sS2,j] = min(ddtwave(ip1:ip2));

is2 = ip1 + j - 1;   
tS2 = time(is2);
vS2 = wave(is2);

%% --calculate phase areas---------
p1aT1ZC2  = 0;
p2aZC2T2  = 0;

%% --Area of P1 and P2
p1aT1ZC2  = (sum(wave(it1:izc2)))/s_rate;
p2aZC2T2  = (sum(wave(izc2:it2)))/s_rate;

%% --plot the power spectrum-------
fftstats=fftwave(wave,s_rate);	%call to func that plots power spectr & calcs fftstats
f_low  = fftstats(1);				%lower frequency 3dB down from max
fftmax = fftstats(2);				%frequency with max power
f_high = fftstats(3);				%higher frequency 3dB down from max

%% --plot the eod------------------%same code as in plotwave.m
t1 = -3;
t2 = 3;

% subplot(2,3,1:3)
% set(gcf,'Position', [0 0 1440 900])
% a = plot(time,wave,'b');
% b = get(a,'parent');
% set(b,'box','off', 'Fontname', 'Arial', 'Fontsize', 10);
% set(a,'LineWidth',1);
% xlabel ('ms');
% title([fn '  ' num2str(wavenum)],'fontsize',14);
% ax=axis;
% axis([t1 t2 ax(3) ax(4)]);
% lt=length(wave_text);
% %text(t1+.02*(t2-t1),ax(3)+0.97*(ax(4)-ax(3)),wave_text((1):round(7*lt/12)),'fontsize',12);
% %text(t1+.02*(t2-t1),ax(3)+0.97*(ax(4)-ax(3)),wave_text(1:lt),'fontsize',12);
% hold on;
% plot(time,wave*50,'k');
% 
% %% --plot the landmarks------------
% plot(tT1,vT1,'k+'); %begin and end time landmarks are always present
% text(tT1+.05,vT1,'\leftarrow EOD start', 'HorizontalAlignment','left')
% plot(tT2,vT2,'k+');
% text(tT2+.05,vT2,'\leftarrow EOD end', 'HorizontalAlignment','left')
% plot(tP1,vP1,'r+');					%phase1 landmarks (P1, S1, S2) always present
% text(tP1+.05,vP1,'\leftarrow P1', 'HorizontalAlignment','left')
% plot(tS1,vS1,'r+');
% text(tS1+.05,vS1,'\leftarrow Inflection 1', 'HorizontalAlignment','left')
% plot(tS2,vS2,'r+');
% text(tS2+.05,vS2,'\leftarrow Inflection 2', 'HorizontalAlignment','left')
% 
% plot(tP0,vP0,'r+');
% text(tP0+.05,vP0,'\leftarrow P0', 'HorizontalAlignment','left','Rotation', -30)
% 
% plot(tZC1,vZC1,'k+');
% text(tZC1+.05,vZC1,'\leftarrow Zero Crossing 1', 'HorizontalAlignment','left','Rotation', -30)
% plot(tZC2,vZC2,'k+');
% text(tZC2+.05,vZC2,'\leftarrow Zero Crossing 2', 'HorizontalAlignment','left', 'Rotation', -30)
% plot(tP2,vP2,'r+');
% text(tP2+.05,vP2,'\leftarrow P2', 'HorizontalAlignment','left')
% 
% subplot(2,3,4:5);
% plot(time(istart:iend),wave(istart:iend),'k')
% hold on;
% %plot(time(istart:izc1),wave(istart:izc1),'r')
% x=time(izc1-width:izc1);
% y=rot90(wave(izc1-width:izc1));
% areashade(x,y,0,'r','h')
% areashade(x,y,0,'g','l')
% mark=plot(tP0,vP0,'ok');
% set(mark,'MarkerSize',15);
% axis( [ time(izc1)-1 (time(izc1)+1) -2e-3 2e-3])
% hold off;
