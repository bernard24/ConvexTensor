function [ y ] = proj2sorted( x )
% This function projects x onto the monotone cone.
% Therefore, the output y has all its elements sorted in non increasing
% order. For more information about this, see Appendix D.

y=x;
d=length(x);

forest=[1:d];
forestBefore=[0:d-1];
forestValues=x;
forestCard=ones(1,d);

for pos=1:d-1
    while forestValues(pos)<forestValues(pos+1) && forest(pos)~=forest(pos+1)
        cardAux=forestCard(pos+1)+forestCard(pos);
        rightDist=(forestValues(pos+1)-forestValues(pos))*forestCard(pos+1)/cardAux;
        before=forestBefore(pos);
        if before>0
            leftDist=forestValues(before)-forestValues(pos);
        else
            leftDist=Inf;
        end
        if rightDist<=leftDist
            forestValues(pos+1)=forestValues(pos)+rightDist;
            forest(pos)=pos+1;
            forestCard(pos+1)=cardAux;
            forestBefore(pos+1)=forestBefore(pos);
        else
            forestValues(pos+1)=forestValues(pos+1)-(forestValues(before)-forestValues(pos))*forestCard(pos);
            forestCard(pos)=forestCard(before)+forestCard(pos);
            forestValues(pos)=forestValues(before);
            forest(before)=forest(pos);
            forestBefore(pos)=forestBefore(before);
        end
    end
end
        
%% Third run
for i=d:-1:1
    if forest(i)==i
        y(i)=forestValues(i);
    else
        y(i)=y(forest(i));
    end
end
