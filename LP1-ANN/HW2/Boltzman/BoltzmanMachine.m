%% Boltzman machine
clc, clear all

% Settings%%%%%%%%%%%%%%%%%%%%%%%%%
eta = 0.002;
nTrials = 10; % 1000 run with 2000
nEpochs = 10; % 20
nCdk = 30; % 20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Initializing
input = [-1 -1 -1; 1 -1 1; -1 1 1; 1 1 -1];
data = dec2bin(0:7)-'0';
data(data == 0) = -1;
pData = [1/4 0 0 1/4 0 1/4 1/4 0];

ProbDistr = zeros(4, length(data));
Miteration = 0;

for M = [1 2 4 8]
PB = zeros(1, length(data));
w = normrnd(0, 1,[M, size(input,2)]);
w(1:1+size(w,1):end) = 0;
thetaV = zeros(1,size(input,2));
thetaH = zeros(1,M);
Miteration = Miteration +1;

for i = 1:nTrials
    dw = zeros(M, size(input,2));
    dthetaV = zeros(1, size(input,2));
    dthetaH = zeros(1,M);
    
    for j = 1:nEpochs
        v0 = input(randi([1 size(input, 1)]),:);
        bh0 = (w * v0') - thetaH';
        P = 1./(1 + exp(-2*bh0));        
        h = UpdateNeuron(M, P);     
        
        for cdk = 1:nCdk
            bv = (h'*w) - thetaV;
            P = 1./(1 + exp(-2*bv));            
            v = UpdateNeuron(size(input,2), P)'; 
            
            bh = (w * v') - thetaH';
            P = 1./(1 + exp(-2*bh));
            h = UpdateNeuron(M, P);
        end
        dw = dw + eta * (tanh(bh0)*v0-tanh(bh)*v);
        dthetaV =  dthetaV  -eta * (v0-v);
        dthetaH = dthetaH -eta * (tanh(bh0')-tanh(bh'));
    
    end 
    w = w + dw;
    thetaV = thetaV + dthetaV;
    thetaH = thetaH + dthetaH;
end


Nout = 3000;
Nin = 2000;

for outer = 1:Nout
    r = randi([1 length(data)]);
    v = data(r,:);
    bh = (w * v') - thetaH;
    P = 1./(1 + exp(-2*bh)); 
    h = UpdateNeuron(M, P);
    
    for inner = 1:Nin 
        bv = (h'*w) - thetaV;
        P = 1./(1 + exp(-2*bv));
        v = UpdateNeuron(size(input,2), P).';
        
        bh = (w * v') - thetaH';
        P = 1./(1 + exp(-2*bh));        
        h = UpdateNeuron(M, P);
         for j = 1:length(data)
                if isequal(v, data(j,:))
                    PB(j) = PB(j) + 1;
                end
         end
    end
    outer
end
ProbDistr(Miteration,:) = PB/(Nin*Nout);
end

%%

clf
pData =      [1/4       0         0         1/4       0         1/4      1/4        0];
Saved from a run in first cell
ProbDistr = [0.1236    0.1318    0.1137    0.1256    0.1428    0.1515    0.1003    0.1109; ... 
             0.2409    0.0001    0.0001    0.1696    0.0000    0.5892         0    0.0001; ... 
             0.3215    0.0000    0.0001    0.2182    0.0001    0.1984    0.2617    0.0000; ...
             0.2120    0.0013    0.0013    0.1897    0.0012    0.2939    0.3000    0.0007];
         
DKL = zeros(4,8);
for M = 1:4
    for r = 1:8
        if ProbDistr(M,r) == 0 && pData(r) == 0
            DKL(M,r) = 0;
        elseif pData(r) == 0
            DKL(M,r) = pData(r).*(0-log(ProbDistr(M,r)));
        elseif ProbDistr(M,r) == 0
            DKL(M,r) =  pData(r).*(log(pData(r)));  
        else
            DKL(M,r) =  pData(r).*(log(pData(r))-log(ProbDistr(M,r)));
        end
    end
end

hold on
x = 0:0.02:9;
KL = log(2)*(size(input,2) - (fix(log2(x+1)))-(x+1)./(2.^fix((log2(x+1)))));
KL(KL<0) = 0;
plot(x,KL)
DKL = abs(sum(DKL,2))
plot([1 2 4 8],DKL,'O','color', 'red')
xlabel('M')
ylabel('D_{KL}')
legend({'Upper bound','Numerical estimates'},'Location','northeast')
hold off


function h = UpdateNeuron(M, P)
    h = zeros(M,1);
    for k = 1:M
        if rand < P(k)
            h(k) = 1;
        else
            h(k) = -1;
        end
    end  
end





