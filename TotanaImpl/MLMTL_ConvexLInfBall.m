function [ W tensorW ] = MLMTL_ConvexLInfBall( X, Y, indicators, beta, gamma, outerNiTPre, ~, groundW )
% This function solves a multilinear multitask learning problem in which 
% the regularizer is given by the average of the trace norm of the
% matricizations of the tensor.
% Any tensor completion problem can be cast into a multitask learning
% problem. For more information about it, check the function completion2MTL
% in OceanExperiments
%
% In the following we assume that there are T tasks in total and that the
% input data has d dimensionality, thus the learning vector has a total of 
% d x T elements.
%
% X: It is a cell array with as many cells as tasks. In cell t there is a
%    (d x n_t) matrix containing the training instances for that task. In a
%    tensor completion problem, each of the columns should be indicator
%    vectors of the form [0, 0..., 1..., 0, 0].
% Y: It is also a cell array with as many cells as tasks. In cell t there
%    is a n_t vector with the training labels for that task.
% indicators: It is a vector denoting the size of the weight tensor, where 
%    the first number should be d, and the others should be the numbers of 
%    elements in each mode of the tensor, such that their product is T.
%    Note that the order of the elements in indicator should match the way 
%    the data in X and Y is organized. Check experiments folders for
%    examples.
% beta: parameter of ADMM (see eq. 9 in the paper). It can take any
%    positive real value.
% gamma: parameter that ponders the importance of the regularizer. It can
%    take any positive real value.
% outerNiTPre: Maximum number of iterations of the algorithm. Default value
%    is 1000.
% groundW: tensor ground truth, in case this is available. It is only used
%    to compute the real error in each iteration.


outerNiT=1000;
if nargin>5 && ~isempty(outerNiTPre)
    outerNiT=outerNiTPre;
end

nTotalTasks=length(Y);
nAttrs=getNAttrs(X);
nModes=length(indicators);

if nTotalTasks~=prod(indicators(2:end))
    [nTotalTasks prod(indicators(2:end))]
    error('There are inconsistencies between the indicators and the number of tasks.');
end

XX_plus_betaNI=cell(1,nTotalTasks);
XY=cell(1,nTotalTasks);
for t=1:nTotalTasks
    if isempty(X{t})
        XX_plus_betaNI{t}=beta*nModes*eye(nAttrs);
        XY{t}=0;
    else
        XX_plus_betaNI{t}=1/gamma*(X{t}*X{t}')+beta*nModes*eye(nAttrs);
        XY{t}=X{t}*Y{t};
    end
end

A=cell(1,nModes);
B=cell(1,nModes);
for n=1:nModes
    A{n}=tenzeros(indicators);
    B{n}=tenzeros(indicators);
end
sumA=tenzeros(indicators); 
sumB=tenzeros(indicators); 
oldW=Inf(nAttrs, nTotalTasks);
oit=0;
while true    
    oit=oit+1;
    
    % Optimizing over X
    matSumAux=tenmat(sumA, 1) + beta*tenmat(sumB, 1);
    matSumAux=matSumAux.data;
    matW=zeros(nAttrs, nTotalTasks);
    for t=1:nTotalTasks
        matW(:,t)=(XX_plus_betaNI{t})\(1/gamma*XY{t} + matSumAux(:,t));
    end
    W=tensor(reshape(matW, indicators));
   
    sumA=tenzeros(indicators); 
    sumB=tenzeros(indicators); 
    
    for n=1:nModes
        
        % Optimizing over B
        matW=tenmat(W, n);
        matW=matW.data;
        matA=tenmat(A{n},n);
        matA=matA.data;
        matB=shrink(matW-1/beta*matA, 1/beta);
        BTensor=tensor(reshape(matB, [indicators(n), indicators(1:n-1), indicators(n+1:end)]));
        B{n}=permute(BTensor, [2:n, 1, n+1:nModes]);
        sumB=sumB+B{n};
        
        % Optimizing over A
        A{n}=A{n}-beta*(W-B{n});
        sumA=sumA+A{n};
    end
    
    Wmat=tenmat(full(W), 1);
    Wmat=Wmat.data;
    if nargin>7 && ~isempty(groundW)
        disp(['RSE=' num2str(norm(Wmat(1:end)-groundW(1:end))/norm(groundW(1:end)))]);
    end
    if oit>outerNiT
        break
    end
end

tensorW=W;
W=tenmat(full(W), 1);
W=W.data;
end

function M = shrink(A, s)
% This function computes the proximal operator of the function s||.||_{Tr}
% on matrix A

[U L V]=mySVD(A);
eig=diag(L)-s;
eig(eig<0)=0;
eigM=diag(eig);
L(1:size(eigM,1), 1:size(eigM,2))=eigM;
M=U*L*V';
end
