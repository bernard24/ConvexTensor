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
        testError=[];
        for i=1:nTasks
            if isempty(predY{i})
                continue
            end                
            testError=[testError; (predY{i} - actuY{i}).^2 ];
        end
        score=mean(testError)
%         keyboard
    end
end

end