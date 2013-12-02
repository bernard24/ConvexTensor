classdef RMSEC
%GROUNDTRUTHLOSS Summary of this function goes here
%   Detailed explanation goes here

properties
    nOutputs=1;
end

methods
    function [score timeLong] = getScore(obj, method, data)
        actuY=data.testYCell;
        [method, predY timeLong]=test(method, data);
        nTasks=length(predY);
        validTest=zeros(1,nTasks);
        testError=zeros(1,nTasks);
        for i=1:nTasks
            if isempty(predY{i})
                continue
            end                
            testError(i)=mean((predY{i} - actuY{i}).^2);
            if ~isnan(testError(i))
                validTest(i)=1;
            end
        end
        testError=testError(validTest==1);
        score=mean(testError);
%         keyboard
    end
end

end