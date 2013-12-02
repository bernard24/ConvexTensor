function pick = getLowestPick (pars, fcase, leftR, rightR, estR)

    if leftR>rightR
        pick=fcase(pars, leftR);
        return
    end
    centerR=floor((leftR+rightR)/2);
    if nargin>4
        centerR=estR;
    end
    
    centerSol = fcase(pars, centerR);
    leftSol = fcase(pars, leftR);
    rightSol = fcase(pars, rightR);

    preSols(rightR-leftR+1)=rightSol;
    preSols(centerR-leftR+1)=centerSol;
    preSols(leftR-leftR+1)=leftSol;
    
    while leftSol.index<rightSol.index
        candLeftR=min(floor((leftSol.index+centerSol.index)/2)+1, centerSol.index);
        if isempty(preSols(candLeftR-leftR+1).val)
            preSols(candLeftR-leftR+1) = fcase(pars, candLeftR);
        end
        candLeftSol=preSols(candLeftR-leftR+1);
        if candLeftSol.val<centerSol.val
            rightSol=centerSol;
            centerSol=candLeftSol;
            continue
        end
    
        candRightR=max(floor((rightSol.index+centerSol.index)/2), centerSol.index);
        if isempty(preSols(candRightR-leftR+1).val)
            preSols(candRightR-leftR+1) = fcase(pars, candRightR);
        end
        candRightSol = preSols(candRightR-leftR+1);
        if candRightSol.val<centerSol.val
            leftSol=centerSol;
            centerSol=candRightSol;
            continue
        end
        leftSol=candLeftSol;
        rightSol=candRightSol;
    end
    pick=centerSol;
    
end