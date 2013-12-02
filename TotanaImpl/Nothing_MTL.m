classdef Nothing_MTL
    %METHOD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        parameters
        currentParameters
        model
        name='Baseline'
    end
    
    methods
        function obj=Nothing_MTL(parameters, name)
            if nargin>0
                obj.parameters=parameters;
            end
            if nargin>1
                obj.name=name;
            end
        end
        
        function [obj, timeLong, localOutputs] = train(obj, data, outputs)
                        
            timeLong=0;
%             obj.model.predT=data.Tensor;      
            localOutputs=outputs;
        end
        
        function [obj, predY, timeLong] = test(obj, data)
            if ~isfield(data, 'testXCell') || isempty(data.testXCell)
                predY=[];
                timeLong=0;
                return
            end
            testXCell=data.testXCell;
            predY=cell(1, length(testXCell));
            
            tic
            for i=1:length(testXCell)
                X=testXCell{i};
                if ~isempty(X)
                    predY{i}=zeros(size(X,2),1);
                end
            end
            timeLong=toc;
        end
        
        function obj = setParameters(obj, pars)
            obj.currentParameters=obj.parameters;
            nameParameters=fieldnames(pars);
            for i=1:length(nameParameters)
                name=nameParameters{i};
                if isfield(obj.parameters, name) && ~isempty(parameters.(name))
                    obj.currentParameters.(name)=obj.parameters.(name);
                else
                    obj.currentParameters.(name)=pars.(name);
                end
            end
        end
    end
        
end

