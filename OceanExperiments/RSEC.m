classdef RSEC
%GROUNDTRUTHLOSS Summary of this function goes here
%   Detailed explanation goes here

properties
    nOutputs=1;
end

methods
    function [score timeLong] = getScore(obj, method, data)
        oT=data.originalTensor;
        [method, predY timeLong]=test(method, data);
        mkdir Outcome
        save Outcome/video predY
        
        score=norm(oT.data(1:end)-predY.data(1:end))/norm(oT.data(1:end));
    end
end

end