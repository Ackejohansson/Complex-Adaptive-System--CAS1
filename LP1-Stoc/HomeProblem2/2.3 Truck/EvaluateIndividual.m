function fitness = EvaluateIndividual(breakTemperature, gear, velocity, deltaTime,M,tau,ch,g,Tamb, nIn, iDataSet, maxValue, wIH,wHO,cb,velMin)
gearColdoown = 2;
fitness = 0;
    if iDataSet == 1
        nSlopes = 10;
    elseif iDataSet == 2 || iDataSet == 2
        nSlopes = 5;
    end

    for iSlope = 1:nSlopes 
        position = 0;
        sumVel = 0;
        time = 0;
        notViolatingConstraints = true;   
        lastGearChange = 0;
        velocity = 20;
        alpha = 5; %GetSlopeAngle(x, iSlope, iDataSet);
        
        while position <= maxValue.position && notViolatingConstraints
            time = time + deltaTime;
            
                                                
            input = [alpha/maxValue.alpha; velocity/maxValue.velocity; breakTemperature/maxValue.breakTemperature];
            
            % Network
            hiddenNeurons = sigmf(wIH(:,1:end-1)*input, [1 0]);
            networkOutput = sigmf(wHO(:,1:end-1)*hiddenNeurons,[1 0]);
            breakPressure = networkOutput(1);
            gearChange = networkOutput(2);
            
            if gearColdoown <= time-lastGearChange
                if gearChange >= 0.7
                    gear = max(gear + 1,maxValue.gear);
                    lastGearChange = time;
                if gearChange <= 0.3
                    gear = max(gear - 1,1);
                    lastGearChange = time;
                end
                end
            end
            [velocity, breakTemperature] = TruckModel(alpha, breakTemperature, breakPressure, gear, velocity, deltaTime,maxValue,M,tau,ch,g,cb,Tamb);
            
            if ((velMin <= velocity <= maxValue.velocity) && (breakTemperature <= maxValue.breakTemperature))
                position = position + velocity*deltaTime;
                sumVel = sumVel + velocity;
            else
                notViolatingConstraints = false;
            end
        end
        velocityAvrage = sumVel/(time*deltaTime);
        fitness = fitness + velocityAvrage * position;
    end
    fitness = fitness/nSlopes;  
end