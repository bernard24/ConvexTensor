function [ W1Rnorm ] = getW1Rnorm( v, R, A, B )
%GETW1RNORM Summary of this function goes here
%   Detailed explanation goes here

coeff=zeros(5,1);
coeff(1)=-(A+B)^2;
coeff(2)=-2*(A+B)*(2*A+B);
coeff(3)=-A^2-4*A*(A+B)-(A+B)^2 + ((A+B)*norm(v(1:R-A)))^2 + A*norm(v(R-A+1:R+B),1)^2;
coeff(4)=-2*A^2-2*A*(A+B)+2*A*(A+B)*norm(v(1:R-A))^2+2*A*norm(v(R-A+1:R+B),1)^2;
coeff(5)=-A^2+A^2*norm(v(1:R-A))^2+A*norm(v(R-A+1:R+B),1)^2;

W1Rnorm=roots(coeff);

end

