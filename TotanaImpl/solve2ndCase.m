function [ w ] = solve2ndCase( v, R, B )
%SOLVE2NDCASE Summary of this function goes here
%   Detailed explanation goes here

w=v;
v2norm=norm(v(1:R-1));
v1norm=norm(v(R:R+B),1);

coeff=zeros(4,1);
coeff(1)=16;
coeff(2)=8*v2norm-4+16*(B+1);
coeff(3)=8*(B+1)*v2norm-4*(B+1)+4*(B+1)^2;
coeff(4)=2*(B+1)^2*v2norm-(B+1)^2-v1norm^2;

lambdaRCands=roots(coeff);
% OJETE
lambdaR=lambdaRCands(3);
lambdaRm1=(0.5-2*lambdaR^2-lambdaR*v2norm)/(v2norm-1+2*lambdaR);

if lambdaR<0 || lambdaRm1<0
%     disp('Lagrangian multipliers below 0.');
%     keyboard
    w=Inf(size(w));
    return;
end

w(1:R-1)=v(1:R-1)/(2*(lambdaR+lambdaRm1)+1);
w(R:R+B)=v1norm/(2*lambdaR+B+1);

end

