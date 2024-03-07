function [velocity, breakTemperature] = TruckModel(alpha, breakTemperature, breakPressure, gear, velocity, deltaTime,maxValue,M,tau,ch,g,Cb,Tamb)
Feb = Cb*[7, 5, 4, 3, 2,5, 2, 1.6, 1.4, 1,2 1];
Fb = CalculateFb(maxValue,M,g,breakTemperature, breakPressure);
Fg = M*g*sind(alpha);
vDot = (Fg - Fb - Feb(gear))/M;

velocity = vDot*deltaTime + velocity;
breakTemperature = CalculateTemp(tau,ch,Tamb,breakTemperature, breakPressure, deltaTime) ; 

function Fb = CalculateFb(maxValue,M,g,breakTemperature, breakPressure)
    if (breakTemperature < maxValue.breakTemperature-100)
        Fb = breakPressure * M*g/20;
    else
        Fb = breakPressure * M*g/20*exp((maxValue.breakTemperature-breakTemperature-100)/100);
    end
end

function T = CalculateTemp(tau,ch,Tamb,breakTemperature, breakPressure, deltaTime)  
    if breakPressure < 0.01
        T =  breakTemperature -(breakTemperature-Tamb)/tau *deltaTime;
    else
        T = breakTemperature+ch*breakPressure *deltaTime;
    end
end
end