function [ w record recordRAB ] = myProx6( v, lambda, estR )
%MYPROX3 Summary of this function goes here
%   Detailed explanation goes here

w=v;
record=cost(w,v,lambda);    % OJETE
recordRAB=[0 0 0];

d=length(v);
pars.v=v;
pars.lambda=lambda;
centerSol=getLowestPick (pars, @solveCase1ForR, 1, d);

if centerSol.val<record
    w=centerSol.w;
    record=centerSol.val;
    recordRAB=centerSol.rab;
end

for r=1:d        
    for b=0:d-r-1
        auxW=solve2ndCase(v,r,b);
        val=evalProx(auxW, v, lambda, r);
        if val<record
            record=val;
            w=auxW;
            recordRAB=[r NaN b];
        end
    end
end
end

function sol = solveCase1ForR(pars, r)
    d=length(pars.v);    

    sol.val=Inf;
    sol.w=NaN(d,1);
    sol.rab=[r NaN NaN];
    
    pars.r=r;
    sol=getLowestPick (pars, @solveCase1ForRB, 0, d-r-1);
    
    sol.index=r;
    sol.r=r;
end

function sol = solveCase1ForRB(pars, b)
    pars.b=b;
    r=pars.r;
    sol=getLowestPick (pars, @solveCase1ForRBA, 1, r);
    sol.index=b;
end

function [sol] = solveCase1ForRBA (pars, a)
            v=pars.v;
            b=pars.b;
            r=pars.r;
            lambda=pars.lambda;
            
            auxW=v;
            normW=getW1Rnorm( v, r, a, b );
            normW=normW(2);
            auxW(r-a+1:r+b)= norm(v(r-a+1:r+b),1) / (b+a*(1+1/normW));
            auxW(1:r-a)=v(1:r-a) / (1+1/normW);
           
            val=evalProx(auxW, v, lambda, r);
            sol.val=val;
            sol.w=auxW;
            sol.rab=[r a b];
            sol.index=a;
end

function val = evalProx(w, v, lambda, r)
    if issorted(w(end:-1:1))==0
        val=Inf;
        return
    end
    val=cost(w,v,lambda);
end
