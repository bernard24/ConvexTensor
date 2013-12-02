function [ c recordW r ] = prox( v, lambda )
%PROX Summary of this function goes here
%   Detailed explanation goes here

d=length(v);
recordW=v;
bestR=0;
found=0;
for r=0:d
    auxW=opt(v,r);
    [c ar] = cost_eff ( auxW, v, lambda );
%     [r ar]
    if r<=ar
        bestR=r;
        if r==ar
            recordW=auxW;
            found=1;
        end
        break
    end
end

if found==0
    recordW=opt2(v,bestR);
end

[c r] = cost_eff( recordW, v, lambda );    
end

function w = opt2(v,r)

stepsize=0.001;
d=length(v);
va=v(1:r);
vrp1=v(r+1);
vb=v(r+2:d);
w=v;
w= proj2sorted( w );
lastW=Inf(d,1);

%     keyboard
while norm(lastW-w)>10^-9
    lastW=w;
    wa=w(1:r);
    wb=w(r+2:d);
    
    wa=wa-stepsize*(wa*(1+2/norm(wa) -vrp1/(norm(wa)*sqrt(2*norm(wa) +1)) )-va);
    wb=wb-stepsize*(wb-vb);
    wrp1=sqrt(2*norm(wa)+1);
    w=[wa;wrp1;wb];
    w= proj2sorted( w );
end

end

function w = opt(v,r)

if r==0
    w=v;
end
stepsize=0.001;
d=length(v);
va=v(1:r);
vb=v(r+1:d);
w=v;
w= proj2sorted( w );
lastW=Inf(d,1);

while norm(lastW-w)>10^-9
    lastW=w;
    wa=w(1:r);
    wb=w(r+1:d);
    
    wa=wa-stepsize*(wa*(1+1/norm(wa))-va);
    wb=wb-stepsize*(wb-vb);
    w=[wa;wb];
    w= proj2sorted( w );
end

end

