function [c bestR] = cost ( w, y, beta, alpha )
% It calculates the cost of the proximal operator of the conjugate of the
% cardinality on the \ell_2 ball of radius alpha.

    if nargin<4
        alpha=1;
    end
    orderW=sort(abs(w),'descend').^2;
    d=length(w);
    bestR=0;
    bestRVal=0;
    previousRVal=0;
    auxNorm2=0;
    testo=0;
    for r=1:d % We need to get r that maximizes alpha*sqrt(auxNorm2)-r
        auxNorm2=auxNorm2+orderW(r);
        auxRVal=alpha*sqrt(auxNorm2)-r;
        if auxRVal<=previousRVal    % We take advantage of the fact that
            bestRVal=previousRVal;  % this function is concave on r.
            bestR=r-1;
            testo=1;
            break
        end
        previousRVal=auxRVal;
    end
    if testo==0
        bestRVal=previousRVal;
        bestR=d;
    end
    
    c=0.5*norm(w-y)^2 + beta*bestRVal;
end
