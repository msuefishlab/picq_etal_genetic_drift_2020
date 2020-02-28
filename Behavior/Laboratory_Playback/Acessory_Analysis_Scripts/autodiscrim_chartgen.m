function [ones,twos,threes,fours,fives]=autodiscrim_chartgen()

global stimints burstint1 pulseint1 time_sdf burstn1 nvburstn1

[expername, experpath] = uigetfile('*.mat', 'Open experimental data file...');
load (fullfile(experpath,expername), '-mat');






j=[1:30]';

    stimtimes = cumsum(stimints);
    burstinds = [1 find(stimints==burstint1)];           
    burststrt = stimtimes(burstinds);                   
    burstends = burststrt + (pulseint1*9);                   
    burststrt = burststrt/1000;                        
    burstends = burstends/1000;    
    esdf=sdfcalc(stimints,burstint1,pulseint1,burstn1,nvburstn1,eodtimes,preint,bin_size);
    
    
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


ones=[fulldeltavg0sdf(1,:);fulldeltavg0sdf(6,:);fulldeltavg0sdf(11,:);fulldeltavg0sdf(16,:);fulldeltavg0sdf(21,:);fulldeltavg0sdf(26,:)]
i=2;twos=[fulldeltavg0sdf(i,:);fulldeltavg0sdf(i+5,:);fulldeltavg0sdf(i+10,:);fulldeltavg0sdf(i+15,:);fulldeltavg0sdf(i+20,:);fulldeltavg0sdf(i+25,:)]
i=3;threes=[fulldeltavg0sdf(i,:);fulldeltavg0sdf(i+5,:);fulldeltavg0sdf(i+10,:);fulldeltavg0sdf(i+15,:);fulldeltavg0sdf(i+20,:);fulldeltavg0sdf(i+25,:)]
i=4;fours=[fulldeltavg0sdf(i,:);fulldeltavg0sdf(i+5,:);fulldeltavg0sdf(i+10,:);fulldeltavg0sdf(i+15,:);fulldeltavg0sdf(i+20,:);fulldeltavg0sdf(i+25,:)]
i=5;fives=[fulldeltavg0sdf(i,:);fulldeltavg0sdf(i+5,:);fulldeltavg0sdf(i+10,:);fulldeltavg0sdf(i+15,:);fulldeltavg0sdf(i+20,:);fulldeltavg0sdf(i+25,:)]



figure(3);errorbar(mean(threes)',std(threes,[],1)/sqrt(6),'k');hold on; plot(threes');title('Threes-0sdf')
figure(4);errorbar(mean(fours)',std(fours,[],1)/sqrt(6),'k');hold on; plot(fours');title('PK3-Fours-0sdf')
figure(5);errorbar(mean(fives)',std(fives,[],1)/sqrt(6),'k');hold on; plot(fives');title('PK3-Fives-0sdf')
figure(3);errorbar(mean(threes)',std(threes,[],1)/sqrt(6),'k');hold on; plot(threes');title('PK3-Threes-0sdf')
figure(2);errorbar(mean(twos)',std(twos,[],1)/sqrt(6),'k');hold on; plot(twos');title('PK3-Twos-0sdf')
figure(1);errorbar(mean(ones)',std(ones,[],1)/sqrt(6),'k');hold on; plot(ones');title('PK3-Ones-0sdf')
figure(1); legend('Mean','A','B','C','D','E','F')
figure(2); legend('Mean','A','B','C','D','E','F')
figure(3); legend('Mean','A','B','C','D','E','F')
figure(4); legend('Mean','A','B','C','D','E','F')
figure(5); legend('Mean','A','B','C','D','E','F')
figure(6); legend('Mean','A','B','C','D','E','F')



function [esdf]=sdfcalc(stimints,burstint1,pulseint1,burstn1,nvburstn1,eodtimes2,preint1,bin_size)
%%%%%%%%%%%%%%%modifed from stim1playback_novel_anal  (B. Carlson)%%%%%%%%%%%%%
counter=[];

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
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%