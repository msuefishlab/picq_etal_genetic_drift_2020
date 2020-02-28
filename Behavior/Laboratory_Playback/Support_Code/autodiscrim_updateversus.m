function []=autodiscrim_updateversus(clustercount,t,handles)
global version
alpha='';
num1='';
num2='';

if (clustercount==1)
    alpha='A';
elseif (clustercount==2)
    alpha='B';
elseif (clustercount==3)
    alpha='C'; 
elseif (clustercount==4)
    alpha='D';
elseif (clustercount==5)
    alpha='E';
elseif (clustercount==6)
    alpha='F';
end
   
if (version==0)    
if (t==1)
    num1='1';
    num2='1';
elseif (t==2)
    num1='1';
    num2='2';
elseif (t==3)
    num1='1'; 
    num2='X';
elseif (t==4)
    num1='2';
    num2='1';
elseif (t==5)
    num1='X';
    num2='1';
end
elseif (version==1)
if (t==1)
    num1='1';
    num2='1';
elseif (t==2)
    num1='1';
    num2='2';
elseif (t==3)
    num1='1'; 
    num2='X';
elseif (t==4)
    num1='1';
    num2='3';
elseif (t==5)
    num1='2';
    num2='4';
end 
elseif(version==2)
    if (t==1)
    num1='1';
    num2='1';
elseif (t==2)
    num1='1';
    num2='2';
elseif (t==3)
    num1='1'; 
    num2='X';
elseif (t==4)
    num1='1';
    num2='3';
elseif (t==5)
    num1='1';
    num2='4';
end 
end
%strcat(alpha,num1)
%strcat(alpha,num2)

set(handles.textbackground,'String',strcat(alpha,num1));
set(handles.textnovel,'String',strcat(alpha,num2));
disp('Versus should be updated');
  