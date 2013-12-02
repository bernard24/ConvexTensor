function projv = proj2conj( v, lambda )
%PROJ2CONJ Summary of this function goes here
%   Detailed explanation goes here

w=v(1:end-1);
z=v(end);

d=length(w);
auxNorm2=0;
record=0;
    
for r=1:d
    auxNorm2=auxNorm2+w(r)^2;
    auxRVal=sqrt(auxNorm2)-lambda*r;
    if record<auxRVal
        record=auxRVal;
        recordR=r;
    end
%     if auxRVal<=previousRVal
%         bestRVal=previousRVal;
%         bestR=r-1;
%         break
%     end
%     previousRVal=auxRVal;
end
