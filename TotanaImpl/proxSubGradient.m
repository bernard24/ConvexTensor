function [ record bestW bestR ] = proxSubGradient( y, prew, beta, alpha )
% This function is based on the projected subgradient method to calculate
% the proximal operator of the conjugate of the cardinality in the \ell_2
% ball of radius alpha. For more information about this, look at Algorithm
% 1 in the paper.
% 
% y: input of the function
% prew: starting point
% beta: positive rational parameter
% alpha: radius of the \ell_2 ball

if nargin<4
    alpha=1;
end
initialStepsize=0.5;
limitCounter=100;

if nargin>1
    w=prew;
else
    w=y;
    w= proj2sorted( w );
end
d=length(y);

[record r] = cost ( w, y, beta, alpha );
bestR=r;
bestW=w;
noNewsCounter=0;

overallCounter=0;
counter=0;
while noNewsCounter<limitCounter 
    counter=counter+1;
    stepsize=initialStepsize/sqrt(counter);
    ya=y(1:r);
    yb=y(r+1:d);
    wa=w(1:r);
    wb=w(r+1:d);
    
    wa=wa-stepsize*(wa*(1+(beta*alpha)/norm(wa))-ya);
    wb=wb-stepsize*(wb-yb);
    w=[wa;wb];
    w= proj2sorted( w );
    [c r] = cost ( w, y, beta, alpha );
    if c<record
        record=c;
        bestW=w;
        bestR=r;
        noNewsCounter=0;
        overallCounter=overallCounter+1;
        if overallCounter>10^6
            disp('josebi')
            break
        end
    else
        noNewsCounter=noNewsCounter+1;
    end
end
% disp(overallCounter)
end

