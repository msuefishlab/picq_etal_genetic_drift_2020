%
%   stim1playback_novel_anal.m
%       analyze field novelty response experiments
%

NRorP = input('NR or P analysis? ','s');
[a,b] = size(eodtimes);
if isempty(burstint)==1,
    stimints = [0 genstimsequence('Constant Interval',totalpulsenum,pulseint)];
    novelstart = novelpulsenum;
    novelend = novelpulsenum;
else
    stimints = 0;
    burstseq = [repmat(pulseint,1,9)];
    for i=1:totalpulsenum-1,
        stimints = [stimints burstseq burstint];
    end
    stimints = [stimints burstseq];
    novelstart = ((novelpulsenum-1)*10)+1;
    novelend = novelpulsenum*10;
end
stimints_current = stimints;
if NRorP=='NR',
    bin_size = 500;
    for i=1:a,
        eodtimes_sdf = eodtimes(i,:) + prestimdur;
        [f,d,d2,b] = sdf(eodtimes_sdf,bin_size);
        desired_samples = ceil((prestimdur + pststimdur + sum(stimints)/1000) * 1000);
        if desired_samples>length(f),
            f = [f zeros(1,desired_samples-length(f))];
        elseif desired_samples<length(f),
            f = f(1:desired_samples);
        end
        eod_sdf(i,:) = f;
    end
    time_sdf = [1/1000:1/1000:length(eod_sdf)/1000]-prestimdur;
    if a==1,
        mean_sdf = eod_sdf;
        plot(time_sdf,mean_sdf,'k-','LineWidth',2)
    else                
        mean_sdf = mean(eod_sdf);
        std_sdf = std(eod_sdf);
        baseline_start = min(find(time_sdf>=(-prestimdur+(bin_size/1000))));
        baseline_end = max(find(time_sdf<-(bin_size/1000)));
        baseline_mean = mean(mean_sdf(baseline_start:baseline_end));
        baseline_std = std(mean_sdf(baseline_start:baseline_end));
    end
    ylabel('EOD Rate (Hz)','FontSize',12)
    xlabel('Time (s)','FontSize',12)
    xlim([-prestimdur pststimdur + sum(stimints)/1000])
    yl = ylim;
    ylim([0 yl(2)])
    zoom on
    stimtimes = cumsum(stimints);
    burstinds = [1 find(stimints==burstint)];
    burststrt = stimtimes(burstinds);
    burstends = burststrt + (pulseint*9);
    burststrt = burststrt/1000;
    burstends = burstends/1000;
    for i=1:length(burststrt),
        strind = min(find(time_sdf>=burststrt(i)));
        endind = min(find(time_sdf>=burstends(i)+2));
        [sdfpeak(i),peakind(i)] = max(mean_sdf(strind:endind));
        peakind(i) = peakind(i) + strind - 1;
    end
    hold on
    plot(time_sdf(peakind),sdfpeak,'g*')
    hold off
    sdfpeak'
elseif NRorP=='P',
    eodints = [NaN diff(eodtimes)];
    stimtimes = cumsum(stimints);
    burstinds = [1 find(stimints==burstint)];
    burststrt = stimtimes(burstinds);
    burstends = burststrt + (pulseint*9);
    burststrt = burststrt/1000;
    burstends = burstends/1000;
    for i=1:length(burststrt),
        strind = min(find(eodtimes>=burststrt(i)));
        endind = min(find(eodtimes>=burstends(i)+2));
        [maxint(i),maxind(i)] = max(eodints(strind:endind));
        maxind(i) = maxind(i) + strind - 1;
    end
    plot(eodtimes,eodints,'b.',eodtimes(maxind),maxint,'r.')
    ylabel('EOD Interval (s)','FontSize',12)
    xlabel('Time (s)','FontSize',12)
    xlim([-prestimdur pststimdur + sum(stimints)/1000])
    maxint'
else
    error('Must choose NR or P!!!!!')
end
    