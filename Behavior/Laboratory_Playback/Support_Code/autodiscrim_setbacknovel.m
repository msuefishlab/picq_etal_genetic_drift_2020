function [pulsewaveform_b,pulsewaveform_n]= autodiscrim_setbacknovel(pulsewaveform_1,pulsewaveform_2,pulsewaveform_x,trial,pulsewaveform_3,pulsewaveform_4)
pulsewaveform_b=[];
pulsewaveform_n=[];

global version
%version==0

if (version==0)
if(trial==1)%1 vs 1
    pulsewaveform_b=pulsewaveform_1;
    pulsewaveform_n=pulsewaveform_1;
    disp('1 vs 1');
elseif(trial==2)%1 vs 2
    pulsewaveform_b=pulsewaveform_1;
    pulsewaveform_n=pulsewaveform_2;   
    disp('1 vs 2');
elseif(trial==3)%1 vs x
    pulsewaveform_b=pulsewaveform_1;
    pulsewaveform_n=pulsewaveform_x;
    disp('1 vs x');
elseif(trial==4)%2 vs 1
    pulsewaveform_b=pulsewaveform_2;
    pulsewaveform_n=pulsewaveform_1;
    disp('2 vs 1');
elseif(trial==5)%x vs 1
    pulsewaveform_b=pulsewaveform_x;
    pulsewaveform_n=pulsewaveform_1;
    disp('x vs 1');
end
elseif(version==1)
   if(trial==1)%1 vs 1
    pulsewaveform_b=pulsewaveform_1;
    pulsewaveform_n=pulsewaveform_1;
    disp('1 vs 1');
elseif(trial==2)%1 vs 2
    pulsewaveform_b=pulsewaveform_1;
    pulsewaveform_n=pulsewaveform_2;   
    disp('1 vs 2');
elseif(trial==3)%1 vs x
    pulsewaveform_b=pulsewaveform_1;
    pulsewaveform_n=pulsewaveform_x;
    disp('1 vs x');
elseif(trial==4)%1 vs 3
    pulsewaveform_b=pulsewaveform_1;
    pulsewaveform_n=pulsewaveform_3;
    disp('1 vs 3');
elseif(trial==5)%2 vs 4
    pulsewaveform_b=pulsewaveform_2;
    pulsewaveform_n=pulsewaveform_4;
    disp('2 vs 4'); 
   end
elseif(version==2)
 if(trial==1)%1 vs 1
    pulsewaveform_b=pulsewaveform_1;
    pulsewaveform_n=pulsewaveform_1;
    disp('1 vs 1');
elseif(trial==2)%1 vs 2
    pulsewaveform_b=pulsewaveform_1;
    pulsewaveform_n=pulsewaveform_2;   
    disp('1 vs 2');
elseif(trial==3)%1 vs x
    pulsewaveform_b=pulsewaveform_1;
    pulsewaveform_n=pulsewaveform_x;
    disp('1 vs x');
elseif(trial==4)%1 vs 3
    pulsewaveform_b=pulsewaveform_1;
    pulsewaveform_n=pulsewaveform_3;
    disp('1 vs 3');
elseif(trial==5)%1 vs 4
    pulsewaveform_b=pulsewaveform_1;
    pulsewaveform_n=pulsewaveform_4;
    disp('1 vs 4'); 
   end
end