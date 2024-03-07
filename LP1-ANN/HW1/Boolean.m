%% Boolean function 
clear all, clc
N=2; %3, 4, 5

nTrails = 1e4;
nEpochs = 20;
nu = 0.05;
counter = 0;
ifAdd = 0;
used_bool = zeros(2^2^N,2^N);
possibleValues = [-1,1];

% Creates boolean input for N dim
s=0;
for i = 0:N-1
    s = s + 2^(i);
end
boolean_inputs = (dec2bin(0:s)-'0')';

for trail = 1:nTrails
    boolean_output = possibleValues(randi(length(possibleValues), 2^N, 1));
    if ~ismember(boolean_output, used_bool, 'rows') 
        w = randn(1,N)/sqrt(N);
        theta = zeros(1,2^N);
        
        for epoch = 1:nEpochs
            total_error = 0;
            for i = 1:2^N
                O = sign(sum(w*(boolean_inputs(:,i))) - theta(i));
                error = boolean_output(i) - O;
           
                dw = nu*(boolean_output(i) - O) * boolean_inputs(:,i)';
                w = w + dw;
                dtheta = -nu *(boolean_output(i) - O);
                theta = theta + dtheta;
           
                total_error = total_error + abs(error);
            end
            if total_error == 0
                counter = counter +1;
                break
            end          
        end
        ifAdd = ifAdd + 1;
        used_bool(ifAdd,:) = boolean_output;
    end
end