function [w1,w2,w3,w4,ptsf]=autodiscrim_equalength(w11,w22,w33,w44,pts)

le=length(w11);

if(le==pts)
    w1=w11;
    w2=w22;
    w3=w33;
    w4=w44;
    ptsf=pts;
else
    w1=w11(le/2-.5*pts:le/2+.5*pts-1);
    w2=w22(le/2-.5*pts:le/2+.5*pts-1);
    w3=w33(le/2-.5*pts:le/2+.5*pts-1);
    w4=w44(le/2-.5*pts:le/2+.5*pts-1);
    ptsf=length(w1);
end
