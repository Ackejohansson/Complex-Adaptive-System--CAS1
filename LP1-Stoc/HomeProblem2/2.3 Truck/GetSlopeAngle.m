%%
% iSlope = slope index for trainingset
% iDataSet determines whether the slope under consideration
% belongs to the training set (iDataSet = 1), validation
% set (iDataSet = 2) or the test set (iDataSet = 3).
function alpha = GetSlopeAngle(x, iSlope, iDataSet)

if (iDataSet == 1)                                % Training
 if (iSlope == 1) 
   alpha = 4 + sin(x/100) + cos(sqrt(2)*x/50);    % You may modify this!

elseif (iSlope== 2)
   alpha = 3 + 2*sin(x/50) + cos(sqrt(2)*x/100); 
   elseif (iSlope== 3)
   alpha = 3 + 2*sin(x/50) + cos(sqrt(2)*x/100); 
   elseif (iSlope== 4)
   alpha = 3 + 2*sin(x/50) + cos(sqrt(2)*x/100); 
   elseif (iSlope== 5)
    alpha = 3 + 2*sin(x/50) + cos(sqrt(2)*x/100); 
   elseif (iSlope== 6)
    alpha = 3 + 2*sin(x/50) + cos(sqrt(2)*x/100); 
   elseif (iSlope== 7)
   alpha = 3 + 2*sin(x/50) + cos(sqrt(2)*x/100); 
   elseif (iSlope== 8)
   alpha = 3 + 2*sin(x/50) + cos(sqrt(2)*x/100); 
   elseif (iSlope== 9)
   alpha = 3 + 2*sin(x/50) + cos(sqrt(2)*x/100); 
 elseif (iSlope== 10)
   alpha = 3 + 2*sin(x/50) + cos(sqrt(2)*x/100);  % You may modify this!
 end 
 
 
elseif (iDataSet == 2)                            % Validation
 if (iSlope == 1) 
   alpha = 6 - sin(x/100) + cos(sqrt(3)*x/50);    % You may modify this!
   elseif (iSlope == 2) 
   alpha = 5 + sin(x/50) + cos(sqrt(5)*x/50);
   elseif (iSlope == 3) 
   alpha = 5 + sin(x/50) + cos(sqrt(5)*x/50);
   elseif (iSlope == 4) 
   alpha = 5 + sin(x/50) + cos(sqrt(5)*x/50);
   elseif (iSlope == 5) 
   alpha = 5 + sin(x/50) + cos(sqrt(5)*x/50);    % You may modify this!
 end 
 
 
elseif (iDataSet == 3)                           % Test
 if (iSlope == 1) 
   alpha = 6 - sin(x/100) - cos(sqrt(7)*x/50);   % You may modify this!
elseif (iSlope == 2)
   alpha = 4 + (x/1000) + sin(x/70) + cos(sqrt(7)*x/100); % You may modify this!
 
 elseif (iSlope == 3)
   alpha = 4 + (x/1000) + sin(x/70) + cos(sqrt(7)*x/100); % You may modify this!
 elseif (iSlope == 4)
   alpha = 4 + (x/1000) + sin(x/70) + cos(sqrt(7)*x/100); % You may modify this!
   
% Insert the remaining 3 test set slopes here
 elseif (iSlope == 5)
   alpha = 4 + (x/1000) + sin(x/70) + cos(sqrt(7)*x/100); % You may modify this!
 end
end
