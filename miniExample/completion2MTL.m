function [dataConf DataParameters] = completion2MTL(~, DataParameters)
%COMPLETION2MTL Summary of this function goes here
%   Detailed explanation goes here

[dataConf DataParameters] = makeData([], DataParameters);

WTensor=dataConf.originalTensor;
noisyWTensor=dataConf.Tensor;
KnownInputs=dataConf.KnownInputs;

dimensions=size(WTensor);
nAttrs=dimensions(1);
nTasks=prod(dimensions(2:end));
W=double(reshape(WTensor, [nAttrs, nTasks]));
noisyW=double(reshape(noisyWTensor, [nAttrs, nTasks]));
knowns=double(reshape(KnownInputs, [nAttrs, nTasks]));

trainYCell=cell(1,nTasks);
trainXCell=cell(1,nTasks);
testYCell=cell(1,nTasks);
testXCell=cell(1,nTasks);

for i=1:nTasks
    knownT=knowns(:,i);
    present=find(knownT);
    nInstances=length(present);
    X=zeros(nAttrs, nInstances);
    Y=zeros(nInstances, 1);
    for j=1:length(present)
        X(present(j), j)=1;
        Y(j)=noisyW(present(j),i);
    end
    
    present=find(knownT==0);
    nInstances=length(present);
    XTest=zeros(nAttrs, nInstances);
    YTest=zeros(nInstances, 1);
    for j=1:length(present)
        XTest(present(j), j)=1;
        YTest(j)=W(present(j),i);
    end
    
%     XTest=eye(nAttrs);
%     YTest=W(:,i);
    
    trainYCell{i}=Y;
    trainXCell{i}=X;
    testYCell{i}=YTest;
    testXCell{i}=XTest;
end

dataConf.trainXCell=trainXCell;
dataConf.trainYCell=trainYCell;
dataConf.testXCell=testXCell;
dataConf.testYCell=testYCell;
% dataConf.validation_testXCell=validationXCell;
% dataConf.validation_testYCell=validationYCell;
dataConf.W=W;
dataConf.WTensor=WTensor;
dataConf.indicators=dimensions;

end
