classdef MLMTL_ConvexL2BallMTL
    %METHOD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        parameters
        currentParameters
        model
        name='L2 Ball'
    end
    
    methods
        function obj=MLMTL_ConvexL2BallMTL(parameters, name)
            if nargin>0
                obj.parameters=parameters;
                obj.currentParameters=obj.parameters;
            end
            if nargin>1
                obj.name=name;
            end
        end
        
        function [obj, timeLong, localOutputs] = train(obj, data, outputs)
            alpha=obj.currentParameters.alpha;
            beta=obj.currentParameters.beta;
            threshold=obj.currentParameters.threshold;
            nIt=obj.currentParameters.nIt;
            
            trainXCell=data.trainXCell;
            trainYCell=data.trainYCell;
            indicators=data.indicators;
            if isfield (data, 'W')
                W=data.W;
                tic
                [ estAllW tensorW ] = MLMTL_ConvexL2Ball( trainXCell, trainYCell, indicators, beta, alpha, nIt, threshold, W );
                timeLong=toc;
            else
                tic
                [ estAllW tensorW ] = MLMTL_ConvexL2Ball( trainXCell, trainYCell, indicators, beta, alpha, nIt, threshold );
                timeLong=toc;
            end
            
            obj.model.allW=estAllW;
            
            localOutputs=tensorW;%outputs{end};
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
                    W=obj.model.allW(:,i);
                    predY{i}=X'*W;
                end
            end
            timeLong=toc;
        end
        
        function obj=setParameters(obj, pars)
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

