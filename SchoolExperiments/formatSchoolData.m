function [dataConf DataParameters] = formatSchoolData(~, DataParameters)
%COMPLETION2MTL Summary of this function goes here
%   Detailed explanation goes here

load ilea567/preSchoolData
dimensions=max(preX');
preY=preY-mean(preY);

%length(preY)/(norm(preY)*prod(dimensions))*2





%keyboard
%preY=preY*length(preY)/(norm(preY)*prod(dimensions)*DataParameters.realAlpha)*2;
preY=preY/70;





percTrain=DataParameters.mPerc;
tasksMarkers=getTasksMarkers(dimensions(2:end));
T=zeros(dimensions);
KnownInputs=zeros(dimensions);
originalT=zeros(dimensions);

nInstances=length(preY);
newOrder=randperm(nInstances);
trainingInstances=floor(percTrain*nInstances);
trainIndexes=newOrder(1:trainingInstances);
testIndexes=newOrder(trainingInstances+1:end);
trainX=preX(:,trainIndexes);
trainY=preY(trainIndexes);
testX=preX(:,testIndexes);
testY=preY(testIndexes);

nAttrs=dimensions(1);
nTasks=prod(dimensions(2:end));

trainYCell=cell(1,nTasks);
trainXCell=cell(1,nTasks);
testYCell=cell(1,nTasks);
testXCell=cell(1,nTasks);


for i=1:nTasks
    bTrain= (trainX(2,:)==tasksMarkers(2,i)) & (trainX(3,:)==tasksMarkers(3,i)) & (trainX(4,:)==tasksMarkers(4,i)) & (trainX(5,:)==tasksMarkers(5,i));
    auxTrainY=trainY(bTrain);
    auxNTrainInstances=length(auxTrainY);
    auxTrainX=zeros(nAttrs, auxNTrainInstances);
    auxRowX=trainX(1,bTrain);
    for j=1:auxNTrainInstances
        auxTrainX(auxRowX(j), j)=1;
    end
    
    bTest= (testX(2,:)==tasksMarkers(2,i)) & (testX(3,:)==tasksMarkers(3,i)) & (testX(4,:)==tasksMarkers(4,i)) & (testX(5,:)==tasksMarkers(5,i));
    auxTestY=testY(bTest);
    auxNTestInstances=length(auxTestY);
    auxTestX=zeros(nAttrs, auxNTestInstances);
    auxRowX=testX(1,bTest);
    for j=1:auxNTestInstances
        auxTestX(auxRowX(j), j)=1;
    end
    
    trainYCell{i}=auxTrainY;
    trainXCell{i}=auxTrainX;
    testYCell{i}=auxTestY;
    testXCell{i}=auxTestX;
end

dataConf.trainXCell=trainXCell;
dataConf.trainYCell=trainYCell;
dataConf.testXCell=testXCell;
dataConf.testYCell=testYCell;
dataConf.indicators=dimensions;
% keyboard
end

