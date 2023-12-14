function u_out = MotorMix(az,wr,wp,wy)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    wm1 = 0.25*az   -0.25*wr    -0.25*wp    -0.25*wy;
    wm2 = 0.25*az   +0.25*wr    +0.25*wp    -0.25*wy;
    wm3 = 0.25*az   +0.25*wr    -0.25*wp    +0.25*wy;
    wm4 = 0.25*az   -0.25*wr    +0.25*wp    +0.25*wy;
    
    u_out = [wm1;wm2;wm3;wm4];
end